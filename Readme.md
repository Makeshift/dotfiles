# Makeshift's Dotfiles

These are my "dotfiles", among other useful things I like to sync around and have in multiple places.

They are managed using [chezmoi](https://www.chezmoi.io/).

## Usage

```shell
# Install:
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Makeshift

# Install as oneshot:
$ sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --one-shot Makeshift

# Add a new file:
chezmoi add $FILE

# Update from this repo and apply changes
chezmoi update

# If you've modified the local chezmoi repo in `~/.local/share/chezmoi/`, this applies those changes to your homedir:
chezmoi apply

# go to `~/.local/share/chezmoi
chezmoi cd

# diff local repo -> homedir
chezmoi diff


```

## Notes

* Use `command -v` instead of `which` ([Why?](https://stackoverflow.com/a/677212))

## Dependencies

Back-up commands are available for most things if a dependency is missing, but a lot of features are disabled if missing things.
