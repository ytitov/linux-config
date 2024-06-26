if [ -f /proc/sys/fs/binfmt_misc/WSLInterop ]; then
  msg_info "note" "detected wsl and running some extras"
  msg_info "alacritty config location" "/mnt/c/Users/YuriyTitov/AppData/Roaming/alacritty/alacritty.yml"
  msg_info "launch alacritty" "alacr [window name]"
  msg_info "wsl hostname" "$(wsl.exe hostname -I)"
  function alacr() {
    alacritty.exe -T "$1"&
  }
  msg_info "view-pdf" "view-pdf [file]"
  function view-pdf() {
    local FILE='file://///wsl.localhost/Ubuntu'
    local f="$FILE$(realpath $1)"
    echo "Opening url: $f"
    firefox.exe -new-window $f&
  }
fi



