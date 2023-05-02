" setup os specific items
let iswsl=system('echo $(uname -a) | grep -o WSL')
if iswsl=~"WSL"
	" echo "running wsl: " iswsl
	" let res=system('echo wsl > ~/info.txt')
  let s:clip = '/mnt/c/WINDOWS/system32/clip.exe'  " change this path according to your mount point
  if executable(s:clip)
    autocmd TextYankPost * if v:event.operator ==# 'y' | call system('cat |' . s:clip, @0) | endif
endif
else
	" echo "running normal linux: " iswsl
	let res=system('echo linux > ~/info.txt')
endif

"  can load this file from main init.vim:
" let $INITCLIP = $HOME . "/.config/nvim/init.clipboard.vim"
" if filereadable($INITCLIP)
"   source $INITCLIP
"   echo "loaded " . $INITCLIP
" else
"   echo $INITCLIP . " does not exist"
" endif
