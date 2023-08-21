
let b:ale_linters={
  \  'markdown': []
  \ }

autocmd FileType markdown set foldexpr=NestedMarkdownFolds()
" syntax highlighting in md
let g:markdown_fenced_languages = ['sh', 'bash',
  \ 'rust',
  \ 'kotlin',
  \ 'javascript',
  \ 'xml', 'yaml', 'json', 'html',
  \ 'python', 'ruby', 'vim'
  \ ]
let g:mkdx#settings = { 'highlight': { 'enable': 1 },
  \ 'enter': { 'shift': 1 },
  \ 'links': { 'external': { 'enable': 1 } },
  \ 'toc' : { 'text': 'Table Of Contents', 'update_on_write': 1 },
  \ 'fold': { 'enable': 1 } }
