use std::{
    env, io,
    os::unix::process::ExitStatusExt,
    process::{self, Command},
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
    let exit = Command::new(&command).args(command_args).spawn()?.wait()?;
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
