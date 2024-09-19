#!/bin/bash

# Check if the directory path is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory_path> <port=1234>"
    exit 1
fi

DIRECTORY="$1"
PORT=${2:-'1234'}

if [ -d "$DIRECTORY" ]; then
    cd "$DIRECTORY"
    if [ $? -ne 0 ]; then
        echo "Failed to change directory to $DIRECTORY"
        exit 1
    fi
    # Redirect stderr to a temporary file
    tmpfile=$(mktemp)

    # Run QEMU in the background
    qemu-system-arm \
    -gdb tcp::$PORT \
    -S \
    -M connex \
    -drive if=pflash,file=build/main.bin,format=raw \
    -nographic \
    -serial /dev/null 2> "$tmpfile" &

    # Get the PID of the background process
    qemu_pid=$!

    # Wait for a short time
    sleep 1
    # Check if the process is still running
    if kill -0 $qemu_pid 2> /dev/null; then
        echo;
        echo "QEMU started successfully in background"
    else
        echo "Program failed to start or exited."
        echo "Standard error output:"
        cat "$tmpfile"
        rm "$tmpfile"
        exit 1
    fi
    rm "$tmpfile"

    # Start GDB, load symbols, remote target command
    echo "Starting GDB..."
    arm-none-eabi-gdb \
    -q \
    --symbols="build/main.bin" \
    -ex "set architecture armv5te" \
    -ex "target remote localhost:$PORT" \
    -ex "load build/main.bin" 

    kill -2 $qemu_pid
else
    echo "Directory $DIRECTORY does not exist."
    exit 1
fi