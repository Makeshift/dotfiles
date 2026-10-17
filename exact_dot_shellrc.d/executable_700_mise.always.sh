# zsh activates mise through the oh-my-zsh mise plugin; non-interactive shells use the shims on PATH.
if [ -n "$BASH_VERSION" ] && [[ $- == *i* ]] && [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi
