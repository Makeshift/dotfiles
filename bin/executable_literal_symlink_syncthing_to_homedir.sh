#!/bin/bash

shopt -s dotglob
ln -s $HOME/synced/* $HOME/ >/dev/null 2>&1
ln -s $HOME/synced/.config/* $HOME/.config/ >/dev/null 2>&1
