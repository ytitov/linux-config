#!/bin/bash
PWD_FILE_LOC=${PWD_FILE_LOC:-/mnt/16m/pwd.txt}

if ! [ -f "$PWD_FILE_LOC" ]; then
  echo "creating PWD_FILE_LOC: $PWD_FILE_LOC file"
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

alias show_line="printf -- '-%.0s' {1..$(tput cols)}; printf '\n'"

function show_line_len() {
  local LEN=${1:-$(tput cols)}
  printf -- '-%.0s' {1..$LEN}; printf '\n'
}

function show_line_with_title() {
  local TITLE=${1:-"====="}
  local CHAR=${2:-":"}
  local TOTAL_WIDTH=$(($(tput cols)-1))
  TITLE_LEN=$(expr length $TITLE)
  local LINE_WIDTH=$(($((TOTAL_WIDTH-TITLE_LEN))/2))
  local LINE_AND_TITLE_WIDTH=$(($TITLE_LEN+$LINE_WIDTH))
  printf -- $CHAR'%.0s' {1..$LINE_WIDTH}; 
  printf $TITLE
  printf -- $CHAR'%.0s' {$LINE_AND_TITLE_WIDTH..$TOTAL_WIDTH}; 
  printf '\n'
}

show_line_with_title "Run du_matching_files [word] to get cumulative size"
function du_matching_files() {
  local M=${1:-target}
  find . -path "*$M*" -type f -print0 | du -ch --files0-from=-
  echo 'To remove use: find . -path "*target/debug*" -exec rm -rf {} +'
}

function fix_time() {
  echo "try running: 'sudo ntpdate ntp.ubuntu.com'"
}

show_line_with_title "Sourced bash_functions.sh"
