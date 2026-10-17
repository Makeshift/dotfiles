#### Replace built-ins right at the end so other scripts don't cause issues ####

if command -v eza >/dev/null; then
  alias ls='eza -F'
fi

if command -v bat >/dev/null; then
  export BAT_THEME='Solarized (dark)'

  if command -v glow >/dev/null; then
    cat() {
      if (( $# )) && [[ "${(M)@:#*.md}" ]]; then
        glow "$@"
      else
        bat "$@"
      fi
    }
  else
    alias cat='bat'
  fi
fi

if command -v dust >/dev/null; then
  alias du='dust'
else
  alias du='du -ch'
fi

# Make cd a bit smarter, and always list the new directory afterwards.
cd() {
  [[ "$1" == '--' ]] && shift
  local target=$1

  # If more args were given, we probably meant to autocd into a subdir but
  # forgot to escape a space in the path, so try to rebuild it.
  if [[ -n "$2" ]]; then
    shift
    local newtarget="${target} $*"
    newtarget="${newtarget// //}"
    newtarget="${newtarget#--}"
    newtarget="${newtarget#/}"
    [[ -f "$newtarget" || -d "$newtarget" ]] && target="$newtarget"
  fi

  # If we try to cd to a file, cd to the directory it's in instead.
  [[ -f "$target" ]] && target=${target:h}

  builtin cd "$target" && ls
}

# Helper for quickly jumping to the directory for a file path.
cdf() {
  local target="$1"
  if [[ -f "$target" ]]; then
    target=${target:h}
  fi
  builtin cd "$target" && ls
}
