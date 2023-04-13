call plug#begin('$HOME/.local/share/nvim/plugged')
" javascript ================================================
"Plug 'maksimr/vim-jsbeautify', {'for': ['javascript', 'javascript.jsx', 'html', 'css', 'json']}
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript.jsx']}
Plug 'posva/vim-vue', {'for': ['vue']}
Plug 'leafgarland/typescript-vim', {'for': ['ts']}
Plug  'peitalin/vim-jsx-typescript', {'for': ['typescriptreact']}
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx', 'ts', 'typescriptreact', 'vue'], 'do': 'npm install -g tern' }
" vim-jsx-improve doesnt work with vim-jsx
"Plug 'neoclide/vim-jsx-improve', {'for': ['javascript.jsx']}

Plug 'othree/html5.vim', {'for': ['html']}

" docker stuff ================================================
Plug 'ekalinin/Dockerfile.vim', {'for': ['dockerfile']}
Plug 'stephpy/vim-yaml', {'for': ['yaml']}
Plug 'tpope/vim-dotenv', {'for': ['dotenv']}

" dart ===================================================
Plug 'dart-lang/dart-vim-plugin', {'for' :['dart']}

" rust =======================================
Plug 'rust-lang/rust.vim', {'for': ['rust']}
Plug 'cespare/vim-toml', {'for': ['toml']}
Plug 'maralla/vim-toml-enhance', {'for': ['toml']}


" PHP =================================================
" Plug '2072/PHP-Indenting-for-VIm', { 'for': ['php'] }
" Plug 'tobyS/pdv', { 'for': ['php'] }
" Plug 'tobyS/vmustache', { 'for': ['php'] }

" terraform files
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

" nginx ============================================
Plug 'chr4/nginx.vim', { 'for': 'nginx' }

" graph ql files ==================================
Plug 'jparise/vim-graphql', { 'for': 'graphql' }

" MY PLUGIN STUFF =====================================
" Plug '~/.config/nvim/myplugins/myphp', { 'for': ['php'] }

" GENERIC ===========================================
Plug 'dense-analysis/ale' 
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'powerline/powerline'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'morhetz/gruvbox'
Plug 'powerline/fonts'

call plug#end()

colorscheme gruvbox
set termguicolors
let g:gruvbox_italic=1
"sets background to transparent but screws up the gruvbox
"hi normal guibg=111
set background=dark

" in normal mode goes to command mode
" in command mode acts like esq
" in insert mode acts like esq
" assumed to be the caps lock key.
noremap <F12> :
nnoremap <F12> :
imap <F12> <C-c>
" visual and select
vmap <F12> <Esc>
" select mode
smap <F12> <Esc>
" visual
xmap <F12> <Esc>
" command line mode
cmap <F12> <Esc>
" operator mode
omap <F12> <Esc>
" ctrl p settings, include directory of cur file, and nearest ancestor with
" .git .hg. svn .bzr....
let g:ctrlp_working_path_mode = 'ra' " r is search from nearest ancestor (.git .svn etc)
" let g:ctrlp_working_path_mode = 'w' " w is search from cwd 
let g:ctrlp_custom_ignore = {
  \ 'dir':  'docs\|target\|node_modules\|\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jar)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ctrl-n opens
map <C-n> :NERDTreeToggle<CR>

" indentation
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" " when indenting with '>', use 2 spaces width
set shiftwidth=2
" " On pressing tab, insert 2 spaces
set expandtab

" enable true colors
set termguicolors

" cformat auto:
autocmd FileType cpp ClandFormatAutoEnable

" runs :RustFmt everytime we save a rust file
"autocmd FileType rust let g:rustfmt_autosave=1

" this is supposed to auto format on save but it doesnt do anything....
autocmd FileType terraform let g:terraform_fmt_on_save=1

" autoformat a json file just type :FormatJSON
com! FmtJSON %!python -m json.tool

set noic

let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_filetype_changed=0
let g:ale_rust_cargo_check_tests=1
let g:ale_set_highlights=0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" PHP ========================================================================
" augroup enterbuffer 
"   autocmd BufNewFile,BufRead *.php set formatprg=php-formatter
" augroup end

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
                \ ]
" Use tern_for_vim.
autocmd FileType js g:tern#command = ["tern"]
autocmd FileType js g:tern#arguments = ["--persistent"]
"autocmd BufWritePre *.jsx call JsxBeautify()
"autocmd BufWritePre *.js call JsBeautify()
autocmd BufWritePre *.html call HtmlBeautify()

" set filetype to dart
au BufRead,BufNewFile *.dart set filetype=dart

let g:python3_host_prog = '/usr/bin/python3'

:autocmd VimResized * wincmd =
