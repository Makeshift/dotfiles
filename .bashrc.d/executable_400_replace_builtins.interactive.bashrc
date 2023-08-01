#### Replace built-ins right at the end so other scripts don't cause issues ####

# Use ripgrep if it's available
if command -v rg >/dev/null; then
  alias grep=rg
  # ripgrep is recursive by default
  alias rgrep=rg
  alias egrep='rg --pcre2'
  alias fgrep='rg -F'
else
  alias grep='grep -r --color=auto'
  alias rgrep='grep -r --color=auto'
  alias egrep='grep -E --color=auto'
  alias fgrep='grep -F --color=auto'
fi

if command -v exa >/dev/null; then alias ls="exa -F"; fi # Use exa if it's available

if command -v bat >/dev/null; then
  export BAT_THEME="Solarized (dark)"
  alias cat="bat" # Use bat if it's available
fi

if command -v dust >/dev/null; then
  alias du="dust" # Use dust if it's available
else
  alias du="du -ch" # Makes du human readable and gives a grand total
fi

# Make cd a bit smarter
function cd() {
  if [[ "$1" =~ "--" ]]; then
    shift
  fi
  local path=$1
  # If $2 isn't empty, we probably intended to use autocd to go into a subdir, so let's try that
  if [ ! -z "$2" ]; then
    shift
    newpath="$path $*"
    newpath=${newpath// /\/}
    newpath=${newpath#--}
    newpath=${newpath#\/}
    if [ -f "$(pwd)/$newpath" ] || [ -d "$(pwd)/$newpath" ]; then
      path="$newpath"
    fi
  fi
  # If we try to CD to a file, cd to the dir it's in
  if [ -f "$path" ]; then
    path=$(dirname "$path")
  fi
  # If path has a string containing > 2 dots, then you're an idiot who forgot your aliases, but we'll fix it anyway
  # shellcheck disable=SC2076
  if [[ "$path" =~ "..." ]]; then
    length=${#path}
    dirs=$((length / 2))
    unset path
    for i in $(seq $dirs); do
      path="${path}../"
    done
  fi
  builtin cd "$path" && ls
}
