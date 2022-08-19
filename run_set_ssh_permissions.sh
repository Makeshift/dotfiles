#!/bin/sh

chmod 644 ~/.ssh/known_hosts 2>/dev/null
chmod 644 ~/.ssh/config 2>/dev/null
chmod 600 ~/.ssh/id_* 2>/dev/null
chmod 644 ~/.ssh/id_*.pub 2>/dev/null
chown -R $USER:$USER ~/.ssh 2>/dev/null
