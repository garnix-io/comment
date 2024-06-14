#!/usr/bin/env bash

sleep inf & PID=$!

handle() {
    echo "Received $1"
    kill $PID
    exit
}

trap "handle SIGHUP" HUP
trap "handle SIGINT" INT
trap "handle SIGQUIT" QUIT
trap "handle SIGTERM" TERM

wait
