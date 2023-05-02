#!/bin/bash
PWD_FILE_LOC=${PWD_FILE_LOC:-/mnt/16m/pwd.txt}

if ! [ -f "$PWD_FILE_LOC" ]; then
  echo "creating $PWD_FILE_LOC file"
  touch $PWD_FILE_LOC 
  echo "$HOME" > $PWD_FILE_LOC
fi


function cdcustom() {
  if [ -z "$1" ]; then
    echo "Changing to global pwd '$(cat $PWD_FILE_LOC)'"; builtin cd "$(cat $PWD_FILE_LOC)"
  else 
    builtin cd "$@" && echo "$PWD" > $PWD_FILE_LOC;
  fi
}

alias cd=cdcustom

source ~/.config/sh_scripts/find_replace

alias show_line="printf -- '-%.0s' {2..$(tput cols)}; printf '\n'"
function fix_time() {
  echo "try running: 'sudo ntpdate ntp.ubuntu.com'"
}
