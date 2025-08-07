export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# If we have a .vscode-server dir in home, patch the node bin so it has moar ram
if [[ -d "$HOME/.vscode-server/bin" ]]; then
  while IFS= read -r -d '' node; do
    if ! file "$node" | grep "ASCII text" > /dev/null; then
      dir="$(dirname "$node")"
      mv "$node" "${dir}/_node"
      echo -e '#!/bin/bash\nexec "'"${dir}/_node"'" --max-old-space-size=32768 "${@}"' > "$node"
      chmod +x "$node"
    fi
  done < <(find "$HOME/.vscode-server/bin" -maxdepth 2 -iname node -print0)
fi
