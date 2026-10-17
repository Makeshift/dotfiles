#### Replace built-ins right at the end so other scripts don't cause issues ####

if command -v eza >/dev/null; then
  alias ls='eza -F'
fi

if command -v bat >/dev/null; then
  export BAT_THEME='Solarized (dark)'

  if command -v glow >/dev/null; then
    cat() {
      local arg
      for arg in "$@"; do
        case "$arg" in
          *.md) glow "$@"; return ;;
        esac
      done
      bat "$@"
    }
  else
    alias cat='bat'
  fi
fi

alias rgrep='grep -r --color=auto'
alias egrep='grep -E --color=auto'
alias fgrep='grep -F --color=auto'

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
  [[ -f "$target" ]] && target=$(dirname -- "$target")

  builtin cd "$target" && ls
}

# Helper for quickly jumping to the directory for a file path.
cdf() {
  local target="$1"
  if [[ -f "$target" ]]; then
    target=$(dirname -- "$target")
  fi
  builtin cd "$target" && ls
}
