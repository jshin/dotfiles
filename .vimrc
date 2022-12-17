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
    let mapleader = "\<Space>"
    set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

    if !has('nvim')
        "In the insert mode, a cursor is vertical bar
        let &t_SI .= "\e[6 q"
        "In the normal mode, a cursor is block
        let &t_EI .= "\e[2 q"
        "In the replace mode, a cursor is under bar
        let &t_SR .= "\e[4 q"
    endif
endif

if dein#load_state('~/.cache/dein/')
    call dein#begin('~/.cache/dein/')
    call dein#load_toml('~/.vim/dein.toml', {'lazy':0})
    call dein#load_toml('~/.vim/dein-lazy.toml', {'lazy':1})
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

let g:dein#install_progress_type = 'floating'

filetype plugin indent on
syntax enable

set number
set ruler
set laststatus=2
set showtabline=2
set showmatch
set matchtime=1
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
elseif has('linux') && !has('nvim')
    set clipboard=unnamedplus,autoselect
else
    set clipboard+=unnamedplus
endif

set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set ambiwidth=single
set foldlevelstart=99
set undofile
set t_Co=256
set updatetime=500
"setting for vim on tmux
set t_ut=
set background=dark
if has('termguicolors')
    set termguicolors
    colorscheme iceberg
else
    colorscheme hybrid
endif

if has('nvim')
    set undodir=~/.cache/undo/nvim
else
    set undodir=~/.cache/undo/vim
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

noremap : ;

nmap s <Nop>
xmap s <Nop>

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k

"Switching windows
" noremap <C-j> <C-w>j
" noremap <C-k> <C-w>k
" noremap <C-l> <C-w>l
" noremap <C-h> <C-w>h

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

" for WSL2
if system('uname -a | grep microsoft') != ''
    augroup myYank
        autocmd!
        autocmd TextYankPost * :call system('clip.exe', @")
    augroup END

    augroup disable_ime
        autocmd!
        autocmd InsertLeave * call s:disable_ime_on_mintty()
    augroup END
endif

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

function! s:disable_ime_on_mintty() abort
    let l:tty = '/dev/'.system('ps -o tty= $(ps -o ppid= $(ps -o ppid= $$))')
    if $TERM_PROGRAM == 'tmux'
        silent execute "!printf '\ePtmux;\e\e[<0t\e\\' > " l:tty
    else
        silent execute "!printf '\e[<0t' > " l:tty
    endif
endfunction

"############# end functions #############

"############# ddu setting #############

nnoremap <silent> <Leader>b :<C-u>Ddu file file_old<CR>
nnoremap <silent> <Leader>r :<C-u>Ddu file_rec<CR>
nnoremap <silent> <Leader>g :<C-u>Ddu -name=search rg -source-param-input=`input('Pattern: ')`<CR>
nnoremap <silent> <Leader>l :<C-u>Ddu line -ui-param-startFilter<CR>

autocmd FileType ddu-ff call s:ddu_settings()
autocmd FileType ddu-ff-filter call s:ddu_ff_settings()
function! s:ddu_settings() abort
    nnoremap <buffer><silent> <CR>
                \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
    nnoremap <buffer><silent> i
                \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
    nnoremap <buffer><silent> a
                \ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
    nnoremap <buffer><silent> p
                \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
    nnoremap <buffer><silent> q
               \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

function! s:ddu_ff_settings() abort
    inoremap <buffer><silent> <CR>
        \ <Esc><Cmd>close<CR>
    nnoremap <buffer><silent> <CR>
        \ <Cmd>close<CR>
    nnoremap <buffer><silent> q
        \ <Cmd>close<CR>
endfunction

"############# denite setting #############

" nnoremap <silent> <Leader>b :<C-u>Denite buffer file file_mru<CR>
" nnoremap <silent> <Leader>f :<C-u>DeniteBufferDir -buffer-name=files file<CR>
" nnoremap <silent> <Leader>c :<C-u>Denite command_history<CR>
" nnoremap <silent> <Leader>j :<C-u>Denite jump<CR>
" nnoremap <silent> <Leader>o :<C-u>Denite outline<CR>
" nnoremap <silent> <Leader>r :<C-u>Denite file/rec<CR>
" nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>
"
" autocmd FileType denite call s:denite_settings()
" function! s:denite_settings() abort
"     nnoremap <silent><buffer><expr> <CR>
"                \ denite#do_map('do_action')
"     nnoremap <silent><buffer><expr> a
"                \ denite#do_map('choose_action')
"     nnoremap <silent><buffer><expr> p
"                \ denite#do_map('do_action', 'preview')
"     nnoremap <silent><buffer><expr> q
"                \ denite#do_map('quit')
"     nnoremap <silent><buffer><expr> i
"                \ denite#do_map('open_filter_buffer')
"     nnoremap <silent><buffer><expr> <Space>
"                \ denite#do_map('toggle_select').'j'
" endfunction

"############# setting quickrun #############
if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
"############# end quickrun #############

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
            \   'gitbranch' : 'gitbranch#name',
            \   'fileformat' : 'Myfileformat',
            \   'fileencoding': 'Myfileencoding',
            \   'filetype' : 'Myfiletype',
            \   },
            \   'component_expand':{
            \   'syntaxcheck' : 'Lsp_diagnostics_status',
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
set hlsearch
if !has('nvim')
    map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
    map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
endif
"############# end is.vim #############

"############# setting traces.vim #############
let g:traces_preview_window = "vertical botright new"
"############# end traces.vim #############

"############# previm settings #############
let g:previm_enable_realtime = 1

"############# end previm #############

"############# vim-startify settings #############
let g:startify_lists = [
            \ { 'type': 'dir', 'header': ['   MRU '. getcwd()] },
            \ { 'type': 'files', 'header': ['   MRU'] },
            \ { 'type': 'sessions', 'header': ['   Sessions'] },
            \ { 'type': 'commands', 'header': ['   Commands'] },
            \ ]
let g:startify_commands = [
    \ ['Plugins Update', 'call dein#update()'],
    \ ['Plugins Recache', 'call dein#recache_runtimepath()'],
    \]
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1
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

"############# gitgutter settings #############
let g:gitgutter_preview_win_floating = 1
"############# end gitgutter #############

"############# git-messenger settings #############
if !has('nvim')
    let g:git_messenger_close_on_cursor_moved = v:false
endif
nmap <Leader>gm <Plug>(git-messenger)
"############# end git-messenger #############

"############# vim-matchup settings #############
let g:matchup_matchparen_offscreen = {'method': 'popup', 'scrolloff': 1}
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200
"############# end vim-matchup #############

"############# fern.vim settings #############
let g:fern#renderer = 'nerdfont'
let g:fern#default_hidden = 1

function! s:init_fern() abort
    setlocal nonumber
    setlocal cursorline
    setlocal winfixwidth
    nmap <buffer><expr>
        \ <Plug>(fern-my-expand-or-enter)
        \ fern#smart#drawer(
        \   "\<Plug>(fern-action-open-or-expand)",
        \   "\<Plug>(fern-action-open-or-enter)"
        \ )
    nmap <buffer><expr>
        \ <Plug>(fern-my-expand-or-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-collapse)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)"
        \ )
    nmap <silent><buffer> d <Plug>(fern-action-enter)
    nmap <silent><buffer> D <Plug>(fern-action-new-dir)
    nmap <silent><buffer> u <Plug>(fern-action-leave)
    nmap <silent><buffer> <CR> <Plug>(fern-my-expand-or-enter)
    nmap <silent><buffer> o <Plug>(fern-my-expand-or-collapse)
endfunction

if dein#tap('fern.vim')
    nnoremap <silent><leader>d :Fern -drawer -toggle . <CR>
    augroup my-fern
        autocmd! *
        autocmd FileType fern call s:init_fern()
    augroup END
endif
"############# end fern.vim #############

"############# vim-lsp settings #############
let g:lsp_diagnostics_enabled = 1
let g:lsp_settings_enable_suggestions = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_document_highlight_enabled = 0
let g:lsp_diagnostics_float_delay = 1000
let g:lsp_signature_help_enabled = 0
if has('nvim')
    let g:lsp_highlights_enabled = 0
    let g:lsp_virtual_text_enabled=0
else
    let g:lsp_textprop_enabled = 0
endif
let g:lsp_signs_error={'text': '✘'}
let g:lsp_signs_warning={'text': '!'}

function! Lsp_diagnostics_status() abort
    let l:counts = lsp#get_buffer_diagnostics_counts()

    return count(counts, 0) == 4 ? '' : printf(
                \ '%dW %dE',
                \ counts['warning'],
                \ counts['error']
                \ )
endfunction

augroup LightlineOnLSP
    autocmd!
    autocmd  User lsp_diagnostics_updated call lightline#update()
augroup END

let g:lsp_settings = {
            \ 'gopls': {
            \   'initialization_options': {'usePlaceholders': v:true},
            \ },
            \ 'pyls': {
            \   'workspace_config': {
            \       'pyls': {'plugins': {
            \       'pyflakes': {'enabled': v:true},
            \       'black': {'enabled': v:true},}}}
            \ },
            \ 'yaml-language-server': {
            \   'allowlist': ['yaml', 'yaml.docker-compose'],
            \   'workspace_config': {
            \       'yaml': {
            \           'validate': v:true,
            \           'hover': v:true,
            \           'completion': v:true,
            \           'schmes': {'https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json': '/docker-compose.*',},
            \           'schemeStore': {'enable': v:true},
            \       }
            \   }
            \ },
            \ 'intelephense': {
            \   'initialization_options': {'storagePath': expand('~/.cache/intelephense/')},
            \   'workspace_config': {'intelephense': {
            \       'files': {'associations': ['*.php', '*.phtml']},
            \       'completion': {'insertUserDeclaration': v:true,
            \       'fullyQualifyGlobalConstantsAndFunctions': v:false},
            \       'diagnostics': {'deprecated': v:false},
            \           'stubs': [
            \           'apache',
            \           'bcmath',
            \           'bz2',
            \           'calender',
            \           'com_dotnet',
            \           'Core',
            \           'ctype',
            \           'curl',
            \           'date',
            \           'dba',
            \           'dom',
            \           'enchant',
            \           'exif',
            \           'fileinfo',
            \           'filter',
            \           'fpm',
            \           'ftp',
            \           'gd',
            \           'hash',
            \           'iconv',
            \           'imap',
            \           'interbase',
            \           'intl',
            \           'json',
            \           'ldap',
            \           'libxml',
            \           'mbstring',
            \           'mcrypt',
            \           'meta',
            \           'mssql',
            \           'mysql',
            \           'oci8',
            \           'odbc',
            \           'openssl',
            \           'pcntl',
            \           'pcre',
            \           'PDO',
            \           'pdo_ibm',
            \           'pdo_mysql',
            \           'pdo_pgsql',
            \           'pdo_sqlite',
            \           'pgsql',
            \           'Phar',
            \           'posix',
            \           'pspell',
            \           'readline',
            \           'recode',
            \           'Reflection',
            \           'regex',
            \           'session',
            \           'session',
            \           'shmop',
            \           'SimpleXML',
            \           'snmp',
            \           'soap',
            \           'sockets',
            \           'sodium',
            \           'SPL',
            \           'sqlite3',
            \           'standard',
            \           'superglobals',
            \           'sybase',
            \           'sysvmsg',
            \           'sysvsem',
            \           'sysvshm',
            \           'tidy',
            \           'tokenizer',
            \           'wddx',
            \           'xml',
            \           'xmlreader',
            \           'xmlrpc',
            \           'xmlwriter',
            \           'Zend OPcache',
            \           'zip',
            \           'zlib']
            \ }}
            \ }
            \}

augroup MyLSP
    autocmd FileType dockerfile call s:lsp_keybinds()
    autocmd FileType go call s:lsp_keybinds()
    autocmd FileType php call s:lsp_keybinds()
    autocmd FileType python call s:lsp_keybinds()
    autocmd FileType sh call s:lsp_keybinds()
    autocmd FileType yaml call s:lsp_keybinds()
    autocmd FileType c call s:lsp_keybinds()
    autocmd FileType cpp call s:lsp_keybinds()
    autocmd FileType typescript call s:lsp_keybinds()
augroup END

function! s:lsp_keybinds() abort
    nmap <buffer> gd <Plug>(lsp-definition)
    nmap <buffer> gr <Plug>(lsp-references)
    nmap <buffer> gne <Plug>(lsp-next-error)
    nmap <buffer> gpe <Plug>(lsp-previous-error)
    nmap <buffer> gnr <Plug>(lsp-next-reference)
    nmap <buffer> gpr <Plug>(lsp-previous-reference)
    nmap <buffer> gh <Plug>(lsp-hover)
endfunction

"############# end vim-lsp #############
