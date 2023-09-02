# Makes stderr red.
# TODO: Fork stderred and use CI to build a binary for each platform

search_for=("/usr/local/lib/libstderred.so" "$HOME/.lib/libstderred.so" "/usr/lib/libstderred.so" "/lib/libstderred.so")

function install_stderred() {
    local tmpdir file_placed f
    sudo apt-get install -y build-essential cmake git
    tmpdir=$(mktemp -d)
    cd "$tmpdir" || exit 1
    git clone https://github.com/sickill/stderred.git
    cd stderred || exit 1
    make
    mkdir -p ~/lib
    file_placed=0
    for f in "${search_for[@]}"; do
        if [ -d "$(dirname "$f")" ] && test -w "$(dirname "$f")" && cp build/libstderred.so "$f"; then
            file_placed=1
            break
        fi
    done
    if [ "$file_placed" == 0 ]; then
      echo "Couldn't find a place to put libstderred.so!" >&2
    else
      rm -rf "$tmpdir"
    fi
}

function find_and_export_stderred() {
  local found=0
  local f
  for f in "${search_for[@]}"; do
      if [ -f "$f" ]; then
          export LD_PRELOAD="$f${LD_PRELOAD:+:$LD_PRELOAD}"
          found=1
          break
      fi
  done
  if [ "$found" == 0 ]; then
    echo "Stderred not installed, run install_stderred to install it" >&2
  fi

}


unset search_for
