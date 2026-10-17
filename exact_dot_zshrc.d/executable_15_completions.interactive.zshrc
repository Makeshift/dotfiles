# Prefer Oh My Zsh plugins, but keep a local completion dir for commands that
# ship reliable native zsh completions.
COMPLETIONS_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/completions"
mkdir -p "$COMPLETIONS_DIR"
fpath=("$COMPLETIONS_DIR" "${fpath[@]}")

if runonce -i weekly -n "$0$LINENO"; then
  command -v chezmoi >/dev/null && chezmoi completion zsh >"$COMPLETIONS_DIR/_chezmoi"
  command -v eksctl >/dev/null && eksctl completion zsh >"$COMPLETIONS_DIR/_eksctl"
  command -v rustup >/dev/null && rustup completions zsh rustup >"$COMPLETIONS_DIR/_rustup"
  command -v rustup >/dev/null && rustup completions zsh cargo >"$COMPLETIONS_DIR/_cargo"
fi
