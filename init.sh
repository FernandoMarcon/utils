#!/bin/bash

UTILS_DIR="$HOME/utils"
# BIN_DIR="/usr/local/bin/"

# for file in "$UTILS_DIR"/*; do
#   if [ -f "$file" ] && [ -x "$file" ]; then
#     echo ln -sf "$PWD/$file" "$BIN_DIR/$(basename "$file")"
#   fi
# done

export PATH="$PATH:$UTILS_DIR/wolfram"
