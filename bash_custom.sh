# Put this into ~/.bashrc
# if [ -f ~/.config/bash_custom.sh ]; then
#   . ~/.config/bash_custom.sh
# fi

echo "Running ~/.config/bash_custom.sh"

# ALIASES #########################################
echo 'docker-sa will stop all running containers';
alias docker-sa='docker stop $(docker ps -aq)'

echo 'dropbox starts ~/.dropbox-dist/dropboxd';
alias dropbox=~/.dropbox-dist/dropboxd; 

echo 'git log --pretty=format:"%ad - %an: %s" --after="2018-09-09" --until="2018-09-15"'
echo 'gives you a date range'
