#!/bin/bash
show_line_with_title "Git utils - bash-setup.git-utils.sh"
msg_info gitlog "show a predefined pretty print log"
alias gitlog="git log --decorate --graph --pretty=tformat:'%C(dim white)%m%C(dim green)%h %C(dim cyan)%cd %C(yellow)%<(12,trunc)%aN %C(reset)%s%C(auto)%w(0,0,9)%+d%C(reset)' --decorate --graph"
