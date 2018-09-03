call plug#begin('$HOME/.local/share/nvim/plugged')
" on demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" javascript
Plug 'pangloss/vim-javascript', {'for': ['javascript', 'javascript.jsx']}
Plug 'mxw/vim-jsx', {'for': ['javascript.jsx']}
" vim-jsx-improve doesnt work with vim-jsx
"Plug 'neoclide/vim-jsx-improve', {'for': ['javascript.jsx']}
Plug 'othree/html5.vim', {'for': ['html']}

" typescript ... yuck
Plug 'leafgarland/typescript-vim', {'for': ['typescript']}

Plug 'fatih/vim-go', {'for': ['go']}

Plug 'rhysd/vim-clang-format', {'for': ['c','cpp']}

" rust
Plug 'rust-lang/rust.vim', {'for': ['rust']}

Plug 'ctrlpvim/ctrlp.vim'
Plug 'powerline/powerline'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

Plug 'morhetz/gruvbox'
Plug 'powerline/fonts'

Plug '2072/PHP-Indenting-for-VIm', { 'for': ['php'] }

" terraform files
Plug 'hashivim/vim-terraform', { 'for': ['terraform'] }

" graph ql files
Plug 'jparise/vim-graphql', { 'for': 'graphql' }


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
" let g:ctrlp_working_path_mode = 'ra' " r is search from nearest ancestor (.git .svn etc)
let g:ctrlp_working_path_mode = 'ra' " w is search from cwd 
let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules\|\.(git|hg|svn|docs)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" ctrl-n opens
map <C-n> :NERDTreeToggle<CR>

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
autocmd FileType rust let g:rustfmt_autosave=1

" this is supposed to auto format on save but it doesnt do anything....
autocmd FileType terraform let g:terraform_fmt_on_save=1

set ic
