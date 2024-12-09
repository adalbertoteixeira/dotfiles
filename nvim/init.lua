vim.g.loaded_perl_provider = 0
-- vim.o.rocks.enabled = false

-- Make sure to setup `mapleader` and `maplocalleader` BEFORE
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.lazy")

-- Toggle Neotree
vim.api.nvim_set_keymap('n', '<leader>tt', ':Neotree toggle<cr>', {noremap = true})
-- Open Neotree at current file
vim.api.nvim_set_keymap('n', '<leader>tf', ':Neotree %<cr>', {noremap = true})
-- Open Neotree git status
vim.api.nvim_set_keymap('n', '<leader>tg', ':Neotree git_status<cr>', {noremap = true})
-- Open Neotree at current file
vim.api.nvim_set_keymap('n', '<leader>tb', ':Neotree buffers<cr>', {noremap = true})

vim.cmd('filetype plugin indent on')
vim.cmd('colorscheme onedark')

vim.o.history=500

vim.o.autoread=true
-- vim.o.noshowcmd=true
vim.o.regexpengine=0

vim.o.so=5

--  Avoid garbled characters in Chinese language windows OS
-- vim.cmd("language english")
vim.o.langmenu=en
vim.o.wildignore='*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'

--  Height of the command bar
vim.o.cmdheight=2

-- A buffer becomes hidden when it is abandoned
vim.o.hid = true

vim.o.ignorecase = true

-- When searching try to be smart about cases
vim.o.smartcase = true

-- Highlight search results
vim.o.hlsearch = true

-- Makes search act like search in modern browsers
vim.o.incsearch = true

-- Don't redraw while executing macros (good performance config)
vim.o.lazyredraw = true

-- For regular expressions turn magic on
vim.o.magic = true
vim.o.clipboard = 'unnamed'
vim.api.nvim_set_keymap('n', '/', '/\\v', {noremap = true})

-- ALE
vim.g.ale_use_neovim_diagnostics_api = 1
vim.g.ale_disable_lsp = 1
vim.api.nvim_set_keymap('n', '<leader>ai', ':ALEInfo<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>ak', ':ALEPrevious<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>aj', ':ALENext<CR>', {noremap = true})
-- nmap <silent> <C-k> <Plug>(ale_previous)
-- nmap <silent> <C-j> <Plug>(ale_next)
-- let g:ale_sign_error = '>>'
-- let g:ale_sign_warning = '--'

vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fl', ':Telescope live_grep<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope git_files<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fs', ':Telescope grep_string<CR>', {noremap = true})
vim.api.nvim_set_keymap('v', '<leader>fs', ':Telescope grep_string<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', {noremap = true})

vim.keymap.set("n", "<leader>fr", ":Telescope file_browser<CR>")
-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap("n", "<leader>frb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true})

-- " This is the default extra key bindings
-- " let g:fzf_action = {
-- "   \ 'ctrl-t': 'tab split',
-- "   \ 'ctrl-x': 'split',
-- "   \ 'ctrl-v': 'vsplit' }
--
-- " Default fzf layout
-- " - down / up / left / right
-- " let g:fzf_layout = { 'down': '~40%' }
-- " let g:fzf_layout = { 'window': { 'width': 0.95, 'height': 0.95  }  }
-- " let g:fzf_preview_window = 'right:40%'
--
-- " In Neovim, you can set up fzf window using a Vim command
-- " let g:fzf_layout = { 'window': 'enew' }
-- " let g:fzf_layout = { 'window': '-tabnew' }
-- " let g:fzf_layout = { 'window': '10split enew' }
--
-- " Customize fzf colors to match your color scheme
-- " let g:fzf_colors =
-- " \ { 'fg':      ['fg', 'Normal'],
-- "   \ 'bg':      ['bg', 'Normal'],
-- "   \ 'hl':      ['fg', 'Comment'],
-- "   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
-- "   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
-- "   \ 'hl+':     ['fg', 'Statement'],
-- "   \ 'info':    ['fg', 'PreProc'],
-- "   \ 'border':  ['fg', 'Ignore'],
-- "   \ 'prompt':  ['fg', 'Conditional'],
-- "   \ 'pointer': ['fg', 'Exception'],
-- "   \ 'marker':  ['fg', 'Keyword'],
-- "   \ 'spinner': ['fg', 'Label'],
-- "   \ 'header':  ['fg', 'Comment'] }
--
-- " Enable per-command history.
-- " CTRL-N and CTRL-P will be automatically bound to next-history and
-- " previous-history instead of down and up. If you don't like the change,
-- " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
-- " let g:fzf_history_dir = '~/.local/share/fzf-history'
vim.o.showmatch=true
-- " How many tenths of a second to blink when matching brackets
vim.o.mat=2
--
vim.o.showmatch=true
-- " How many tenths of a second to blink when matching brackets
vim.o.mat=2
--
-- " No annoying sound on errors
vim.o.errorbells=false
vim.o.visualbell=false
-- vim.o.t_vb=true
vim.o.tm=500
-- " Time out on key codes but not mappings.
-- " Basically this makes terminal Vim work sanely.
vim.o.timeout=false
vim.o.ttimeout=true
vim.o.ttimeoutlen=10
--
vim.o.hlsearch=false
vim.o.splitright=true
vim.o.splitbelow=true

--
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " Syntax
-- """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " speed up syntax highlighting
vim.o.cursorcolumn= false
vim.o.cursorline = true
--
-- " Enable syntax highlighting
vim.cmd('syntax enable')
vim.o.synmaxcol=250
vim.o.colorcolumn='80,100,120'
--
--
--
-- " do not hide markdown
-- set conceallevel=0
--
--
--
-- " Make Vim to handle long lines nicely.
vim.o.wrap=true
vim.o.textwidth=100 
vim.o.formatoptions=qrn1
--
vim.o.background=dark 
-- " No need to set explicitly under Neovim: always uses UTF-8 as the default encoding.
-- " Set utf8 as standard encoding and en_US as the standard language
vim.o.encoding=utf8
-- vim.o.guifont=VictorMono_Nerd_Font
--
-- " Use Unix as the standard file type
vim.o.ffs=unix,dos,mac
--
--
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " => Files, backups and undo
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- " Turn backup off, since most stuff is in SVN, git et.c anyway...
-- vim.o.backupcopy=yes
vim.o.backup=false
vim.o.wb=false
vim.o.swapfile=false
--
vim.g.indent_guides_enable_on_vim_startup = 1
-- " Use spaces instead of tabs
vim.o.expandtab=true
--
-- " Be smart when using tabs ;)
vim.o.smarttab=true
--
-- " 1 tab == 2 spaces
vim.o.shiftwidth=2
vim.o.tabstop=2
--
-- " Linebreak on 500 characters
-- " set lbr
-- " set tw=100
--Auto indent
vim.o.ai =true
-- ="Smart indent
vim.o.si =true
-- "Wrap lines
vim.o.wrap =true
--
--
vim.o.number = true
-- " set numberwidth=8
vim.o.mouse=a
vim.o.showmode=false
--
-- " Set spelling
vim.o.spell=true
-- " :setlocal spell spelllang=pt_pt
-- hi SpellBad cterm=underline ctermfg=red
--
--
--
-- """"""""""""""""""""""""""""""
-- " => Status line
-- """"""""""""""""""""""""""""""
-- " Always show the status line
-- vim.o.laststatus=2
--
-- "set statusline+=%#warningmsg#
-- "set statusline+=%*
-- """"""""""""""""""""""""""""""
-- " => nerdcommenter / Commnet.vim
-- """"""""""""""""""""""""""""""
-- " let NERDSpaceDelims = 1
--
-- " """""""""""
-- " " Lightline
-- " """""""""""
--
--
-- """"""""""""""
-- " vim json
-- """"""""""""""
-- " let g:vim_json_syntax_conceal = 0
-- " let g:vim_json_conceal=0
-- " let g:markdown_syntax_conceal=0
-- " let g:indentLine_concealcursor=""
--
--
-- autocmd BufNewFile,BufRead *.mts :set filetype=typescript
--
--
vim.api.nvim_set_keymap("n", '<leader>hk', ':GitGutterPrevHunk<CR>', {noremap=true})
vim.api.nvim_set_keymap("n", '<leader>hj', ':GitGutterNextHunk<CR>', {noremap=true})
-- nmap <Leader>hp <Plug>(GitGutterPrevHunk)
-- nmap <Leader>hn <Plug>(GitGutterNextHunk)
-- inoremap <c-x><c-k> <c-x><c-k>
--
-- " EditorConfig
-- let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
--
-- " JsDoc
-- let g:jsdoc_enable_es6 = 1
--
-- """""""""
-- " coc
-- """""""""
-- vim.cmd([[
-- paste code from https://github.com/neoclide/coc.nvim#example-vim-configuration
-- ]])
-- " See: https://github.com/neoclide/coc.nvim/wiki/F.A.Q
-- "  <tab> not working well with copilot.vim
-- " copilot.vim remaps your <tab>, it checks pumvisible but not coc#pum#visible, so it not work well with the custom popup menu. You can disable the overwrite and define the <tab> to meet your need, like:
-- " use <C-e> to cancel the popup menu(if it's not remapped).
--
-- " let g:copilot_no_tab_map = v:true
-- " inoremap <silent><expr> <TAB>
-- "       \ coc#pum#visible() ? coc#pum#next(1):
-- "       \ exists('b:_copilot.suggestions') ? copilot#Accept("\<CR>") :
-- "       \ CheckBackSpace() ? "\<Tab>" :
-- "       \ coc#refresh()
-- " let g:copilot_filetypes = { '*': v:false }
--
-- "'python': v:true 
--
-- " Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- " delays and poor user experience
-- " set updatetime=300
--
-- " Always show the signcolumn, otherwise it would shift the text each time
-- " diagnostics appear/become resolved
-- set signcolumn=yes
--
-- " " Use tab for trigger completion with characters ahead and navigate
-- " " NOTE: There's always complete item selected by default, you may want to enable
-- " " no select by `"suggest.noselect": true` in your configuration file
-- " " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
-- " " other plugin before putting this into your config
-- " inoremap <silent><expr> <TAB>
-- "       \ coc#pum#visible() ? coc#pum#next(1) :
-- "       \ CheckBackspace() ? "\<Tab>" :
-- "       \ coc#refresh()
-- " inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local keyset = vim.keymap.set
-- https://gist.github.com/dinhmai74/4fc774dfd69750ce9ed706620a5082a9
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})
--
-- " Make <CR> to accept selected completion item or notify coc.nvim to format
-- " <C-g>u breaks current undo, please make your own choice
-- inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
--                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
--
--
--
-- " " Use K to show documentation in preview window
-- " nnoremap <silent> K :call ShowDocumentation()<CR>
-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end
keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
--
-- function! ShowDocumentation()
--   if CocAction('hasProvider', 'hover')
--     call CocActionAsync('doHover')
--   else
--     call feedkeys('K', 'in')
--   endif
-- endfunction
--
-- " " Highlight the symbol and its references when holding the cursor
-- " autocmd CursorHold * silent call CocActionAsync('highlight')
--
-- " " Symbol renaming
-- " nmap <leader>rn <Plug>(coc-rename)
--
-- " " Formatting selected code
-- " xmap <leader>f  <Plug>(coc-format-selected)
-- " nmap <leader>f  <Plug>(coc-format-selected)
--
-- " augroup mygroup
-- "   autocmd!
-- "   " Setup formatexpr specified filetype(s)
-- "   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
-- "   " Update signature help on jump placeholder
-- "   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
-- " augroup end
--
-- " " Applying code actions to the selected code block
-- " " Example: `<leader>aap` for current paragraph
-- " xmap <leader>a  <Plug>(coc-codeaction-selected)
-- " nmap <leader>a  <Plug>(coc-codeaction-selected)
--
-- " " Remap keys for applying code actions at the cursor position
-- " nmap <leader>ac  <Plug>(coc-codeaction-cursor)
-- " " Remap keys for apply code actions affect whole buffer
-- " nmap <leader>as  <Plug>(coc-codeaction-source)
-- " " Apply the most preferred quickfix action to fix diagnostic on the current line
-- " nmap <leader>qf  <Plug>(coc-fix-current)
--
-- " " Remap keys for applying refactor code actions
-- " nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
-- " xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
-- " nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
--
-- " " Run the Code Lens action on the current line
-- " nmap <leader>cl  <Plug>(coc-codelens-action)
--
-- " " Map function and class text objects
-- " " NOTE: Requires 'textDocument.documentSymbol' support from the language server
-- " xmap if <Plug>(coc-funcobj-i)
-- " omap if <Plug>(coc-funcobj-i)
-- " xmap af <Plug>(coc-funcobj-a)
-- " omap af <Plug>(coc-funcobj-a)
-- " xmap ic <Plug>(coc-classobj-i)
-- " omap ic <Plug>(coc-classobj-i)
-- " xmap ac <Plug>(coc-classobj-a)
-- " omap ac <Plug>(coc-classobj-a)
--
-- " " Remap <C-f> and <C-b> to scroll float windows/popups
-- " if has('nvim-0.4.0') || has('patch-8.2.0750')
-- "   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
-- "   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
-- "   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
-- "   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
-- "   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
-- "   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
-- " endif
--
-- " " Use CTRL-S for selections ranges
-- " " Requires 'textDocument/selectionRange' support of language server
-- " nmap <silent> <C-s> <Plug>(coc-range-select)
-- " xmap <silent> <C-s> <Plug>(coc-range-select)
--
-- " " Add `:Format` command to format current buffer
-- " command! -nargs=0 Format :call CocActionAsync('format')
--
-- " " Add `:Fold` command to fold current buffer
-- " command! -nargs=? Fold :call     CocAction('fold', <f-args>)
--
-- " " Add `:OR` command for organize imports of the current buffer
-- " command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
--
-- " " Add (Neo)Vim's native statusline support
-- " " NOTE: Please see `:h coc-status` for integrations with external plugins that
-- " " provide custom statusline: lightline.vim, vim-airline
-- " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
--
-- " " Mappings for CoCList
-- " " Show all diagnostics
-- " nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
-- " " Manage extensions
-- " nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
-- " " Show commands
-- " nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
-- " " Find symbol of current document
-- " nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
-- " " Search workspace symbols
-- " nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
-- " " Do default action for next item
-- " nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
-- " " Do default action for previous item
-- " nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
-- " " Resume latest coc list
-- " nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
--
-- nmap <leader>qf  <Plug>(coc-fix-current)
--
-- """""""""
-- " Custom
-- """""""""
-- nmap cf :let @" = expand("%")<cr>"
-- nmap cp :let @" = expand("%:p")<cr>"
--
-- :let g:python3_host_prog='/opt/homebrew/bin/python3.11'
-- :let g:python_host_prog='/opt/homebrew/bin/python3.11'
--
