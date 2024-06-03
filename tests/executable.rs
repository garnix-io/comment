use anyhow::{Context, Result};
use assert_cmd::cargo::cargo_bin;
use std::fs;
use std::{thread, time};
use tempfile::tempdir;
use tokio::process::Command;

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
        .spawn()?;
    let _ = kill.wait().await;
    thread::sleep(time::Duration::from_millis(100));
    let contents = fs::read_to_string(outpath)
         .expect("Should have been able to read the file");
    assert_eq!(contents, "Received SIGINT\n");
    Ok(())
}

#[tokio::test(flavor = "multi_thread")]
async fn kills_when_killed() -> Result<()> {
    // TODO
    Ok(())
}


#[tokio::test(flavor = "multi_thread")]
async fn exits_with_child_exit_code() -> Result<()> {
    let dir = tempdir()?;
    let mut cmd = Command::new(cargo_bin("comment"));
    let outpath = dir.path().join("signal");
    let mut child = cmd.args([
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
        .spawn()?;
    let _ = kill.wait().await;
    let status = child.wait().await;
    assert_eq!(status.unwrap().code(), Some(42));
    Ok(())
}
