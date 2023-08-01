# Check if we're in vscode, call our interactive script followed by its init script if we need to
if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  source "$(code --locate-shell-integration-path bash)"
fi
