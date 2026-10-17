export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

load_nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

if [ -n "$ZSH_VERSION" ] && command -v nvm_find_nvmrc >/dev/null; then
  autoload -U add-zsh-hook
  add-zsh-hook chpwd load_nvmrc
  load_nvmrc
fi

export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

# Patch VS Code server's node binary to raise the memory limit
if [[ -d "$HOME/.vscode-server/bin" ]] && runonce -i daily -n "$0$LINENO"; then
  while IFS= read -r -d '' node; do
    if ! file "$node" | grep -q 'ASCII text'; then
      dir="$(dirname "$node")"
      mv "$node" "${dir}/_node"
      cat >"$node" <<EOF
#!/usr/bin/env bash
# Strip any --max-old-space-size occurrences (both --flag=value and --flag value)
filtered_args=()
skip_next=0
for arg in "\$@"; do
  if [ "\$skip_next" -eq 1 ]; then
    skip_next=0
    continue
  fi
  case "\$arg" in
    --max-old-space-size)
      skip_next=1 ;;
    --max-old-space-size=*)
      ;;
    *)
      filtered_args+=("\$arg") ;;
  esac
done

exec "${dir}/_node" --max-old-space-size=32768 "\${filtered_args[@]}"
EOF
      chmod +x "$node"
    fi
  done < <(find "$HOME/.vscode-server/bin" -maxdepth 2 -iname node -print0)
fi
