use anyhow::{Context, Result};
use std::env;
use std::process::exit;
use std::process::Command;

fn main() {
    match run(env::args()) {
        Ok(()) => {}
        Err(err) => {
            eprintln!("{}", err);
            exit(1);
        }
    }
}

fn run(mut args: impl Iterator<Item = String>) -> Result<()> {
    while let Some(arg) = args.next() {
        if arg == "--" {
            break;
        }
    }
    let command = args.next().context("comment: no command given")?;
    let command_args: Vec<String> = args.collect();
    Command::new(command).args(command_args).spawn()?.wait()?;
    Ok(())
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
