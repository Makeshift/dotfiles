alias docker-compose='docker compose' # This one is going to bug me for a while
alias get_numerical_permissions='stat --format "%a"'
alias chown='chown --preserve-root' # Don't let me mess up root
alias chmod='chmod --preserve-root' # Don't let me mess up root
alias chgrp='chgrp --preserve-root' # Don't let me mess up root
alias tf=terraform                  # Terraform
alias tg=terragrunt                 # Terragrunt
alias rm='rm --preserve-root'       # Overwritten in .bash_interactive if interactive
alias python='python3'              # I literally never want python2 by accident
alias t='tail -f 2>&1 /dev/null'    # Just keeps a session going
alias ll='ls -lah'                                                        # ls list with hidden files, human readable sizes
alias cg='cd `git rev-parse --show-toplevel`'                             # Jumps to the top level of a git repo
alias cd..='cd ..'                                                        # Typo fixes
alias path='echo -e ${PATH//:/\\n}'                                       # Pretty-print all entries in $PATH
alias reset="reset;clear"                                                 # Clean up the screen
alias lsdir="ls -d */"                                                    # Show only dirs
alias vpn=xaval                                                           # Poor man's SSH-based VPN (https://github.com/ivanilves/xiringuito)
# alias disable-git-ps1='source $(hash -t export-to-shell) LP_ENABLE_GIT=0' # Sometimes liquidprompt's git prompt lags a lot, this disables it
# alias enable-git-ps1='source $(hash -t export-to-shell) LP_ENABLE_GIT=1'  # Re-enables liquidprompt's git prompt
alias forget='history -d $((HISTCMD - 1))'                                # Forget the last command
alias mkdir='mkdir -pv'          # Makes parent directories as well
alias df='df -H'                 # Makes df human readable by default
alias rm='rm -I --preserve-root' # Prompt if removing more than 3 files or if recursive, also don't let me delete root
alias wget='wget -c'             # Allows me to resume wget downloads
alias less="less -r"             # Interpret colours with less
alias wget='wget -c --content-disposition' # Make wget grab actual filenames

# Override 'chezmoi cd' to go to the chezmoi dir instead of launching a new shell
function chezmoi() {
  if [[ "$1" == "cd" ]]; then
    cd "$(command chezmoi source-path)" || exit
  else
    command chezmoi "$@"
  fi
}

# Add an 'apt whatprovides' command, because I constantly forget apt doesn't have whatprovides
function apt() {
  if [[ "$1" == "whatprovides" ]]; then
    apt-file search "${@:2}"
  else
    apt-get "$@"
  fi
}

function tableise() {
  local data="$1"
  local seperator="${2-NOSEP}"
  local arg
  if command -v mlr >/dev/null; then
    [[ "$seperator" != "NOSEP" ]] && arg="--ifs $seperator" || arg=""
    # shellcheck disable=SC2086
    echo -e "$data" | mlr --csvlite $arg --opprint --barred cat
  else
    [[ "$seperator" != "NOSEP" ]] && arg="--s $seperator" || arg=""
    # shellcheck disable=SC2086
    echo -e "$data" | column -t $arg
  fi
}

function trim() {
  local var="$*"
  var="${var#"${var%%[![:space:]]*}"}"
  var="${var%"${var##*[![:space:]]}"}"
  echo -n "$var"
}

function trimQuotes() {
  local var="$*"
  var="${var%\"}"
  var="${var#\"}"
  var="${var%\'}"
  var="${var#\'}"
  echo -n "$var"
}

function escapeDoubleQuotes() {
  local var="$*"
  var="${var//\"/\\\"}"
  echo -n "$var"
}

function makeAliasTable() {
  local list
  list=$(/bin/grep -i --no-filename '^alias\s+*' "$HOME"/.bashrc "$HOME"/.bash_interactive | sed "s/alias //g")
  local sep="|||"
  local colourEnd="\033[0m"
  local nicelist="${colourEnd}Alias${colourEnd}${sep}${colourEnd}Command${colourEnd}${sep}${colourEnd}Description${colourEnd}\n"
  local count=0
  while read -r line; do
    local IFS alias_string command_string description_string
    count=$((count + 1))
    IFS='=' read -ra splitByEquals <<<"$line"
    alias_string=$(trim "${splitByEquals[0]}")
    local secondPart="${splitByEquals[*]:1}"
    IFS='#' read -ra splitByHash <<<"${secondPart}"
    command_string=$(trim "${splitByHash[0]}")
    command_string=$(trimQuotes "${command_string}")
    description_string=$(trim "${splitByHash[*]:1}")
    local colourStart="\033[0m"
    if [ $((count % 2)) -eq 1 ]; then
      colourStart="\033[1m"
    fi
    nicelist+="${colourStart}${alias_string}${colourEnd}${sep}${colourStart}${command_string}${colourEnd}${sep}${colourStart}${description_string}${colourEnd}\n"
    unset IFS
  done <<<"$list"
  tableise "$nicelist" "$sep"
}

alias aliases=makeAliasTable

# If no args are provided, pretty print mounts
function mount() {
  if [ -n "$1" ]; then
    command mount "$@"
  else
    command mount | column -t
  fi
}

function dcu() {
  docker compose "$@" up -d
  docker compose "$@" logs -f --tail 50
}

function dcr() {
  docker compose "$@" restart
  docker compose "$@" logs -f --tail 50
}

function getips() {
  echo "Local:"
  ifconfig -a | /bin/grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, ""); print "    "$0 }'
  echo -e "Public:\n    $(curl -m 2 -s checkip.amazonaws.com || echo Unknown)"
}

# Make extract easier
function extract() {
  if [ -f "$1" ]; then
    case $1 in
    *.tar.xz) tar -xvf "$1" ;;
    *.tar.bz2) tar -jxvf "$1" ;;
    *.tar.gz) tar -zxvf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.dmg) hdiutil mount "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar -xvf "$1" ;;
    *.tbz2) tar -jxvf "$1" ;;
    *.tgz) tar -zxvf "$1" ;;
    *.zip) unzip "$1" ;;
    *.pax) pax -rf "$1" ;;
    *.pax.z) uncompress "$1" --stdout | pax -r ;;
    *.rar) 7z x "$1" ;;
    *.z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *) echo "'$1' cannot be extracted/mounted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

# Make a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@" || return
}

# Get the top 10 processes
function top10() {
  ps aux | awk 'NR==1 || NR>10 {print}' | column -t
}

# Get the top 10 memory consumers
function top10mem() {
  ps aux | sort -k4 -rn | awk 'NR==1 || NR>10 {print}' | column -t
}

# Get the top 10 cpu consumers
function top10cpu() {
  ps aux | sort -k3 -rn | awk 'NR==1 || NR>10 {print}' | column -t
}

# Get the top 10 disk consumers
function top10disk() {
  du -ah | sort -hr | awk 'NR==1 || NR>10 {print}' | column -t
}

# Get the top 10 network consumers
function top10net() {
  netstat -an | awk '{print $6}' | sort | uniq -c | sort -rn | awk 'NR==1 || NR>10 {print}' | column -t
}

# Remembering bc exists is hard
function math() { echo "scale=5;" "$@" | bc -l; }

# https://github.com/common-fate/granted
if which assume &> /dev/null; then
	alias assume="source assume"
fi
