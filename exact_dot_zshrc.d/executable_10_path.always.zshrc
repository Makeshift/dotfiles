#!/usr/bin/env zsh

# Keep the first occurrence of each path entry while preserving priority.
typeset -U path PATH

path=(
  "$HOME/.local/share/mise/shims"
  "$HOME/.dotnet"
  "/opt/OpenLens"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "/usr/local/texlive/2023/bin/x86_64-linux"
  "$HOME/.pulumi/bin"
  "$HOME/.bun/bin"
  "$HOME/bin"
  "$HOME/work_bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "/usr/local/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  "/usr/bin"
  "/usr/local/bin"
  "/mnt/c/bin"
  $path
)

export PATH
