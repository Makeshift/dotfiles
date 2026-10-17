# Makeshift's Dotfiles

These are my "dotfiles", among other useful things I like to sync around and have in multiple places. This repo contains no secrets and isn't neccessarily personalised just for me, so if you need a base set of dotfiles, these should work pretty well.

They are managed using [chezmoi](https://www.chezmoi.io/).

## Usage

```shell
# Install:
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Makeshift

# Install as oneshot, remove chezmoi after installation
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --one-shot Makeshift

# Add a new file:
chezmoi add $FILE

# Update from this repo and apply changes
chezmoi update

# If you've modified the local chezmoi repo in `~/.local/share/chezmoi/`, this applies those changes to your homedir.
#  There's a vscode code-workspace in the repo so you can open it up and edit things, and if you've got the extension
#  Run on Save installed, it'll automatically apply after saving a file
chezmoi apply

# Go to `~/.local/share/chezmoi`
chezmoi cd

# Diff local repo -> homedir
chezmoi diff

# Delete file from both repo and homedir
chezmoi remove $FILE

# Delete file from repo only, not homedir
chezmoi forget $FILE

# List all managed files, can be used with --include={files,dirs,symlinks} and accepts a prefix like ~/bin
chezmoi managed -i symlinks ~/bin

# Verify all targets match the correct state
chezmoi verify

# See what might be broke if something is broke
chezmoi doctor
```

## Editing files

There's a vscode workspace in the repo (`chezmoi cd`) set up specifically for editing the files included in this package.

After editing, run `chezmoi apply` (after `chezmoi diff`, if you like) to apply those changes to your actual homedir.

Note that if chezmoi hangs waiting for user input, you will need to kill the process (`killall chezmoi`) and run apply manually, because chezmoi locks the database.

## Dependencies

* Bash 4+
* `git`
* `curl`
* `ca-certificates`

(See `test/Dockerfile` for a minimal example on an Ubuntu base image)

Other tools come from [mise](https://mise.jdx.dev), configured in `private_dot_config/mise/config.toml`. `chezmoi apply` installs mise if it's missing, then installs the tools that shell startup needs. Tools marked `lazy = true` install the first time you run them.

The shell config lives in `exact_dot_shellrc.d`, which both bash and zsh source: `*.always.sh` for every shell, `*.interactive.sh` for interactive ones. Scripts branch on `$BASH_VERSION`/`$ZSH_VERSION` where the shells differ. The PATH order is in `exact_dot_shellrc.d/executable_10_path.always.sh`.

## Scripts in `bin/`

Each script's second line is `# desc: <what it does>`. `bin-index` caches those lines, so the scripts show up with descriptions in zsh tab completion, and `bins [words]` fuzzy-searches them by name or description.

## Optional services

`chezmoi init` asks whether to enable heavy services such as explainshell. Change an answer with `chezmoi edit-config`, then `chezmoi apply`; user systemd units are enabled or disabled to match.

## Testing

Testing is currently done manually in an Ubuntu docker container, which has very few binaries built in it, to ensure we can reliably grab most things we need.

TODO: Test in Alpine, and test with non-x86
