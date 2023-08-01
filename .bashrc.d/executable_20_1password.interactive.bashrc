if command -v socat && command -v npiperelay.exe; then
    # Code extracted from https://stuartleeks.com/posts/wsl-ssh-key-forward-to-windows/

    # (IMPORTANT) Create the folder on your root for the `agent.sock` (How mentioned by @rfay and @Lochnair in the comments)
    mkdir -p ~/.1password >/dev/null 2>&1

    # Configure ssh forwarding
    export SSH_AUTH_SOCK=$HOME/.1password/agent.sock
    # need `ps -ww` to get non-truncated command for matching
    # use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
    ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
    if [[ $ALREADY_RUNNING != "0" ]]; then
        if [[ -S $SSH_AUTH_SOCK ]]; then
            # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
            # echo "removing previous socket..."
            rm "$SSH_AUTH_SOCK" >/dev/null 2>&1
        fi
        # setsid to force new session to keep running
        # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
        (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
    fi
fi
