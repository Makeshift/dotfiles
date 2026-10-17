if runonce -i daily -n "$0$LINENO" && command -v chezmoi >/dev/null; then
  source_path="$(command chezmoi source-path 2>/dev/null)"
  if [[ -n "$source_path" ]] &&
    command git -C "$source_path" diff --quiet --ignore-submodules -- &&
    command git -C "$source_path" diff --cached --quiet --ignore-submodules --; then
    runonce chezmoi update >/dev/null 2>&1
  fi
fi
