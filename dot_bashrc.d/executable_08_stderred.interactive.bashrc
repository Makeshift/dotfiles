#!/bin/bash

# Makes stderr red.
# TODO: Fork stderred and use CI to build a binary for each platform

if [ ! -f "/usr/local/lib/libstderred.so" ] && [ -f "/etc/debian_version" ]; then
  sudo apt-get install -y build-essential cmake git
  tmpdir=$(mktemp -d)
  cd "$tmpdir" || exit 1
  git clone https://github.com/sickill/stderred.git
  cd stderred || exit 1
  make
  mkdir -p ~/lib
  cp build/libstderred.so /usr/local/lib/
  rm -rf "$tmpdir"
fi

if [ -f "/usr/local/lib/libstderred.so" ]; then
  export LD_PRELOAD="$HOME/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
fi
