##### Fetch system summary #####
if command -v fastfetch >/dev/null; then
  fastfetch
elif command -v neofetch >/dev/null; then
  if [ -z "$NEOFETCH_LAUNCHED_BY_PROFILE" ]; then
    neofetch
  fi
fi
