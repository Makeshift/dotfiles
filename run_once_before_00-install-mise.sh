#!/bin/sh
# Installs mise, or upgrades it to the first release with lazy tools, before chezmoi writes any files.
set -eu

min_version=2026.9.0
mise="$HOME/.local/bin/mise"

if [ ! -x "$mise" ]; then
  curl -fsSL https://mise.run | sh
  exit 0
fi

current=$("$mise" --version | cut -d' ' -f1)
if [ "$(printf '%s\n%s\n' "$min_version" "$current" | sort -V | head -1)" != "$min_version" ]; then
  "$mise" self-update --yes
fi
