
# Switched to mise for now
#export PYENV_ROOT="$HOME/.pyenv"
#[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init - bash)"
#eval "$(pyenv virtualenv-init -)"
# Pip 3.11 + Ubuntu now errors if you try to use the system pip to install anything
#  including if you use --user. So we create and enable a default virtualenv.
#if [ ! -f "$HOME/.cache/venv/bin/activate" ]; then
#    pip -m venv "$HOME/.cache/venv"
#fi
#source "$HOME/.cache/venv/bin/activate" || true 2>&1


