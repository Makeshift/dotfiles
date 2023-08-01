#!/bin/bash

# Array of paths to add to PATH if they exist
path_array=(
  "$HOME/bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "/usr/local/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  "/usr/bin"
  "/usr/local/bin"
)

# Add paths to PATH if they exist and aren't already in PATH
for i in "${path_array[@]}"; do
  if [ -d "$i" ] && [[ ":$PATH:" == *":$i:"* ]]; then
    export PATH="$i:$PATH"
  fi
done
