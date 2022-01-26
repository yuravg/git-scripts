#!/usr/bin/env bash

# Installation script for Linux
#
# This script creates Linux symbolic links in the $HOME/bin directory pointing to local files
#

echo "Make links:"

PATH2SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

mklink () {
    fname="$1"
    ln -v -s "$PATH2SCRIPT"/bin/"$fname" "$HOME/bin/$fname"
}

mklink git-clear-reflog
mklink git-search-for-code-multiple
mklink git-status-extra
