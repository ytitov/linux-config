" javascript =================================================================
" vim-javascript
let g:javascript_plugin_jsdoc=1
"set foldmethod=syntax
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_arrow_function       = "⇒"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_NaN                  = "ℕ"
set conceallevel=1
" deplete for javascript
let g:deoplete#enable_at_startup = 1
" tern
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'javascript',
                \ ]
" Use tern_for_vim.
autocmd FileType js g:tern#command = ["tern"]
autocmd FileType js g:tern#arguments = ["--persistent"]
