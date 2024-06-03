use anyhow::{Context, Result};
use async_signal::{Signal, Signals};
use futures_lite::prelude::*;
use std::env;
use std::process::exit;
use std::process::Stdio;
use tokio::process::{Command};

fn main() {
    let result = run(env::args()) ;
    match result {
        Ok(()) => {}
        Err(err) => {
            eprintln!("{}", err);
            exit(1);
        }
    }
}


async fn relay_signals(child: i32) -> Result<()> {
    // All termination signals that can be caught
    let mut signals : Signals = Signals::new(&[
        Signal::Term,
        Signal::Int,
        Signal::Quit,
        Signal::Hup,
    ])?;

    while let Some(signal) = signals.next().await {
      let kill = Command::new("kill")
          .args(["-s", &(signal.unwrap() as i32).to_string(), &child.to_string()])
          .stderr(Stdio::null())
          .stdout(Stdio::null())
          .spawn()?.wait().await;
      match kill {
          Ok(_) => { continue; }
          Err(_) => { break; }
      }

    }
    Ok(())
}

fn run(mut args: impl Iterator<Item = String>) -> Result<()> {
    tokio::runtime::Builder::new_multi_thread()
        .enable_all()
        .build()
        .unwrap()
        .block_on(async {
            while let Some(arg) = args.next() {
                if arg == "--" {
                    break;
                }
            }
            let command = args.next().context("comment: no command given")?;
            let command_args: Vec<String> = args.collect();
            let mut child = Command::new(command).args(command_args).spawn().expect("failed to spawn command");
            let relayer = relay_signals(child.id().expect("failed to get child PID") as i32);
            tokio::select! {
                val = child.wait() => {
                    match val {
                        Ok(e) => { exit(e.code().unwrap()) }
                        Err(e) => {
                            println!("{}", e);
                            exit(1)
                        }
                    }
                }
                _ = relayer => {
                    println!("Relayer exited")
                }
            };
            Ok(())
        })
}

#[cfg(test)]
mod test {
    use super::*;
    use std::iter::empty;
    use tempfile::tempdir;

    #[test]
    fn executes_commands() -> Result<()> {
        let dir = tempdir()?;
        run([
            "--",
            "touch",
            dir.path()
                .join("file")
                .as_os_str()
                .to_str()
                .context("impossible")?,
        ]
        .into_iter()
        .map(ToString::to_string))?;
        assert!(dir.path().join("file").exists());
        Ok(())
    }

    #[test]
    fn errors_on_no_command() -> Result<()> {
        let expected = "Err(comment: no command given)";
        assert_eq!(
            format!("{:?}", run(["--"].into_iter().map(ToString::to_string))),
            expected
        );
        assert_eq!(format!("{:?}", run(empty())), expected);
        Ok(())
    }

    #[test]
    fn allows_comments() -> Result<()> {
        let dir = tempdir()?;
        run([
            "my",
            "comment",
            "--",
            "touch",
            dir.path()
                .join("file")
                .as_os_str()
                .to_str()
                .context("impossible")?,
        ]
        .into_iter()
        .map(ToString::to_string))?;
        assert!(dir.path().join("file").exists());
        Ok(())
    }

}
