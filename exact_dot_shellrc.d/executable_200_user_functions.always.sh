# Gets $SHOUTRRR_TELEGRAM_CHAT_URI from .bash_secret
telegram() {
  if command -v shoutrrr >/dev/null; then
    shoutrrr send "$SHOUTRRR_TELEGRAM_CHAT_URI" "$*"
  fi
}
