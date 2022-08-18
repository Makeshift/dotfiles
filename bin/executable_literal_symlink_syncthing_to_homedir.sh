#!/bin/bash

shopt -s dotglob
ln -s /home/$USER/synced/* /home/$USER/ >/dev/null 2>&1
ln -s /home/$USER/synced/.config/* /home/$USER/.config/ >/dev/null 2>&1
