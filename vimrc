set nocompatible              " be iMproved, required
filetype off                  " required
let g:ale_completion_enabled = 0
let g:ale_set_balloons = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 0

" let g:ale_list_vertical = 1
"
"
"vim-plug
"

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

""""""""
" Vundle
""""""""
" set the runtime path to include Vundle and initialize
set rtp+=/opt/homebrew/opt/fzf
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
call plug#begin() 
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'sickill/vim-monokai'
" Plugin 'crusoexia/vim-monokai'
" Plugin 'tomasr/molokai'
" Plugin 'dracula/vim', { 'name': 'dracula'  }
" Plugin 'altercation/vim-colors-solarized'
Plug 'Yggdroot/indentLine'
" Plugin 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/gv.vim'
Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
Plug 'dense-analysis/ale'
" Plug 'valloric/youcompleteme', { 'do': './install.py  --clang-completer --rust-completer --ts-completer' }
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'burntsushi/ripgrep',
" Plug 'pangloss/vim-javascript'
" Plugin 'mxw/vim-jsx'
Plug 'jxnblk/vim-mdx-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jiangmiao/auto-pairs'
Plug 'stephpy/vim-yaml'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chr4/nginx.vim'
" Plugin 'chr4/sslsecure.vim'
" Plugin 'lervag/vimtex'
Plug 'elzr/vim-json'
Plug 'scrooloose/nerdcommenter'
" Plugin 'cespare/vim-toml'
Plug 'tpope/vim-obsession'
" Plugin 'digitaltoad/vim-pug'
" Plugin 'heavenshell/vim-jsdoc'
" Plug 'rust-lang/rust.vim'
Plug 'jparise/vim-graphql'
Plug 'editorconfig/editorconfig-vim'
Plug 'leafgarland/typescript-vim'
" Plug 'xolox/vim-notes'
" Plug 'xolox/vim-misc'
" Plugin 'itchyny/lightline.vim'
Plug 'preservim/vim-markdown'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
" Plug 'github/copilot.vim'

"
" Plugin 'othree/html5.vim'
" Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'

" Plugin 'reewr/vim-monokai-phoenix'
" Plugin 'godlygeek/tabular'
" Plugin 'jamshedvesuna/vim-markdown-preview'
" Plugin 'junegunn/vim-emoji'
" Plugin 'KeitaNakamura/tex-conceal.vim'
" Plugin 'fatih/vim-go'
" Plugin 'LaTeX-Box-Team/LaTeX-Box'
" Plugin 'peitalin/vim-jsx-typescript'
" All of your Plugins must be added before the following line
" call vundle#end()            " required
call plug#end()
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


let g:coc_global_extensions = [
  \ 'coc-json',
  \ 'coc-tsserver', 'coc-rust-analyzer', 'coc-css', 'coc-docker', 'coc-eslint', 'coc-html', 'coc-fzf-preview', 'coc-yaml',
  \ 'coc-sh',
  \ 'coc-sql',
  \ 'coc-svg'
  \ ]

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
set regexpengine=0
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
" nnoremap <leader>Z :FZF<CR>
nnoremap <leader>l j0i<CR>
nnoremap <leader>a :ALELint<CR>

" fzfz-preview
nmap <Leader>z [fzf-p]
xmap <Leader>z [fzf-p]

nnoremap <silent> [fzf-p]z     :<C-u>CocCommand fzf-preview.ProjectFiles<CR>
nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>

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
set colorcolumn=80,100,120


" @TODO ???
" syntax sync minlines=256


" do not hide markdown
set conceallevel=0



" Make Vim to handle long lines nicely.
set wrap
set textwidth=100 " 79
set formatoptions=qrn1

let g:gruvbox_italic=1
set background=dark 
" set termguicolors
" let base16colorspace=256 
silent! colorscheme  gruvbox
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" let g:colors_name='monokai'
" let s:colors_name='monokai'
" let g:colors_name='monokai'
" set t_Co=256
" let g:monokai_term_italic = 1
" let g:monokai_gui_italic = 1

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" if has('autocmd')
"    " change colorscheme depending on current buffer
"    " if desired, you may set a user-default colorscheme before this point,
"    " otherwise we'll use the Vim default.
"    " Variables used:
"        " g:colors_name : current colorscheme at any moment
"        " b:colors_name (if any): colorscheme to be used for the current buffer
"        " s:colors_name : default colorscheme, to be used where b:colors_name hasn't been set
"    if has('user_commands')
"        " User commands defined:
"            " ColorScheme <name>
"                " set the colorscheme for the current buffer
"            " ColorDefault <name>
"                " change the default colorscheme
"        command -nargs=1 -bar ColorScheme
"           \ colorscheme <args>
"           \ | let b:colors_name = g:colors_name
"        command -nargs=1 -bar ColorDefault
"           \ let s:colors_name = <q-args>
"           \ | if !exists('b:colors_name')
"               \ | colors <args>
"           \ | endif
"    endif
"    if !exists('g:colors_name')
"        let g:colors_name = 'default'
"    endif
"    let s:colors_name = g:colors_name
"    au BufEnter *
"        \ let s:new_colors = (exists('b:colors_name')?(b:colors_name):(s:colors_name))
"        \ | if s:new_colors != g:colors_name
"            \ | exe 'colors' s:new_colors
"        \ | endif
" endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set backupcopy=yes
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

" Set spelling
set spell
" :setlocal spell spelllang=pt_pt
hi SpellBad cterm=underline ctermfg=red

" This is the default extra key bindings
" let g:fzf_action = {
"   \ 'ctrl-t': 'tab split',
"   \ 'ctrl-x': 'split',
"   \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
" let g:fzf_layout = { 'down': '~40%' }
" let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95  }  }
" let g:fzf_preview_window = 'right:40%'

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
" let g:fzf_history_dir = '~/.local/share/fzf-history'


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
" let g:NERDAltDelims_javascript = 1
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

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
let g:airline_theme='simple'
let g:airline#extensions#obsession#enabled = 1
let g:airline#extensions#obsession#indicator_text = '$Obsession$'
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

" highlight frontmatter
" let g:vim_markdown_frontmatter = 1
" let g:vim_markdown_toml_frontmatter = 1
" let g:vim_markdown_json_frontmatter = 1
" markdown preview
" let vim_markdown_preview_browser='Firefox'
" let vim_markdown_preview_github=1

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
let g:vim_json_conceal=0
let g:markdown_syntax_conceal=0
let g:indentLine_concealcursor=""

""""""""""""""
" vim javascript
""""""""""""""
" let g:javascript_plugin_flow = 1

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
" How can I use ALE with other LSP clients?
" ALE offers an API for letting any other plugin integrate with ALE. If you are interested in writing an integration, see :help ale-lint-other-sources.
" If you are running ALE in combination with another LSP client, you may wish to disable ALE's LSP functionality entirely. You can add a setting to your vimrc/init.vim to do so.
" You can also use b:ale_disable_lsp in your ftplugin files to enable or disable LSP features in ALE for different filetypes.
let g:ale_disable_lsp = 1

let g:ale_sign_column_always = 1
let g:ale_linters_explicit = 1
let g:ale_lint_delay = 500
" let g:ale_fixers = {
" \   'scss': ['prettier'],
" \   'html': ['prettier']
" \ }
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)

nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>hn <Plug>(GitGutterNextHunk)
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
inoremap <c-x><c-k> <c-x><c-k>
" nnoremap <leader>y :YcmCompleter<CR>
" nnoremap <leader>yg :YcmCompleter GoTo<CR>
" nnoremap <leader>yr :YcmCompleter GoToReferences<CR>

" if !exists("g:ycm_semantic_triggers")
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers['typescript'] = ['.']

" let g:ycm_key_list_select_completion=['<c-n>']
" let g:ycm_key_list_previous_completion=['<c-p']
" Snippets
" set rtp+=~/.vim/plugins/vim-snippets
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/plugins/vim-snippets", $HOME."/.vim/UltiSnips"]
" JSON
" command PrettyJSON %!python -m json.tool
" Filetype json

" EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

" JsDoc
let g:jsdoc_enable_es6 = 1

"""""""""
" coc
"""""""""
" See: https://github.com/neoclide/coc.nvim/wiki/F.A.Q
"  <tab> not working well with copilot.vim
" copilot.vim remaps your <tab>, it checks pumvisible but not coc#pum#visible, so it not work well with the custom popup menu. You can disable the overwrite and define the <tab> to meet your need, like:
" use <C-e> to cancel the popup menu(if it's not remapped).

" let g:copilot_no_tab_map = v:true
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1):
"       \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
"       \ CheckBackSpace() ? "\<Tab>" :
"       \ coc#refresh()
" let g:copilot_filetypes = { '*': v:false }

"'python': v:true 
  
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
" set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" " Use tab for trigger completion with characters ahead and navigate
" " NOTE: There's always complete item selected by default, you may want to enable
" " no select by `"suggest.noselect": true` in your configuration file
" " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" " other plugin before putting this into your config
" inoremap <silent><expr> <TAB>
"       \ coc#pum#visible() ? coc#pum#next(1) :
"       \ CheckBackspace() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" function! CheckBackspace() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> to trigger completion
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" " Use `[g` and `]g` to navigate diagnostics
" " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" " Use K to show documentation in preview window
" nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" " Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Symbol renaming
" nmap <leader>rn <Plug>(coc-rename)

" " Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s)
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Applying code actions to the selected code block
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying code actions at the cursor position
" nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" " Remap keys for apply code actions affect whole buffer
" nmap <leader>as  <Plug>(coc-codeaction-source)
" " Apply the most preferred quickfix action to fix diagnostic on the current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Remap keys for applying refactor code actions
" nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
" xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" " Run the Code Lens action on the current line
" nmap <leader>cl  <Plug>(coc-codelens-action)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" " Remap <C-f> and <C-b> to scroll float windows/popups
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" " Use CTRL-S for selections ranges
" " Requires 'textDocument/selectionRange' support of language server
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer
" command! -nargs=0 Format :call CocActionAsync('format')

" " Add `:Fold` command to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer
" command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings for CoCList
" " Show all diagnostics
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

nmap <leader>qf  <Plug>(coc-fix-current)

"""""""""
" Custom
"""""""""
nmap cf :let @" = expand("%")<cr>"
nmap cp :let @" = expand("%:p")<cr>"

" vim-notes
:let g:notes_directories = ['~/Documents/Notes']
:let g:notes_conceal_code = 0
:let g:notes_conceal_italic = 0
:let g:notes_conceal_bold = 0
:let g:notes_conceal_url = 0

:let g:python3_host_prog='/opt/homebrew/bin/python3.11'
:let g:python_host_prog='/opt/homebrew/bin/python3.11'
" :let g:python3_host_prog=/opt/homebrew/bin/python3
" :let g:python_host_prog=/opt/homebrew/bin/python3
