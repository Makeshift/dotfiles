if [[ -n "$WSL_DISTRO_NAME" || -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  if command -v socat >/dev/null && command -v npiperelay.exe >/dev/null 2>&1; then
    mkdir -p "$HOME/.1password" >/dev/null 2>&1

    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

    # Exit 2 means nothing answers on the socket, even if a relay process survives without it.
    timeout 5 ssh-add -l >/dev/null 2>&1
    if [[ $? == 2 ]]; then
      pkill -f "^socat UNIX-LISTEN:$SSH_AUTH_SOCK," >/dev/null 2>&1
      rm -f "$SSH_AUTH_SOCK"
      (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi
  fi
fi
