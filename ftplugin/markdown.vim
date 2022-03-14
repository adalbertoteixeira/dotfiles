" spell check on
setlocal spell

" remove conceal
setlocal conceallevel=0

""""""""""""""
" vim markdown
""""""""""""""
let g:vim_markdown_folding_disabled = 1
" Disable conceal
let g:vim_markdown_conceal = 0 " 2 for Vim's defaults
let g:vim_markdown_conceal_code_blocks = 0
set nofoldenable
let g:markdown_fenced_languages = ['html', 'python', 'javascript=js']

