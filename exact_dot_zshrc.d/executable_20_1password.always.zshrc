if [[ -n "$WSL_DISTRO_NAME" || -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  if command -v socat >/dev/null && command -v npiperelay.exe >/dev/null 2>&1; then
    mkdir -p "$HOME/.1password" >/dev/null 2>&1

    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

    already_running=$(
      ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"
      echo $?
    )
    if [[ "$already_running" != "0" ]]; then
      if [[ -S "$SSH_AUTH_SOCK" ]]; then
        rm "$SSH_AUTH_SOCK" >/dev/null 2>&1
      fi
      (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi
  fi
fi
