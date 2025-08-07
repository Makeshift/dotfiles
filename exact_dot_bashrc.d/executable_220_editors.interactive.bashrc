# Editor preference order
# Also skip micro if we're in the vscode terminal because vscode eats keybinds
if command -v micro >/dev/null && [ "$TERM_PROGRAM" != "vscode" ]; then
  export EDITOR=micro
elif command -v nano >/dev/null; then
  export EDITOR=nano
elif command -v vim >/dev/null; then
  export EDITOR=vim
elif command -v vi >/dev/null; then
  export EDITOR=vi
fi

alias micro='$EDITOR'
alias nano='$EDITOR'
alias vim='$EDITOR'
alias vi='$EDITOR'
