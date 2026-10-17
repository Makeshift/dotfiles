alias get_numerical_permissions='stat --format "%a"'
alias chown='chown --preserve-root'            # Don't let me mess up root
alias chmod='chmod --preserve-root'            # Don't let me mess up root
alias chgrp='chgrp --preserve-root'            # Don't let me mess up root
alias tf=terraform                             # Terraform
alias tg=terragrunt                            # Terragrunt
alias rm='rm --preserve-root'                  # Don't let me delete root
alias python='python3'                         # I literally never want python2 by accident
alias t='tail -f 2>&1 /dev/null'               # Just keeps a session going
alias ll='ls -lah'                             # ls list with hidden files, human readable sizes
cg() { cd "$(git rev-parse --show-toplevel)"; } # Jumps to the top level of a git repo
alias cd..='cd ..'                             # Typo fixes
alias path='echo -e ${PATH//:/\\n}'            # Pretty-print all entries in $PATH
alias reset="reset;clear"                      # Clean up the screen
alias lsdir="ls -d */"                         # Show only dirs
alias mkdir='mkdir -pv'                        # Makes parent directories as well
alias df='df -H'                               # Makes df human readable by default
# alias rm='rm -I --preserve-root'               # Prompt if removing more than 3 files or if recursive, also don't let me delete root
alias less='less -r'                           # Interpret colours with less
alias wget='wget -c --content-disposition'     # Make wget grab actual filenames
alias lens='open-lens'                         # Lens but not the annoying paid version

# Override 'chezmoi cd' to go to the chezmoi dir instead of launching a new shell
chezmoi() {
  if [[ "$1" == 'cd' ]]; then
    cd "$(command chezmoi source-path)" || return
  else
    command chezmoi "$@"
  fi
}

# Add an 'apt whatprovides' command, because I constantly forget apt doesn't have whatprovides
apt() {
  if [[ "$1" == 'whatprovides' ]]; then
    apt-file search "${@:2}"
  else
    apt-get "$@"
  fi
}

# If no args are provided, pretty print mounts
mount() {
  if [[ -n "$1" ]]; then
    command mount "$@"
  else
    command mount | column -t
  fi
}

getips() {
  echo 'Local:'
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, ""); print "    "$0 }'
  echo -e "Public:\n    $(curl -m 2 -s checkip.amazonaws.com || echo Unknown)"
}

# Make a new directory and enter it
mkd() {
  mkdir -p "$@" && cd "$@" || return
}

# Get the top 10 processes
top10() {
  ps aux | awk 'NR==1 || NR<=11 {print}' | column -t
}

# Get the top 10 memory consumers
top10mem() {
  ps aux | sort -k4 -rn | awk 'NR==1 || NR<=11 {print}' | column -t
}

# Get the top 10 cpu consumers
top10cpu() {
  ps aux | sort -k3 -rn | awk 'NR==1 || NR<=11 {print}' | column -t
}

# Get the top 10 disk consumers
top10disk() {
  du -ah | sort -hr | awk 'NR==1 || NR<=11 {print}' | column -t
}

# Get the top 10 network consumers
top10net() {
  netstat -an | awk '{print $6}' | sort | uniq -c | sort -rn | awk 'NR==1 || NR<=11 {print}' | column -t
}

# Remembering bc exists is hard
math() { echo 'scale=5;' "$@" | bc -l; }

# zsh has equivalents from the oh-my-zsh docker-compose and extract plugins.
if [ -n "$BASH_VERSION" ]; then
  # `function` form, because zsh expands its own dcu/dcr aliases while parsing this block.
  function dcu {
    docker compose "$@" up -d
    docker compose "$@" logs -f --tail 50
  }

  function dcr {
    docker compose "$@" restart
    docker compose "$@" logs -f --tail 50
  }

  alias docker-compose='docker compose'
  alias forget='history -d $((HISTCMD - 1))' # Forget the last command

  extract() {
    if [ -f "$1" ]; then
      case $1 in
      *.tar.xz) tar -xvf "$1" ;;
      *.tar.bz2) tar -jxvf "$1" ;;
      *.tar.gz) tar -zxvf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar -xvf "$1" ;;
      *.tbz2) tar -jxvf "$1" ;;
      *.tgz) tar -zxvf "$1" ;;
      *.zip) unzip "$1" ;;
      *.rar | *.7z) 7z x "$1" ;;
      *.z) uncompress "$1" ;;
      *) echo "'$1' cannot be extracted via extract()" ;;
      esac
    else
      echo "'$1' is not a valid file!"
    fi
  }
fi
