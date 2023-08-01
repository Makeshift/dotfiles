##### Fetch system summary #####
if which fastfetch &>/dev/null; then
  fastfetch
elif which neofetch &>/dev/null; then
  if [ -z "$NEOFETCH_LAUNCHED_BY_PROFILE" ]; then
    neofetch
  fi
fi
