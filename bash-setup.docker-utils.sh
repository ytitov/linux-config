#!/bin/bash
msg_info docker_clean_images to remove dangling images
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
msg_info "show dangling images" 'docker rmi $(docker images -a --filter=dangling=true -q)'
msg_info docker_stop_all "to stop all containers"
alias docker_stop_all='docker stop $(docker ps -q)'
msg_info "clear all cache" 'docker builder prune'

msg_info "frontail-log" 'frontail-log [path to log file]'
function frontail-log() {
  local FOLDER=${1:-/var/log}
  docker run -d --rm -p 10000:9001 --name frontail-log-viewer -v $FOLDER:/log mthenw/frontail /log
}
