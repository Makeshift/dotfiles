#!/bin/bash

## Broke

# Only run once every 1080 minutes (18 hours)
# if [[ "$(runonce -i 1080 echo "continue")" == "continue" ]]; then
#   echo "Generating public keys..."
#   for key in $(ssh-add -L); do
#     tmpfile=$(mktemp)
#     echo "$key" > "$tmpfile"

#   done
# fi

# OP_TOKEN_STORE=/tmp/op_token

# function op() {
#   if [[ -f "$OP_TOKEN_STORE" ]]; then
#     OP_SESSION_my=$(cat "$OP_TOKEN_STORE")
#     export OP_SESSION_my
#   fi
#   if [[ "$1" == "signin" ]]; then
#     if [[ -n "$OP_SESSION_my" ]]; then
#       op signin --session "$OP_SESSION_my"
#     else
#       op signin -f --raw | tee "$OP_TOKEN_STORE"
#       OP_SESSION_my=$(cat "$OP_TOKEN_STORE")
#       export OP_SESSION_my
#     fi
#   else
#     op "$@"
#   fi
# }
