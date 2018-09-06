# Put this into ~/.bashrc
# if [ -f ~/.config/bash_custom.sh ]; then
#   . ~/.config/bash_custom.sh
# fi

echo "Running bash_custom.sh"

# ALIASES #########################################
echo 'docker-sa will stop all running containers';
alias docker-sa='docker stop $(docker ps -aq)'
