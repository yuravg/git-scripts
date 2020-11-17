#!/usr/bin/env bash

#
# Installation script
#
# This script copies all scripts from 'bin' directory to $HOME/bin directory
#

PATH2SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

for i in "$PATH2SCRIPT"/bin/* ; do
    FNAME=$(basename ${i##*/})
    TARGET="$HOME/bin"
    cp -vi "$i" "$TARGET/$FNAME"
done
