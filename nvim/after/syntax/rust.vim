"augroup BufEnter *.rs
"  syntax match spaces /  / conceal cchar= "Don't forget the space after cchar!
"  set concealcursor=nvi
"  set conceallevel=1
"augroup END
"augroup BufEnter *.json
"  set concealcursor=""
"augroup END
"

" helps with showing rust code indented to two spaces instead of 4
" warning this overrides all kinds of plugins
au BufEnter * set concealcursor=""
au BufEnter *.rs syntax match spaces /  / conceal cchar=·"Don't forget the space after cchar!
au BufEnter *.rs set concealcursor=nvi
au BufEnter *.rs set conceallevel=1
