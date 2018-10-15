# Put this into ~/.bashrc
# if [ -f ~/.config/bash_custom.sh ]; then
#   . ~/.config/bash_custom.sh
# fi

echo "Running ~/.config/bash_custom.sh"

# ALIASES #########################################
echo 'docker-sa will stop all running containers';
alias docker-sa='docker stop $(docker ps -aq)';

echo 'dropbox starts ~/.dropbox-dist/dropboxd';
alias dropbox=~/.dropbox-dist/dropboxd; 

echo 'git log --pretty=format:"%ad - %an: %s" --after="2018-09-09" --until="2018-09-15"';
echo 'gives you a date range';

echo 'overriding the cd func to store pwd';

# make sure to add to fstab: 
# tmpfs     /mnt/16m     tmpfs     rw,size=16M,x-gvfs-show     0 0

function cd {
  #builtin cd "$@" && ls -F
  builtin cd "$@" && ls
  pwd
  pwd > /mnt/16m/pwd.txt
}

echo 'creating alias for gnome terminal to go to pwd';
alias gt="gnome-terminal --working-directory=$(cat /mnt/16m/pwd.txt)";






export PATH=$PATH:~/.local/bin
