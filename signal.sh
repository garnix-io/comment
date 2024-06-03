#! /usr/bin/env bash

DEST=$1

handle() {
    echo Received SIGINT > $DEST
    exit 42
}

trap handle INT

sleep 100000 &
wait
