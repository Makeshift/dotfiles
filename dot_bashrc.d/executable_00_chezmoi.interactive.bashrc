if command -v chezmoi >/dev/null; then
  source <(chezmoi completion bash)
  chezmoi update 
fi
