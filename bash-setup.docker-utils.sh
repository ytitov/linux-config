#!/bin/bash
show_line_with_title "Docker utilities - bash-setup.docker-utils.sh"
msg_info docker_clean_images to remove dangling images
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
msg_info "show dangling images" 'docker rmi $(docker images -a --filter=dangling=true -q)'
msg_info docker_stop_all "to stop all containers"
alias docker_stop_all='docker stop $(docker ps -q)'
msg_info "clear all cache" 'docker builder prune'
