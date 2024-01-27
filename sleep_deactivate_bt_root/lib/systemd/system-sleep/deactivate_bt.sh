#!/bin/bash
case $1/$2 in
    pre/*)
    # commands to be executed before suspend, hibernate, etc. goes below
    bluetoothctl power off
    ;;
    post/*)
    # commands to be executed on wake, resume, etc. goes below
    echo "Nothing to see here"
    ;;
esac
