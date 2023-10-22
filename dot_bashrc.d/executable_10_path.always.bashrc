#!/bin/bash

# Array of paths to add to PATH if they exist
# Added in reverse order so that the first path in the array is the first path
path_array=(
  "$HOME/.bun/bin"
  "$HOME/bin"
  "$HOME/work_bin"
  "$HOME/.local/bin"
  # for vagrant
  "/mnt/c/Program Files/Oracle/VirtualBox"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "/usr/local/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  "/usr/bin"
  "/usr/local/bin"
)

# Add paths to PATH if they exist and aren't already in PATH
for ((i=${#path_array[@]}-1; i>=0; i--)); do
  if actual=$(realpath "${path_array[$i]}" 2>/dev/null) && [ -d "${actual}" ] && [[ ":$PATH:" != *":$actual:"* ]]; then
    export PATH="${actual}:$PATH"
  fi
done
