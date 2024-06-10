use assert_cmd::Command;
use std::iter::empty;
use tempfile::tempdir;

#[test]
fn executes_commands() {
    let dir = tempdir().unwrap();
    run()
        .args(["--", "touch", dir.path().join("file").to_str().unwrap()])
        .assert()
        .success();
    assert!(dir.path().join("file").exists());
}

#[test]
fn errors_on_no_command() {
    run()
        .args(["--"])
        .assert()
        .failure()
        .code(1)
        .stderr("comment: no command given\n");
    run()
        .args(empty::<&str>())
        .assert()
        .failure()
        .code(1)
        .stderr("comment: no command given\n");
}

#[test]
fn allows_comments() {
    let dir = tempdir().unwrap();
    run()
        .args([
            "my",
            "comment",
            "--",
            "touch",
            dir.path().join("file").to_str().unwrap(),
        ])
        .assert()
        .success();
    assert!(dir.path().join("file").exists());
}

fn run() -> Command {
    Command::cargo_bin("comment").unwrap()
}
