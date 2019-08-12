set encoding=utf-8
scriptencoding utf-8

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logiPat = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_rrhelper = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

if has('vim_starting')
    "Required
    set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

    if !has('nvim')
        "In the insert mode, a cursor is vertical bar
        let &t_SI .= "\e[6 q"
        "In the normal mode, a cursor is block
        let &t_EI .= "\e[2 q"
        "In the replace mode, a cursor is under bar
        let &t_SR .= "\e[4 q"
    endif
endif

if dein#load_state('~/.vim/bundles/')
    call dein#begin('~/.vim/bundles')
    call dein#load_toml('~/.vim/dein.toml', {'lazy':0})
    call dein#load_toml('~/.vim/dein-lazy.toml', {'lazy':1})
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
"Reqired
filetype plugin indent on
syntax enable

set number
set ruler
set laststatus=2
set showtabline=2
set showmatch
set matchtime=1
source $VIMRUNTIME/macros/matchit.vim
set helpheight=99
set wildmenu
set wildmode=longest:full
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set breakindent
set autoread
set backspace=indent,eol,start

if has('mac') && !has('nvim')
    set clipboard=unnamed,autoselect
elseif has('linux')
    set clipboard=unnamedplus,autoselect
else
    set clipboard+=unnamedplus
endif

set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set ambiwidth=double
set foldlevelstart=99
set undodir=~/.vim/undo
set undofile
set t_Co=256
set updatetime=500
"setting for vim on tmux
set t_ut=
if has('termguicolors')
    set termguicolors
    colorscheme iceberg
else
    set background=dark
    colorscheme hybrid
endif

"setting for access
set ignorecase
set smartcase
set wrapscan
set completeopt-=preview
set pumheight=10
set emoji
set list
set listchars=tab:^-,space:_
set signcolumn=yes

if has('mouse')
    set mouse=n
endif

if has('nvim')
    set inccommand=split
    set noshowcmd
    tnoremap <silent> <ESC> <C-\><C-n>
    autocmd TermOpen * setlocal nonumber

endif

noremap ; :
noremap : ;

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
nnoremap <silent> <S-t> :tabnew<CR>

"Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"############# functions #############
"move to the last edit point
augroup record_last_position
    autocmd!
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g`\"" | endif
augroup END

"do not auto-comment out on line feed
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r formatoptions-=o
augroup END

"auto-close html tags
augroup complete_tag
    autocmd!
    autocmd FileType html,xml inoremap <buffer> </ </<C-x><C-o>
augroup END

"if files are edited by another editor, it will be updated automatically
augroup vimrc_check_time
    autocmd!
    autocmd InsertEnter * checktime
augroup END

"clear blanks on end of the line
function! s:remove_dust()
    if &filetype != 'markdown'
        let cursor = getpos(".")
        %s/\s\+$//ge
        call setpos(".", cursor)
        unlet cursor
    endif
endfunction
autocmd BufWritePre * call <SID>remove_dust()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction
"############# end functions #############

call lexima#init()

"############# deoplete setting #############
" let g:deoplete#enable_at_startup = 1
inoremap <expr><CR> pumvisible() ? deoplete#close_popup() : lexima#expand('<LT>CR>', 'i')
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

inoremap <expr><C-g> deoplete#undo_completion()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"############# end deoplete #############

"############# neosnippet settings #############
let g:neosnippet#snippets_directory = '~/.vim/bundles/repos/github.com/fatih/vim-go/gosnippets/snippets'
" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif
"############# end neosnippet #############

"############# denite setting #############

nnoremap <silent> <Space>b :<C-u>Denite<Space>buffer file file_mru<CR>
nnoremap <silent> <Space>f :<C-u>DeniteBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Space>h :<C-u>Denite command_history<CR>
nnoremap <silent> <Space>j :<C-u>Denite jump<CR>
nnoremap <silent> <Space>o :<C-u>Denite unite:outline<CR>
nnoremap <silent> <Space>r :<C-u>Denite file/rec<CR>

autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
    nnoremap <silent><buffer><expr> <CR>
                \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> p
                \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
                \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
                \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
                \ denite#do_map('toggle_select').'j'
endfunction

"############# setting quickrun #############
if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
"############# end quickrun #############

"############# setting for ale #############

let g:ale_sign_error = '>'
let g:ale_sign_warning = '!'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_linters = {
            \   'cpp': ['clang', 'g++'],
            \}

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
                \   '%dW %dE',
                \   all_non_errors,
                \   all_errors
                \)
endfunction

augroup LightlineOnAle
    autocmd!
    autocmd User ALELintPost call lightline#update()
augroup END
"############# end ale #############

"############# setting lightline #############
let g:lightline = {
            \   'colorscheme': 'iceberg',
            \   'mode_map' : {
            \       'n' : 'N',
            \       'i' : 'I',
            \       'R' : 'REPLACE',
            \       'v' : 'V',
            \       'V': 'V-LINE',
            \       "\<C-v>": 'V-BLOCK',
            \       "s" : "S",
            \       "S" : "S-LINE",
            \       "\<C-s>" : "S-BLOCK",
            \       },
            \   'active' : {
            \        'left':[
            \            ['mode','paste'],
            \            ['readonly','gitbranch', 'filename','modified'],
            \        ],
            \
            \        'right':[
            \            ['lineinfo','syntaxcheck'],
            \            ['percent'],
            \            ['charcode', 'fileformat','fileencoding', 'filetype'],
            \        ]
            \    },
            \   'component_function':{
            \   'mode' : 'Mymode',
            \   'gitbranch' : 'Gitbranch',
            \   'fileformat' : 'Myfileformat',
            \   'fileencoding': 'Myfileencoding',
            \   'filetype' : 'Myfiletype',
            \   },
            \   'component_expand':{
            \   'syntaxcheck' : 'LinterStatus',
            \    },
            \   'component_type':{
            \   'syntaxcheck' : 'error',
            \   },
            \}

function! Mymode()
    return winwidth(0) > 30 ? lightline#mode() : ''
endfunction

function! Gitbranch()
    return gina#component#repo#branch()
endfunction

function! Myfileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! Myfileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! Myfiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

"############# end lightline #############

"############# setting is.vim #############
set incsearch
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
"############# end is.vim #############

"############# vim-operator-surround #############
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
"############# end vim-operator-surround #############

"############# tweetvim setting #############
autocmd FileType tweetvim call s:tweetvim_my_setting()
function! s:tweetvim_my_setting()
    nnoremap <buffer>s :<C-u>TweetVimSay<CR>
    nnoremap <silent>t :Unite tweetvim<CR>
    let g:tweetvim_tweet_per_page = 300
endfunction
"############# end tweetvim #############

"############# gundo settings #############
let g:gundo_prefer_python3 = 1

"############# end gundo #############

"############# previm settings #############
let g:previm_enable_realtime = 1

"############# end previm #############

"############# vim-startify settings #############
let g:startify_custom_header = [
            \ '                               ',
            \ '            __                 ',
            \ '    __  __ /\_\    ___ ___     ',
            \ '   /\ \/\ \\/\ \ /'' __` __`\  ',
            \ '   \ \ \_/ |\ \ \/\ \/\ \/\ \  ',
            \ '    \ \___/  \ \_\ \_\ \_\ \_\ ',
            \ '     \/__/    \/_/\/_/\/_/\/_/ ',
            \ ]

"############# end vim-startify #############

"############# defx.nvim settings #############
function! s:defx_settings() abort
    setlocal nonumber
    setlocal winfixwidth
    setlocal cursorline
    setlocal signcolumn=auto
    nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')
    nnoremap <silent><buffer><expr> O defx#do_action('open_tree_recursive')
    nnoremap <silent><buffer><expr> c defx#do_action('copy')
    nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> m defx#do_action('move')
    nnoremap <silent><buffer><expr> p defx#do_action('paste')
    nnoremap <silent><buffer><expr> r defx#do_action('rename')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> N defx#do_action('new_file')
    nnoremap <silent><buffer><expr> D defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> S defx#do_action('add_session')
endfunction

if dein#tap('defx.nvim')
    " nnoremap <silent><leader>d :Defx -toggle -split=vertical -winwidth=25 -direction=topleft
    "            \ -show-ignored-files `expand('%:p:h')` -search=`expand('%:p')` <CR>
    nnoremap <silent><leader>d :Defx -toggle -split=vertical -winwidth=25 -direction=topleft
                \ -show-ignored-files -session-file=`expand('~/.vim/session/defx_session')` <CR>

    autocmd FileType defx call s:defx_settings()
endif
"############# end defx.nvim #############

"############# vim-lsp settings #############
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_async_completion = 1
if has('nvim')
    let g:lsp_highlights_enabled = 0
else
    let g:lsp_textprop_enabled = 0
endif
if !has('nvim')
    let g:lsp_signs_error={'text': '✘'}
    let g:lsp_signs_warning={'text': '!'}
endif
if executable('gopls')
    augroup LspGo
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                 \ 'name': 'go-lang',
                 \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
                 \ 'whitelist': ['go'],
                 \ })
        autocmd FileType go call s:lsp_keybinds()
    augroup END

endif

if executable('pyls')
    augroup LspPy
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                   \ 'name': 'python',
                   \ 'cmd': {server_info->['pyls']},
                   \ 'whitelist': ['python'],
                   \ 'workspace_config': {'pyls': {'plugins': {
                   \ 'pyflakes': {'enabled': v:true},
                   \ 'autopep8': {'enabled': v:true},}}}
                   \ })
        autocmd FileType python call s:lsp_keybinds()
    augroup END
endif

if executable('intelephense')
    augroup LspPHP
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
                    \ 'name': 'php',
                    \ 'cmd': {server_info->['node', expand('~/.nodebrew/current/lib/node_modules/intelephense/lib/intelephense.js'), '--stdio']},
                    \ 'initialization_options': {'storagePath': expand('~/.cache/intelephense/')},
                    \ 'whitelist': ['php'],
                    \ })
        autocmd FileType php call s:lsp_keybinds()
    augroup END
endif

function! s:lsp_keybinds() abort
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gr <Plug>(lsp-references)
    nmap <buffer> gn <Plug>(lsp-next-error)
    nmap <buffer> gp <Plug>(lsp-previous-error)
    nmap <buffer> gh <Plug>(lsp-hover)
endfunction

"############# end vim-lsp #############
