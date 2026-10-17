# Makes stderr red.
# TODO: Fork stderred and use CI to build a binary for each platform

search_for=("/usr/local/lib/libstderred.so" "$HOME/bin/libstderred.so" "/usr/lib/libstderred.so" "/lib/libstderred.so")

install_stderred() {
  local tmpdir file_placed f
  sudo apt-get install -y build-essential cmake git
  tmpdir=$(mktemp -d)
  cd "$tmpdir" || return 1
  git clone https://github.com/sickill/stderred.git
  cd stderred || return 1
  make
  file_placed=0
  for f in "${search_for[@]}"; do
    if [[ -d "$(dirname "$f")" ]] && [[ -w "$(dirname "$f")" ]] && install -m 644 build/libstderred.so "$f"; then
      file_placed=1
      break
    fi
  done
  if [[ "$file_placed" == 0 ]]; then
    echo "Couldn't find a place to put libstderred.so!" >&2
  else
    rm -rf "$tmpdir"
    find_and_export_stderred
  fi
}

find_and_export_stderred() {
  local found=0
  local f
  for f in "${search_for[@]}"; do
    if [[ -f "$f" ]]; then
      export LD_PRELOAD="$f${LD_PRELOAD:+:$LD_PRELOAD}"
      found=1
      break
    fi
  done
  # zsh stays quiet: output during startup breaks powerlevel10k's instant prompt.
  if [[ "$found" == 0 && -n "$BASH_VERSION" ]]; then
    echo "Stderred not installed, run install_stderred to install it" >&2
  fi
}

find_and_export_stderred
