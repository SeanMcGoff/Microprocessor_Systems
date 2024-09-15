#!/bin/bash

# Check if the directory path is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

DIRECTORY=$1

if [ -d "$DIRECTORY" ]; then
    cd "$DIRECTORY"
    
    if [ $? -ne 0 ]; then
        echo "Failed to change directory to $DIRECTORY"
        exit 1
    fi

    mkdir -p build
    arm-none-eabi-as main.s -g -o build/main.o -march=armv5te
    if [ $? -ne 0 ]; then
        echo "Failed to build project in $DIRECTORY"
        exit 1
    fi
    arm-none-eabi-ld build/main.o -o build/main.bin
    if [ $? -ne 0 ]; then
        echo "Failed to link project in $DIRECTORY/build"
        exit 1
    fi
    truncate -s 16M build/main.bin
    if [ $? -ne 0 ]; then
        echo "Failed to truncate binary in $DIRECTORY/build"
        exit 1
    fi

    echo "Build files sucessfully written to: $DIRECTORY/build"
else
    echo "Directory $DIRECTORY does not exist."
    exit 1
fi
