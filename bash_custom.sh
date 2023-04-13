#!/bin/bash
echo "====== Running ~/.config/bash_custom.sh -======"

#export XDG_CONFIG_HOME=~/.config
DIRCOLORS=~/.config/dircolors.config
echo "creating /mnt/16m/pwd file"
touch /mnt/16m/pwd.txt
echo "$HOME" > /mnt/16m/pwd.txt

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
export GIT_CONFIG=~/.config/.gitconfig

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
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#export JAVA_HOME=/usr/lib/jvm/java-13-openjdk
PATH=$PATH:~/.config/sh_scripts/
PATH="$HOME/.local/share/bin:$PATH"
PATH="$JAVA_HOME/bin:$PATH"
export ANDROID_HOME=/opt/android-sdk
#export ANDROID_SDK_ROOT=/opt/android-sdk #issue recommended to remove this per: https://stackoverflow.com/questions/39645178/panic-broken-avd-system-path-check-your-android-sdk-root-value
#export ANDROID_HOME=~/Android/Sdk
#export ANDROID_SDK_ROOT=~/Android/Sdk
#export PATH=$JAVA_HOME/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$PATH
#export PATH=$ANDROID_HOME/tools/bin:$PATH
alias vim=nvim
export PATH="$HOME/flutter/bin:$PATH"
# detect the timezone
#tzupdate -p
#source /usr/share/git/completion/git-completion.bash
echo "Writing the list of installed packages to ~/.config/installed_packages.txt"
LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h > ~/.config/installed_packages.txt
# for sway rempap esc to caps
export XKB_DEFAULT_OPTIONS=caps:escape
echo "wifi: nmtui/nm-connection-editor"
echo "bluetooth: blueman-manager"
echo "monitor settings: wdisplays"
