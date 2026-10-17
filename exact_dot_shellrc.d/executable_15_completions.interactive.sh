# carapace fills in completions; ~/bin script descriptions come from `bin-index`.
_bin_descriptions="${XDG_CACHE_HOME:-$HOME/.cache}/bin-descriptions"

if [ -n "$ZSH_VERSION" ]; then
  # Only for commands with no completion yet, so oh-my-zsh's git, docker, kubectl etc. win.
  _carapace_for_uncompleted() {
    local init cmd
    local -a lines body cmds
    init="$(carapace _carapace zsh 2>/dev/null)" || return
    lines=("${(@f)init}")
    # Unquoted, so `compdef *` is a pattern; quoted it would only match literally.
    body=(${lines:#compdef *})
    eval "${(F)body}"
    cmds=(${(Q)${(z)${(M)lines:#compdef *}}})
    for cmd in ${cmds[3,-1]}; do
      (( $+_comps[$cmd] )) || compdef _carapace_completer "$cmd"
    done
  }
  (( $+commands[carapace] )) && _carapace_for_uncompleted
  unset -f _carapace_for_uncompleted

  # fzf-tab renders the menu, so plain group headers and no zsh menu.
  zstyle ':completion:*:descriptions' format '[%d]'
  zstyle ':completion:*' menu no
  zstyle ':fzf-tab:*' switch-group '<' '>'

  # Adds a described "my scripts" group to command-name completion.
  _bin_scripts_prev="${_comps[-command-]:-_command_names}"
  _bin_scripts_completer() {
    local -a scripts
    [[ -r $_bin_descriptions ]] && scripts=(${(f)"$(<$_bin_descriptions)"})
    (( $#scripts )) && _describe -t my-scripts 'my scripts' scripts
    "$_bin_scripts_prev" "$@"
  }
  compdef _bin_scripts_completer -command-
elif [ -n "$BASH_VERSION" ] && command -v carapace >/dev/null; then
  # shellcheck source=/dev/null
  source <(carapace _carapace bash 2>/dev/null)
fi

# Fuzzy-search ~/bin and ~/work_bin by name or description; zsh puts the pick on the next prompt.
bins() {
  local pick
  [ -r "$_bin_descriptions" ] || bin-index
  pick=$(sed 's/:/\t/' "$_bin_descriptions" | column -t -s "$(printf '\t')" | fzf --prompt='script> ' --query="$*") || return
  pick=${pick%% *}
  if [ -n "$ZSH_VERSION" ]; then
    print -z -- "$pick "
  else
    echo "$pick"
  fi
}
