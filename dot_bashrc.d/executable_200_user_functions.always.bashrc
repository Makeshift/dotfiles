# Gets $SHOUTRRR_TELEGRAM_CHAT_URI from .bash_secret
function telegram() {
  if which shoutrrr >/dev/null; then
    shoutrrr send "$SHOUTRRR_TELEGRAM_CHAT_URI" "$*"
  fi
}
