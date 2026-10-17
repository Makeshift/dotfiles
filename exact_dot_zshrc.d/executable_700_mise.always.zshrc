#if command -v mise >/dev/null; then
#  typeset mise_activation
#  if [[ -o interactive ]]; then
#    mise_activation="$(mise activate zsh 2>/dev/null)" || unset mise_activation
#  else
#    mise_activation="$(mise activate zsh --shims 2>/dev/null)" || unset mise_activation
#  fi
#
#  if [[ -n "$mise_activation" ]]; then
#    _mise_activate() { emulate -L zsh -o no_aliases; eval "$mise_activation"; }
#    _mise_activate
#    unset -f _mise_activate
#  fi
#fi
