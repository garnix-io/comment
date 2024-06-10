use assert_cmd::Command;
use std::{ffi::OsStr, iter::empty, thread};
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

#[test]
fn exits_with_child_exit_code() {
    run()
        .args(["--", "bash", "-c", "exit 42"])
        .assert()
        .failure()
        .code(42);
}

#[test]
fn exits_with_128_plus_signal_if_child_is_killed() {
    for signal in [
        /* SIGHUP */ 1, /* SIGINT */ 2, /* SIGQUIT */ 3, /* SIGKILL */ 9,
        /* SIGTERM */ 15,
    ] {
        let t = thread::spawn(move || {
            run()
                .args(["comment-test-kill-child", "--", "sleep", "inf"])
                .assert()
                .failure()
                .stderr(format!("sleep terminated by signal {signal}\n"))
                .code(128 + signal)
        });
        let comment_pid = pgrep(&["--full", "comment-test-kill-child"]);
        let sleep_pid = pgrep(&["--parent", &format!("{comment_pid}")]);
        Command::new("kill")
            .args([format!("-{signal}"), format!("{sleep_pid}")])
            .assert()
            .success();
        t.join().unwrap();
    }
}

fn run() -> Command {
    Command::cargo_bin("comment").unwrap()
}

fn pgrep(pgrep_args: &[impl AsRef<OsStr>]) -> u32 {
    // Keep attempting command until it succeeds in case process hasn't started yet
    let stdout = loop {
        let output = Command::new("pgrep").args(pgrep_args).output().unwrap();
        if output.status.success() {
            break output.stdout;
        }
        thread::sleep(std::time::Duration::from_millis(200));
    };
    String::from_utf8(stdout).unwrap().trim().parse().unwrap()
}
