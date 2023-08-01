# Liquidprompt, pretty context-aware prompt
# shellcheck source=/home/connor/liquidprompt/liquidprompt
if [ -f "$HOME/liquidprompt/liquidprompt" ]; then
  if [ -z "$LIQUIDPROPMT_LAUNCHED_BY_PROFILE" ]; then
    . "$HOME/liquidprompt/liquidprompt"
  fi
fi
