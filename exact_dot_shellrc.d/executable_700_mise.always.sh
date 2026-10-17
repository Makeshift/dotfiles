# zsh activates mise through the oh-my-zsh mise plugin; non-interactive shells use the shims on PATH.
if [ -n "$BASH_VERSION" ] && [[ $- == *i* ]] && command -v mise >/dev/null; then
  eval "$(mise activate bash)"
fi
