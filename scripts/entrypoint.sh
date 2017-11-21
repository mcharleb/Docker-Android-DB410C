#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID and LOCAL_USER_NAME if passed in at runtime or
# fallback

USER_ID=${LOCAL_USER_ID:-1000}
USER_NAME=${LOCAL_USER_NAME:-user}

echo "Starting with UID : $USER_ID"
useradd --shell /bin/bash -u $USER_ID -o -c "" -m $USER_NAME
echo "$USER_NAME:admin" | chpasswd
adduser $USER_NAME sudo
export HOME=/home/$USER_NAME
mkdir -p $HOME/.ccache
chown -R $USER_ID $HOME/.ccache

exec gosu $USER_NAME "$@"
