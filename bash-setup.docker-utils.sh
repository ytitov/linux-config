#!/bin/bash
msg_info docker_clean_images to remove dangling images
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
msg_info "show dangling images" 'docker rmi $(docker images -a --filter=dangling=true -q)'
msg_info docker_stop_all "to stop all containers"
alias docker_stop_all='docker stop $(docker ps -q)'
msg_info "aws caller identity" "aws-whoami to get caller identity, add --profile if desired"
alias aws-whoami='aws sts get-caller-identity'

msg_info "frontail-log" 'frontail-log [path to log file]'
function frontail-log() {
  local FOLDER=${1:-/var/log}
  docker run -d --rm -p 10000:9001 --name frontail-log-viewer -v $FOLDER:/log mthenw/frontail /log
}

msg_info "clean-target-folders-recursively" 'delete all "target" subfolders'
function clean-target-folders-recursively() {
  F=${1:-target}

  msg_err "About to delete some files" "Ctrl-C to get out; any key to continue"
  read  -n 1

  for p in **/$F;
  do
    folder_name=$(basename $p)
    echo $folder_name
    if [ -d $p ]; then
      msg_err "Any key to delete Ctrl-C to cancel" "$p"
      read  -n 1
      rm $p -rf
    fi
  done
}

msg_info "docker-remove-images-with-file" 'iterate over lines in a given file'
function docker-remove-images-with-file() {
  F=$1

  IFS=$'\n'
  #arr=( $(docker images -aq) )
  arr=( $(docker image ls) )
  for i in ${arr[@]}; 
  do 
    #IFS=$' '
    #IFS=' ' read -r -a cols <<< "$i"
    IFS=' '
    arr=( $(echo $i) )
    imgname="${arr[1]}:${arr[2]}"
    imgid="${arr[3]}"
    #echo $i
    msg_err "Select option" "Delete '$imgname' with id: '$imgid' ?"
    select yn in "Yes" "No"; do
    case $yn in
        Yes ) docker image rm $imgid; break;;
        No ) echo "skipping $imgname"; break;;

    esac
    done
    #echo "imgname = $imgname"
  done

 # $(docker images -aq) | while IFS="" read line || [[ -n $line ]];
 # do
 #   msg_err "Any key to delete Ctrl-C to cancel" "image: $line"
 #   read  -n 1
 #   #docker image rm $p
 # done
}

function docker-remove-all-images() {
  docker rmi -f $(docker images -aq)
}
