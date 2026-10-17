# Check if we're in vscode, call our shell integration script if needed.
if [[ "$TERM_PROGRAM" == 'vscode' ]]; then
  # shellcheck source=/dev/null
  source "$(code --locate-shell-integration-path zsh)"
fi
