#!/bin/bash
show_line_with_title "Docker utilities - bash-setup.docker-utils.sh"
msg_info docker_clean_images to remove dangling images
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
