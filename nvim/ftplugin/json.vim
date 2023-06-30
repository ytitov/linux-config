
let g:xml_syntax_folding=1
:syntax on
setlocal foldmethod=syntax
:%foldopen!

com! FmtJson %!python3 -m json.tool
