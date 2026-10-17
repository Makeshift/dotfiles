# Highest priority first; entries already in PATH move up to their position here.
_path_dirs=(
  "$HOME/.local/share/mise/shims"
  "$HOME/.dotnet"
  "/opt/OpenLens"
  "${KREW_ROOT:-$HOME/.krew}/bin"
  "/usr/local/texlive/2023/bin/x86_64-linux"
  "$HOME/.pulumi/bin"
  "$HOME/.bun/bin"
  "$HOME/bin"
  "$HOME/work_bin"
  "$HOME/.local/bin"
  "$HOME/go/bin"
  "$HOME/.cargo/bin"
  "/usr/local/go/bin"
  "$HOME/.yarn/bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  "/usr/bin"
  "/usr/local/bin"
  "/mnt/c/bin"
)

_path_new=""
_path_add() {
  case ":$_path_new:" in
    *":$1:"*) ;;
    *) _path_new="${_path_new:+$_path_new:}$1" ;;
  esac
}
for _path_dir in "${_path_dirs[@]}"; do
  _path_add "$_path_dir"
done
_path_rest="$PATH"
while [ -n "$_path_rest" ]; do
  _path_dir="${_path_rest%%:*}"
  [ -n "$_path_dir" ] && _path_add "$_path_dir"
  [ "$_path_rest" = "$_path_dir" ] && break
  _path_rest="${_path_rest#*:}"
done
export PATH="$_path_new"
unset -f _path_add
unset _path_dirs _path_new _path_rest _path_dir
