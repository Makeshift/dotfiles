# Makes stderr red, with the library mise installs for this platform from https://github.com/Makeshift/stderred.
_stderred="$HOME/.local/share/mise/installs/github-makeshift-stderred/latest/lib/libstderred.so"
if [ -f "$_stderred" ]; then
  case ":${LD_PRELOAD:-}:" in
    *":$_stderred:"*) ;;
    *) export LD_PRELOAD="$_stderred${LD_PRELOAD:+:$LD_PRELOAD}" ;;
  esac
fi
unset _stderred
