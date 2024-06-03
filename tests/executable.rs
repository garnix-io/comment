use assert_cmd::cargo::cargo_bin;
use std::env;
use std::process::{Stdio};
use anyhow::{Context, Result};
use std::fs;
use tokio::process::Command;
use std::{thread, time};
use tempfile::tempdir;

#[tokio::test(flavor = "multi_thread")]
async fn relays_signals() -> Result<()> {
    let dir = tempdir()?;
    let mut cmd = Command::new(cargo_bin("comment"));
    let outpath = dir.path().join("signal");
    let child = cmd.args([
        "--",
        "./signal.sh",
        outpath
            .as_os_str()
            .to_str()
            .context("impossible")?,
       ]).spawn()?;
    thread::sleep(time::Duration::from_millis(200));
    let mut kill = Command::new("kill")
        .args(["-SIGINT", &child.id().unwrap().to_string()])
        .stdout(Stdio::piped())
        .spawn()?;
    let out = kill.wait().await;
    thread::sleep(time::Duration::from_millis(100));
    let contents = fs::read_to_string(outpath)
         .expect("Should have been able to read the file");
    assert_eq!(contents, "Received SIGINT\n");
    Ok(())
}
