# If we're in an interactive shell, use standard mise activate
if [[ $- == *i* ]]; then
  eval "$(mise activate bash)"
else
  # Non-interactive, use shims
  eval "$(mise activate bash --shims)"
fi
