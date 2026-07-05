if runonce -i daily -n "$0$LINENO" && command -v chezmoi > /dev/null; then
  runonce chezmoi update > /dev/null
fi
