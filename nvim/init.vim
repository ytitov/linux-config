call plug#begin('$HOME/.local/share/nvim/plugged')
" javascript ================================================
" Plug 'maksimr/vim-jsbeautify', {'for': ['javascript', 'javascript.jsx', 'html', 'css', 'json']}
Plug 'maksimr/vim-jsbeautify', {'for': ['html', 'css', 'json']}
" Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
" Plug 'mxw/vim-jsx', {'for': ['javascript.jsx']}
" Plug 'posva/vim-vue', {'for': ['vue']}
Plug 'leafgarland/typescript-vim', {'for': ['ts']}
Plug  'peitalin/vim-jsx-typescript', {'for': ['typescriptreact']}
" Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx', 'ts', 'typescriptreact', 'vue'], 'do': 'npm install -g tern' }
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
" Plug 'rust-lang/rust.vim', {'for': ['rust']}
" using rustaceanvim instead
Plug 'mrcjkb/rustaceanvim', {'for': ['rust']}
Plug 'cespare/vim-toml', {'for': ['toml']}
Plug 'maralla/vim-toml-enhance', {'for': ['toml']}

" terraform files
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

" nginx ============================================
Plug 'chr4/nginx.vim', { 'for': 'nginx' }

" graph ql files ==================================
Plug 'jparise/vim-graphql', { 'for': 'graphql' }

" MY PLUGIN STUFF =====================================
" Plug '~/.config/nvim/myplugins/myphp', { 'for': ['php'] }

" markdown =====================================
" not sure if this is worth it at this point, syntax features are
" overwritten by tree-sitter so may be a good idea to disable
" see https://github.com/MDeiml/tree-sitter-markdown#extensions
" Plug 'SidOfc/mkdx', { 'for': 'markdown' }


" GENERIC ===========================================
Plug 'dense-analysis/ale' ", { 'for': ['rust', 'python' ] } 
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'powerline/powerline'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'morhetz/gruvbox'
Plug 'powerline/fonts'

Plug 'udalov/kotlin-vim', { 'for': [ 'kts', 'kt', 'kotlin'] }

" :MasonUpdate updates registry contents
Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
"Plug 'williamboman/mason-lspconfig.nvim'
" Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mustache/vim-mustache-handlebars', { 'for': 'hbs' }

call plug#end()

set ff=unix
set ffs=unix

" setup clipboard according to the OS
source ~/.config/nvim/init.clipboard.vim
source ~/.config/nvim/lua/plugin.lua

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
  \ 'dir':  'build\|docs\|target\|node_modules\|\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|jar)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" setup undo
set backup
set backupdir=~/.vim/backups
set hidden
set undofile
set undodir=~/.vim/undofiles
set undolevels=1000
set undoreload=1000


" ctrl-n opens
map <C-n> :NERDTreeToggle<CR>

" indentation
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" " when indenting with '>', use 2 spaces width
set shiftwidth=2
" " On pressing tab, insert 2 spaces
set expandtab

" enable true colors
set termguicolors

set list
set listchars=tab:·>
set conceallevel=1
set autoindent

" cformat auto:
autocmd FileType cpp ClandFormatAutoEnable

" runs :RustFmt everytime we save a rust file
"autocmd FileType rust let g:rustfmt_autosave=1

" this is supposed to auto format on save but it doesnt do anything....
autocmd FileType terraform let g:terraform_fmt_on_save=1

set noic

let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_filetype_changed=0
let g:ale_rust_cargo_check_tests=1
let g:ale_set_highlights=0
let g:ale_completion_enabled=0 " because using deoplete
" 'rust': ['cargo', 'fmt']
"

let g:ale_linters = {
  \  'markdown': []
  \  ,'sh': []
  \  ,'kotlin': []
  \  ,'java': []
  \ }
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" PHP ========================================================================
" augroup enterbuffer 
"   autocmd BufNewFile,BufRead *.php set formatprg=php-formatter
" augroup end

"autocmd BufWritePre *.jsx call JsxBeautify()
" autocmd BufWritePre *.js call JsBeautify()
" autocmd BufWritePre *.html call HtmlBeautify()

" set filetype to dart
au BufRead,BufNewFile *.dart set filetype=dart

au BufRead,BufNewFile *.js set filetype=javascript
au BufRead,BufNewFile *.jsx set filetype=javascript.jsx

let g:python3_host_prog = '/usr/bin/python3'

:autocmd VimResized * wincmd =

augroup xml
    autocmd!
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml :syntax on
    autocmd FileType xml setlocal foldmethod=indent
    autocmd FileType xml :%foldopen!
augroup END

" this requires to `pip install sqlparse`
" com! FmtSql %!python3 -m sqlparse --keywords upper -<CR>
com! FmtSql %!sqlformat --reindent --keywords upper --identifiers lower -
" com! FmtXML %!python -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
com! FmtXML %!export XMLLINT_INDENT=$'\t'; xmllint --format --recover -
com! FmtJson %!python3 -m json.tool

let g:deoplete#enable_at_startup = 1

" for trying to figure out why vim is being slow
""" :profile start profile.log
""" :profile func *
""" :profile file *
""" " At this point do slow actions
""" :profile pause
""" :noautocmd qall!
set concealcursor=""

command! UnwrapSqsNotification :%s/\\"/"/g | :%s/\\n/\r/g | %s/\\"/"/g | %s/\\"/"/g | %s/"{/{/g | %s/}"/}/g
