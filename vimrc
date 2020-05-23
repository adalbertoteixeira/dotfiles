set nocompatible              " be iMproved, required
filetype off                  " required
let g:ale_completion_enabled = 0
let g:ale_set_balloons = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0

""""""""
" Vundle
""""""""
" set the runtime path to include Vundle and initialize
set rtp+=/usr/local/bin/fzf
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'crusoexia/vim-monokai'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/gv.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'w0rp/ale'
Plugin 'valloric/youcompleteme'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'burntsushi/ripgrep'
Plugin 'jremmen/vim-ripgrep'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'jiangmiao/auto-pairs'
Plugin 'stephpy/vim-yaml'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chr4/nginx.vim'
" Plugin 'chr4/sslsecure.vim'
Plugin 'lervag/vimtex'
Plugin 'elzr/vim-json'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'cespare/vim-toml'
Plugin 'tpope/vim-obsession'
Plugin 'digitaltoad/vim-pug'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'heavenshell/vim-jsdoc'
Plugin 'rust-lang/rust.vim'
Plugin 'jparise/vim-graphql'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'itchyny/lightline.vim'
Plugin 'plasticboy/vim-markdown'

" Plugin 'reewr/vim-monokai-phoenix'
" Plugin 'godlygeek/tabular'
" Plugin 'jamshedvesuna/vim-markdown-preview'
" Plugin 'tpope/vim-dadbod'
" Plugin 'junegunn/vim-emoji'
" Plugin 'sicklii/vim-monokai'
" Plugin 'KeitaNakamura/tex-conceal.vim'
" Plugin 'fatih/vim-go'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'peitalin/vim-jsx-typescript'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

set noshowcmd
set regexpengine=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=5

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
"set wildmenu

" Ignore compiled files
"set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Make vim regexps use verymagic (more like PCREs, write \w+ instead if \w\+)
nnoremap / /\v
" cnoremap %s/ %smagic/
" cnoremap \>s/ \>smagic/
" nnoremap :g/ :g/\v
" nnoremap :g// :g//
"set clipboard="
set clipboard=unnamed

set foldcolumn=1
" Keys
"vnoremap <D-c> "+y
vnoremap <leader>c "+y
nnoremap <leader>t :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>Z :FZF<CR>
nnoremap <leader>l j0i<CR>
nnoremap <leader>a :ALELint<CR>

set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

set nohlsearch
set splitright
set splitbelow


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" speed up syntax highlighting
set nocursorcolumn
set cursorline

" Enable syntax highlighting
syntax enable
set synmaxcol=250
set colorcolumn=80


" @TODO ???
" syntax sync minlines=256


" do not hide markdown
set conceallevel=0



" Make Vim to handle long lines nicely.
set wrap
set textwidth=100 " 79
set formatoptions=qrn1

let g:colors_name='monokai'
let s:colors_name='monokai'
let g:colors_name='monokai'
silent! colorscheme monokai
set t_Co=256
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

if has('autocmd')
   " change colorscheme depending on current buffer
   " if desired, you may set a user-default colorscheme before this point,
   " otherwise we'll use the Vim default.
   " Variables used:
       " g:colors_name : current colorscheme at any moment
       " b:colors_name (if any): colorscheme to be used for the current buffer
       " s:colors_name : default colorscheme, to be used where b:colors_name hasn't been set
   if has('user_commands')
       " User commands defined:
           " ColorScheme <name>
               " set the colorscheme for the current buffer
           " ColorDefault <name>
               " change the default colorscheme
       command -nargs=1 -bar ColorScheme
          \ colorscheme <args>
          \ | let b:colors_name = g:colors_name
       command -nargs=1 -bar ColorDefault
          \ let s:colors_name = <q-args>
          \ | if !exists('b:colors_name')
              \ | colors <args>
          \ | endif
   endif
   if !exists('g:colors_name')
       let g:colors_name = 'default'
   endif
   let s:colors_name = g:colors_name
   au BufEnter *
       \ let s:new_colors = (exists('b:colors_name')?(b:colors_name):(s:colors_name))
       \ | if s:new_colors != g:colors_name
           \ | exe 'colors' s:new_colors
       \ | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
" :set backupcopy=yes
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
" set lbr
" set tw=100

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


set number
" set numberwidth=8
set mouse=a
set noshowmode

" Set spelling on markdown files
" :setlocal spell spelllang=pt_pt

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'left': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"set statusline+=%#warningmsg#
"set statusline+=%*
""""""""""""""""""""""""""""""
" => nerdcommenter
""""""""""""""""""""""""""""""
let NERDSpaceDelims = 1

""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""
let NERDTreeShowHidden=1
" How can I open a NERDTree automatically when vim starts up?
" autocmd vimenter * NERDTree

" How can I open a NERDTree automatically when vim starts up if no files were specified?
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" How can I open NERDTree automatically when vim starts up on opening a directory?
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0

" How can I close vim if the only window left open is a NERDTree?
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" """""""""""
" " Lightline
" """""""""""

" let g:lightline = {
"   \ 'colorscheme': 'powerline',
"   \ 'active': {
"   \   'left': [ [ 'mode', 'paste' ],
"   \             [ 'readonly', 'filename', 'buffernumber', 'modified', 'gitbranch' ] ]
"   \ },
"   \ 'component' : {
"   \   'pathtofile': '%f',
"   \   'buffernumber': '%n'
"   \ },
"   \ 'component_function': {
"   \   'gitbranch': 'fugitive#head',
"   \   'gitstatus': '%{fugitive#statusline()}',
"   \   'obsessionstatus': '%{ObsessionStatus()}'
"   \ },
" \ }

" Multi-cursor default mapping
" let g:multi_cursor_next_key='<C-n>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

""""""""""""""
" vim markdown
""""""""""""""
let g:vim_markdown_folding_disabled = 1
" Disable conceal
let g:vim_markdown_conceal = 0
set nofoldenable
let g:markdown_fenced_languages = ['html', 'python', 'javascript=js']

" highlight frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
" markdown preview
let vim_markdown_preview_browser='Firefox'
let vim_markdown_preview_github=1

""""""""""""""
" vim tex
""""""""""""""
" let g:tex_conceal=''
" g:tex_conceal=''
" a = accents/ligatures
" d = delimiters
" m = math symbols
" g = Greek
" s = superscripts/subscripts

""""""""""""""
" rust
""""""""""""""
let g:rustfmt_autosave = 1

""""""""""""""
" vim json
""""""""""""""
let g:vim_json_syntax_conceal = 0

""""""""""""""
" vim javascript
""""""""""""""
let g:javascript_plugin_flow = 1

" vim-go
" let g:go_highlight_array_whitespace_error = 1
" let g:go_highlight_chan_whitespace_error = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_space_tab_error = 1
" let g:go_highlight_trailing_whitespace_error = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_arguments = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_generate_tags = 1
" let g:go_highlight_string_spellcheck = 1
" let g:go_highlight_format_strings = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1

" ALE
let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_lint_delay = 0
let g:ale_set_loclist = 1
" let g:ale_set_quickfix = 1
" let g:ale_open_list = 0
let g:ale_fixers = {
\   'scss': ['prettier'],
\   'html': ['prettier']
\ }
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>hn <Plug>(GitGutterNextHunk)
" silent! if emoji#available()
  " let g:gitgutter_sign_added = emoji#for('star')
  " let g:gitgutter_sign_modified = emoji#for('dizzy')
  " let g:gitgutter_sign_removed = emoji#for('broken_heart')
  " let g:gitgutter_sign_modified_removed = emoji#for('collision')
  " let g:gitgutter_override_sign_column_highlight = 0

  " highlight clear ALEErrorSign
  " highlight clear ALEWarningSign
  " let g:ale_sign_error = emoji#for('rage')
  " let g:ale_sign_warning = emoji#for('angry')
" else
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '--'
" endif
inoremap <c-x><c-k> <c-x><c-k>
nnoremap <leader>y :YcmCompleter<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']

let g:ycm_key_list_select_completion=['<c-n>']
let g:ycm_key_list_previous_completion=['<c-p']
" Snippets
" set rtp+=~/.vim/plugins/vim-snippets
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/plugins/vim-snippets", $HOME."/.vim/UltiSnips"]
" JSON
" command PrettyJSON %!python -m json.tool
" Filetype json

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" JsDoc
let g:jsdoc_enable_es6 = 1


"""""""""
" Custom
"""""""""
nmap cf :let @" = expand("%")<cr>"
nmap cp :let @" = expand("%:p")<cr>"
