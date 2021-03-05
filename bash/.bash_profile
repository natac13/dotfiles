#!/bin/bash

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
eval "$(/home/natac/.linuxbrew/bin/brew shellenv)"
