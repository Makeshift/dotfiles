[ -z "$PS1" ] && return
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     export os=Linux;;
    Darwin*)    export os=Mac;;
    CYGWIN*)    export os=Windows;;
    MINGW*)     export os=Windows;;
    *)          export os="UNKNOWN:${unameOut}"
esac

architecture="$(dpkg --print-architecture)"
if [[ "$architecture" =~ "armhf" ]]; then
    archstring="_arm32"
else
    source <(cod${archstring} init $$ bash)
fi

if [[ "$(uname -r)" =~ "microsoft" ]]; then
  export os=wsl
fi

PATH=$PATH:/home/$USER/bin:/home/$USER/.local/bin

if type -P npm > /dev/null; then
  PATH=$PATH:$(npm -s root -g)
fi

set bell-style visible
set completion-ignore-case on
set show-all-if-ambiguous on
set mark-symlinked-directories on
set match-hidden-files off
set page-completions off
set completion-query-items 200
set visible-stats on
set skip-completed-text on
set input-meta on
set output-meta on
set convert-meta off

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

stty -ixon

extract () {
   if [ -f $1 ] ; then
       case $1 in
        *.tar.xz)   tar -xvf "$1"                         ;;
        *.tar.bz2)  tar -jxvf "$1"                        ;;
        *.tar.gz)   tar -zxvf "$1"                        ;;
        *.bz2)      bunzip2 "$1"                          ;;
        *.dmg)      hdiutil mount "$1"                    ;;
        *.gz)       gunzip "$1"                           ;;
        *.tar)      tar -xvf "$1"                         ;;
        *.tbz2)     tar -jxvf "$1"                        ;;
        *.tgz)      tar -zxvf "$1"                        ;;
        *.zip)      unzip "$1"                            ;;
        *.pax)      cat "$1" | pax -r                     ;;
        *.pax.z)    uncompress "$1" --stdout | pax -r     ;;
        *.rar)      7z x "$1"                             ;;
        *.z)        uncompress "$1"                       ;;
        *.7z)       7z x "$1"                             ;;
        *)          echo "'$1' cannot be extracted/mounted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }
# Manpages/less colouring
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

export HISTFILESIZE=2000000
export HISTSIZE=10000
shopt -s checkwinsize
shopt -s histappend
# Combine multiline commands into one in history
shopt -s cmdhist
shopt -s nocaseglob
shopt -s nocasematch
shopt -s cdspell
shopt -s dirspell
shopt -s autocd
shopt -s globstar
shopt -s expand_aliases
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTTIMEFORMAT='%F %T '

if type -P micro > /dev/null; then
  export EDITOR=micro${archstring}
else
  export EDITOR=vim
fi

function vim() {
    if type -P micro > /dev/null; then
        micro "$*"
    else
        vim "$*"
    fi
}

export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

alias ls="exa${archstring} -F"
alias cat="bat$archstring"
alias parallel="$HOME/bin/parallel"

alias mount='mount |column -t'
alias vi='vim'
alias sudo='sudo -E'
alias t='tail -f 2>&1 /dev/null'
alias ll='ls -lha --color=auto'
alias cg='cd `git rev-parse --show-toplevel`'
alias cd..='cd ..'
alias mkdir='mkdir -pv'
alias df='df -H'
alias du='du -ch'
alias python='python3'
alias terragrunt='aws-vault exec iea -- terragrunt'
alias terraform='aws-vault exec iea -- terraform'
alias tf=terraform
alias tg=terragrunt
alias rm='rm -I --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias wget='wget -c'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias path='echo -e ${PATH//:/\\n}'
# I have a lot of alias
alias lsalias="/bin/grep -in --color -e '^alias\s+*' ~/.bashrc | sed 's/alias //' | /bin/grep --color -e ':[a-z][a-z0-9]*'"
alias reset="reset;clear"
alias lsdir="ls -d */"
alias vpn=xaval
alias disable-git-ps1='source $(which export-to-shell) LP_ENABLE_GIT=0' # Sometimes this lags real bad so I wanted a quick alias to disable it
alias enable-git-ps1='source $(which export-to-shell) LP_ENABLE_GIT=1'

export BAT_THEME="Solarized (dark)"

function ip() {
    # TODO: Update this to use ip, ifconfig is outdated
  echo "Local:"
  ifconfig -a | /bin/grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, ""); print "    "$0 }'
  echo -e "Public:\n    $(curl -s checkip.amazonaws.com)"
}

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
  if [[ "$path" =~ "..."  ]]; then
    length=${#path}
    dirs=$((length / 2))
    unset path
    for i in `seq $dirs`; do
      path="${path}../"
    done
  fi
  builtin cd "$path" && ls
}

function find() {
  if type -P fd > /dev/null && [ "$#" -lt 2 ]; then
    fd${archstring} "$1"
  elif [ "$#" -lt 2 ]; then
    find -iname "*${1}*"
  else
    \find $*
  fi
}

function grep() {
  if type -P rg > /dev/null; then
    rg${archstring} --hidden "$*"
  else
    grep --color=auto -r "$*"
  fi
}

function math(){ echo "scale=5;" $@ | bc -l; }

export tmout=500000

check-ssh-agent() {
    [ -S "$SSH_AUTH_SOCK" ] && { ssh-add -l >& /dev/null || [ $? -ne 2 ]; }
}

mkdir -p ~/.tmp > /dev/null
check-ssh-agent || export SSH_AUTH_SOCK="$(< ~/.tmp/ssh-agent.env > /dev/null)"
check-ssh-agent || {
    eval "$(ssh-agent -s)" > /dev/null
    echo "$SSH_AUTH_SOCK" > ~/.tmp/ssh-agent.env
}

PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

export NPM_PACKAGES="/home/$USER/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export PATH="$NPM_PACKAGES/bin:$PATH"
export MANPATH="$NPM_PACKAGES/share/man:$(type -P manpath > /dev/null && manpath)"

export CDPATH=:..:~

[[ -s "$HOME/.qfc/bin/qfc.sh" ]] && source "$HOME/.qfc/bin/qfc.sh"
[[ $- = *i* ]] && source ~/.config/liquidprompt/liquidprompt

neofetch
