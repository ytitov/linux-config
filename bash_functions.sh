#!/bin/bash
cd () {
  builtin cd "$@" && ls
  pwd
  pwd > /mnt/16m/pwd.txt
}

source ~/.config/sh_scripts/find_replace
