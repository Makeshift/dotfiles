[ -z "$PS1" ] && return
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi


PATH=$PATH:/home/$USER/bin:/home/$USER/.local/bin:$(npm root -g)

if type -P npm; then
  PATH=$PATH:$(npm root -g)
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
"\e[3;3~": kill-word

# Use the text that has already been typed as the prefix for searching through
# commands (i.e. more intelligent Up/Down behavior)
"\e[B": history-search-forward
"\e[A": history-search-backward

# Enable bash programmable completion features in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

stty -ixon

function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        if [ ! "${BRANCH}" == "" ]
        then
                STAT=`parse_git_dirty`
                echo "[${BRANCH}${STAT}]"
        else
                echo ""
        fi
}

function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits} "
        else
                echo ""
        fi
}


export PS1="\[\033[38;5;11m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;9m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;14m\][\w]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;7m\]\$?\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;13m\]\`parse_git_branch\`\[$(tput sgr0)\]\[\033[38;5;10m\]\\$\[$(tput sgr0)\] "

extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
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
shopt -s cdspell
shopt -s autocd
shopt -s globstar
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups:erasedups:ignorespace
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTTIMEFORMAT='%F %T '

export EDITOR=vim
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

alias mount='mount |column -t'
alias vi='vim'
alias sudo='sudo -E'
alias t='tail -f 2>&1 /dev/null'
alias ls='ls -F --color=auto'
alias ll='ls -lha --color=auto'
alias cg='cd `git rev-parse --show-toplevel`'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
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
alias sudo='sudo '
alias path='echo -e ${PATH//:/\\n}'

function ip() {
  echo "Local:"
  ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, ""); print "    "$0 }'
  echo -e "Public:\n    $(curl -s checkip.amazonaws.com)"
}

function cd() {
  builtin cd "$*" && ls
}
function grep() {
  if type -P rg; then
    rg --hidden $*
  else
    grep --color=auto -r $*
  fi
}

function math(){ echo "scale=5;" $@ | bc -l; }

export tmout=500000

check-ssh-agent() {
    [ -S "$SSH_AUTH_SOCK" ] && { ssh-add -l >& /dev/null || [ $? -ne 2 ]; }
}

check-ssh-agent || export SSH_AUTH_SOCK="$(< ~/.tmp/ssh-agent.env)"
check-ssh-agent || {
    eval "$(ssh-agent -s)" > /dev/null
    echo "$SSH_AUTH_SOCK" > ~/.tmp/ssh-agent.env
}

export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# Some nice git defaults
git config --global url."git@github.com:".insteadOf "https://github.com/"
git config --global pull.rebase true