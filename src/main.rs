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
