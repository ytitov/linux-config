augroup json
    autocmd!
    autocmd FileType json let g:xml_syntax_folding=1
    autocmd FileType json :syntax on
    autocmd FileType json setlocal foldmethod=syntax
    autocmd FileType json :%foldopen!
augroup END

com! FmtJson %!python3 -m json.tool
