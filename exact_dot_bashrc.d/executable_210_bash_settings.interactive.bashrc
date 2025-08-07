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

# Manpages/less colouring
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
export EXA_COLORS=$LS_COLORS
export HISTFILESIZE=2000000
export HISTSIZE=10000
export CLICOLOR=1

shopt -s autocd         # If you just type a dir name, cd to it
shopt -s expand_aliases # Expands aliases

export CDPATH=:..:$HOME # Search the current dir, above dir and home dir for cd targets

#### Shell Options ####
shopt -s checkwinsize # Resize the window after every command
shopt -s histappend   # Appends to the history file rather than overwriting it
shopt -s cmdhist      # Combine multiline commands into one in history
shopt -s nocaseglob   # Match filenames without regard to case
shopt -s nocasematch  # Match patterns without regard to case
shopt -s cdspell      # Fixes typos when cd'ing
shopt -s dirspell     # Fixes typos when using dirs
shopt -s globstar     # Allows you to use ** in pathnames
# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups:erasedups:ignorespace
# History between multiple sessions (but breaks command numbers, meh)
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"
export HISTIGNORE="&:ls:[bf]g:exit"
export HISTTIMEFORMAT='%F %T '
