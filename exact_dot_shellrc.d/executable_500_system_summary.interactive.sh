# zsh skips this: output during startup breaks powerlevel10k's instant prompt.
if [ -n "$BASH_VERSION" ] && command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
