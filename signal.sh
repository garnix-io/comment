#! /usr/bin/env bash

echo Starting $1

echo $$

DEST=$1

handle() {
    echo Received SIGINT > $DEST
    echo Received SIGINT
    exit 1
}

handle2() {
    echo Received SIGTERM > $DEST
    echo Received SIGTERM
    exit 1
}


trap handle INT
trap handle2 TERM

sleep 100000 &
wait
