#!/bin/bash
source ~/.config/bash_functions.sh

show_line_with_title "Running ~/.config/bash_custom.sh"

#export XDG_CONFIG_HOME=~/.config
DIRCOLORS=~/.config/dircolors.config
PWD_FILE_LOC=${PWD_FILE_LOC:-/mnt/16m/pwd.txt}

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
function info_msg() {
  a=${@}
  local word=$2
  local color=$GREEN
  if [ ${#a} -gt 2 ];
  then
    color=$1
    shift
    shift
    echo "[${color}$word${NC}]: $@"
  else 
    echo "$RED ERROR: $NC This requires 2+ arguments"
  fi
}

function msg_err() {
  info_msg $RED $@
}

function msg_info() {
  info_msg $BLUE $@
}

function msg_ok() {
  info_msg $GREEN $@
}

function get_user_input() {
  tempfile=${1:-$(date +%s).md}
  nvim $tempfile
  echo $tempfile
}

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

  for i in $(echo $LS_COLORS | tr ":" "\n")
  do
    color=${i##*=}
    ext=${i%%=*}
    echo -en "\e[${color}m${ext}\e[0m\n" # echo color and extension
  done

fi

# ALIASES #########################################
show_line_with_title "creating some aliases"
alias gt="gnome-terminal --working-directory=$(cat $PWD_FILE_LOC)"
alias get_master_vol="amixer -c 1 sget Master | awk -F\"[][]\" '/dB/ { print $2}'"
alias ls="ls --color=auto --sort=extension --group-directories-first"

# export GIT_CONFIG=~/.config/.gitconfig

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
if command -v pacman &> /dev/null
then
    echo "Writing the list of installed packages to ~/.config/installed_packages.txt"
    LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h > ~/.config/installed_packages.txt
fi

# for sway rempap esc to caps
export XKB_DEFAULT_OPTIONS=caps:escape
echo "wifi: nmtui/nm-connection-editor"
echo "bluetooth: blueman-manager"
echo "monitor settings: wdisplays"

EDITOR=~/.local/bin/nvim

show_line_with_title "Sourcing bash-setup* scripts"

for f in ~/.config/bash-setup*
do
  show_line_with_title "Processing $f"
  source $f
done
