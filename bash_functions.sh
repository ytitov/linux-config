#!/bin/bash
cd () {
  builtin cd "$@" && ls
  pwd
  pwd > /mnt/16m/pwd.txt
}

source find_replace
