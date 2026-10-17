# Always-run, because the rc files skip *.interactive.sh inside vscode terminals.
case $- in
  *i*)
    if [ "$TERM_PROGRAM" = 'vscode' ]; then
      # shellcheck source=/dev/null
      . "$(code --locate-shell-integration-path "$([ -n "$ZSH_VERSION" ] && echo zsh || echo bash)")"
    fi
    ;;
esac
