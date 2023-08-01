# shellcheck source=/home/connor/.cargo/env
if [ -f "$HOME/.cargo/env" ] && command -v cargo >/dev/null; then
  source "$HOME/.cargo/env"
fi
