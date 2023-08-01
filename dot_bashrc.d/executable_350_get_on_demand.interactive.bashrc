# Sets up aliases to grab applications on demand

function command_exists() {
  which "$1" >/dev/null 2>&1
}

function run_or_eget() {
  local app_name="$1"
  local eget_command="$2"
  local args=("${@:3}")
  if ! command_exists "$app_name"; then
    # This command doesn't exist, so run eget to get it
    echo "Getting $app_name..." >&2
    eget "$eget_command"
  fi
  # Remove the alias and run the command
  unalias "$app_name" >/dev/null 2>&1
  "$app_name" "${args[@]}"
}

# Array of apps to get on demand, in the format "app_name:github_user/repo"
on_demand_eget_apps=(
  "fastfetch:fastfetch-cli/fastfetch"
  "bat:sharkdp/bat"
  "container-diff:GoogleContainerTools/container-diff"
  "dust:bootandy/dust"
  "exa:ogham/exa"
  "ripgrep:BurntSushi/ripgrep"
  "fd:sharkdp/fd"
  "grex:pemistahl/grex"
  "hyperfine:sharkdp/hyperfine"
  "lazydocker:jesseduffield/lazydocker"
  "micro:zyedidia/micro"
  "regctl:regclient/regclient"
  "shoutrrr:containrrr/shoutrrr"
  "youtube-dl:ytdl-org/youtube-dl"
)

for app in "${on_demand_eget_apps[@]}"; do
  app_name="${app%%:*}"
  eget_command="${app##*:}"
  alias $app_name="run_or_eget $app_name $eget_command"
done
