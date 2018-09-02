call plug#begin('~/.local/share/nvim/plugged')

"general plugins
Plug 'junegunn/vim-easy-align'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" ==== language specific ====
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
"cant get racer to install
"Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }

"Plug 'joegesualdo/jsdoc.vim', { 'for': 'javascript'}

call plug#end()

"general
"enable mouse support
set mouse=a

colorscheme gruvbox
set background=dark
let g:gruvbox_termcolors=256

map <C-n> :NERDTreeToggle<CR>

"rust-lang/rust.vim
let g:rustfmt_autosave = 1

"Shougo/depoplete.nvim
"

"sebastianmarkow/deoplete-rust
" cant get racer to install
"let g:deoplete#sources#rust#racer_binary='/path/to/racer'
"    set path to rust source code
"let g:deoplete#sources#rust#rust_source_path='~/workspace/rust/rust-lang-src/src'
"

" tabstop: display actual tab characters with this many spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
