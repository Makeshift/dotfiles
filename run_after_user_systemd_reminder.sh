#!/bin/bash

cached_hash=$(cat "$HOME/.cache/chezmoi_makeshift/dotconfig_systemd_hash" || true)
curr_hash=$(find . -type f -exec sha256sum {} \;)

if [ "$cached_hash" != "$curr_hash" ]; then
    echo "$curr_hash" > "$HOME/.cache/dotconfig_systemd_hash"
    ls "$HOME/.config/systemd/user/"
    echo "User systemd config has changed, you may need to run:"
    echo "systemctl --user --enable --now <unit>"
fi
