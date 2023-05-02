#!/bin/bash
PWD_FILE_LOC=${PWD_FILE_LOC:-/mnt/16m/pwd.txt}
function cdcustom() {
  if [ -z "$1" ]; then
    echo "Changing to global pwd '$(cat $PWD_FILE_LOC)'"; builtin cd "$(cat $PWD_FILE_LOC)"
  else 
    builtin cd "$@" && echo "$PWD" > $PWD_FILE_LOC;
  fi
}

alias cd=cdcustom

source ~/.config/sh_scripts/find_replace
