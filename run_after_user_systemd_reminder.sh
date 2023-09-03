#!/bin/bash

hash_file="$HOME/.cache/chezmoi_makeshift/dotconfig_systemd_hash"
check_dir="$HOME/.config/systemd"

cached_hash=$(cat "$hash_file" 2>/dev/null || true)
curr_hash=$(find "$check_dir" -type f -exec sha256sum {} \;)

if [ "$cached_hash" != "$curr_hash" ]; then
    echo "$curr_hash" > "$hash_file"
    find "$check_dir" -type f
    echo "User systemd config has changed, you may need to run:"
    echo "systemctl --user enable --now <unit>"
fi
