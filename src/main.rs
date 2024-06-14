use signal_hook::{consts::signal, iterator::Signals};
use std::{
    env, io,
    os::unix::process::ExitStatusExt,
    process::{self, Command},
    thread,
};

fn main() {
    let Exit { code, msg } = run(env::args())
        .err()
        .unwrap_or(Exit { code: 0, msg: None });
    if let Some(msg) = msg {
        eprintln!("{msg}");
    }
    process::exit(code);
}

fn run(mut args: impl Iterator<Item = String>) -> Result<(), Exit> {
    while let Some(arg) = args.next() {
        if arg == "--" {
            break;
        }
    }
    let command = args
        .next()
        .ok_or(Exit::error("comment: no command given"))?;
    let command_args: Vec<String> = args.collect();
    let mut child = Command::new(&command).args(command_args).spawn()?;
    let child_pid = child.id();
    thread::spawn(move || relay_signals(child_pid).unwrap());
    let exit = child.wait()?;
    match exit.code() {
        Some(0) => Ok(()),
        Some(code) => Err(Exit { code, msg: None }),
        None => {
            let signal = exit.signal().unwrap_or(0);
            Err(Exit {
                code: 128 + signal,
                msg: Some(format!("{command} terminated by signal {signal}")),
            })
        }
    }
}

fn relay_signals(pid: u32) -> io::Result<()> {
    // All execept SIGILL, SIGFPE, SIGKILL, SIGSEGV, SIGSTOP
    let mut signals = Signals::new(&[
        signal::SIGHUP,
        signal::SIGINT,
        signal::SIGQUIT,
        signal::SIGTERM,
    ])?;
    signals.handle();
    for signal in &mut signals {
        Command::new("kill")
            .args(["-s", &signal.to_string(), &pid.to_string()])
            .spawn()?
            .wait()?;
    }
    Ok(())
}

struct Exit {
    code: i32,
    msg: Option<String>,
}

impl Exit {
    fn error(msg: impl ToString) -> Self {
        Self {
            code: 1,
            msg: Some(msg.to_string()),
        }
    }
}

impl From<io::Error> for Exit {
    fn from(err: io::Error) -> Self {
        Exit::error(format!("{err}"))
    }
}
