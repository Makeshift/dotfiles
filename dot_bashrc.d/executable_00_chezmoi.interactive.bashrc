if command -v chezmoi >/dev/null; then
  # shellcheck disable=SC1090
  source <(chezmoi completion bash)
  if command -v runonce >/dev/null; then
    # By default, runs on login if not run in the last 8 hours
    runonce chezmoi update > /dev/null
  fi
fi
