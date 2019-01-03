#!/bin/bash
echo "====== Running ~/.config/bash_custom.sh ======"

DIRCOLORS=~/.config/dircolors.config
echo "creating /mnt/16m/pwd file"
touch /mnt/16m/pwd.txt

# enable color support of ls and also add handy aliases
echo "customizing some colors"
if [ -x /usr/bin/dircolors ]; then
  test -r $DIRCOLORS && eval "$(dircolors -b $DIRCOLORS)" || eval "$(dircolors -b)" \
    && echo "Using the dircolors config at $DIRCOLORS"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'

    # Run in a subshell so it won't crash current color settings
    dircolors -b >/dev/null
    IFS=:
    for ls_color in ${LS_COLORS[@]}; do # For all colors
        color=${ls_color##*=}
        ext=${ls_color%%=*}
        echo -en "\E[${color}m${ext}\E[0m " # echo color and extension
    done
    echo
fi

# ALIASES #########################################
echo "creating some aliases"
alias gt="gnome-terminal --working-directory=$(cat /mnt/16m/pwd.txt)"
alias get_master_vol="amixer -c 1 sget Master | awk -F\"[][]\" '/dB/ { print $2}'"
alias ls="ls --color=auto --sort=extension --group-directories-first"

source ~/.config/bash_functions.sh
#source ~/.config/bash_docker_completion.sh

# Put this into ~/.bashrc
# if [ -f ~/.config/bash_custom.sh ]; then
#   . ~/.config/bash_custom.sh
# fi

#
#
## PRINT INFO #####################################
#
#echo 'git log --pretty=format:"%ad - %an: %s" --after="2018-09-09" --until="2018-09-15"'
#echo 'gives you a date range'
#
#echo 'overriding the cd func to store pwd'
#
## make sure to add to fstab: 
## tmpfs     /mnt/16m     tmpfs     rw,size=16M,x-gvfs-show     0 0
#
#echo 'creating alias for gnome terminal to go to pwd'
#echo "to start any gnome do: env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"
#echo "git log --graph --decorate --pretty=oneline --abbrev-commit master origin/master 231_shipping_settings"
#
#
#
#echo 'dropbox starts ~/.dropbox-dist/dropboxd'
#alias dropbox=~/.dropbox-dist/dropboxd
PATH=$PATH:~/.config/sh_scripts/
