set encoding=utf-8
scriptencoding utf-8

"Setting NeoBundle
if 0 | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    "Required
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
endif

if dein#load_state('~/.vim/dein/')
    call dein#begin('~/.vim/dein')
    call dein#load_toml('~/dotfiles/dein.toml', {'lazy':0})
    call dein#load_toml('~/dotfiles/dein-lazy.toml', {'lazy':1})
    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif
"Reqired
filetype plugin indent on
syntax enable

let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_logiPat = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_rrhelper = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1

"setting for showing
set number
set ruler
set laststatus=2
set showmatch
source $VIMRUNTIME/macros/matchit.vim
set helpheight=999
set showcmd
set wildmode=longest,list
set tabstop=4
set expandtab
set shiftwidth=4
set nocp
set autoindent
set smartindent
set smarttab
set breakindent
set autoread
set backspace=indent,eol,start
if has('mac')
    set clipboard=unnamed,autoselect
else
    set clipboard=unnamedplus,autoselect
endif
set fileencoding=utf-8
set fileencodings=utf-8,cp932,euc-jp
set fileformats=unix,dos,mac
set ambiwidth=double
set undodir=~/.vim/undo
set undofile
set t_Co=256
"setting for vim on tmux
set t_ut=
set termguicolors
colorscheme onedark
set cursorline
hi clear CursorLine
"setting for access
set ignorecase
set smartcase
set wrapscan
set completeopt-=preview
let python_highlight_all=1

if has("mouse")
    set mouse=a
endif

inoremap <C-w> <C-o>:<C-u>w<CR>
nnoremap j gj
nnoremap k gk
nnoremap <Up> gk
nnoremap <Down> gj
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
nnoremap <silent> <S-t> :tabnew<CR>

"Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
"------------------functions------------------------
"move to the last edit point
augroup vimrcEx
    autocmd BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g`\"" | endif
augroup END

"do not auto-comment out on line feed
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r formatoptions-=o
augroup END

"auto-close html tags
augroup CompleteTag
    autocmd!
    autocmd FileType html,xml inoremap <buffer> </ </<C-x><C-o>
augroup END

"if the file is edited by  another editor, it will be updated automatically
augroup vimrcchecktime
    autocmd!
    autocmd InsertEnter * checktime
augroup END

"clear blanks on end of the line
function! s:remove_dust()
    let cursor = getpos(".")
    %s/\s\+$//ge
    call setpos(".", cursor)
    unlet cursor
endfunction
autocmd BufWritePre * call <SID>remove_dust()
"---------------end functions------------------------

"--------------neocomplete setting-------------------
"Use neocomplete
let g:neocomplete#enable_at_startup = 1
"Use smartcase
let g:neocomplete#sources#syntax#min_keyword_length = 2

"Define dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
            \'default':'',
            \'python' : $HOME.'./.vim/dict/python.dict'
            \}
"Define keyword
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

"Plugin key-mappings
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

"<CR>: close popup and save indent
"This setting is for neocomplete closing and lexima.vim parentheses completion
call lexima#init()
inoremap <expr> <CR> pumvisible() ? neocomplete#close_popup() : lexima#expand('<LT>CR>', 'i')

"<TAB>: completion
"inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
    let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'
endif

"-----------------neocomplete setting end -----------------

"-------------neosnippet settings----------------------
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
"---------------end neosnippet------------------------

"---------------------unite setting------------------------
"start at insert mode
let g:unite_enable_start_insert=1
"setting prefix key
nmap <Space> [unite]

nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<Space>file<Space>file_mru<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]n :<C-u>Unite<Space>file/new<CR>

"key mapping for unite.vim
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
    "push ESC unite stop
    nmap <buffer> <ESC> <Plug>(unite_exit)
    "open on split
    inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    "open on vsplit
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    "open on new tab
    inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
    "slelect next candidate
    imap <buffer> <Tab> <Plug>(unite_select_next_line)

endfunction
"----------------end unite setting-----------------------

"---------------setting watchdogs------------------------
if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
if executable("golint")
    let g:quickrun_config = {
                \	"go/watchdogs_checker" : {
                \		"type" : "watchdogs_checker/golint",
                \	},
                \}
endif

if executable("clang++")
    let g:quickrun_config = {
                \	"cpp/watchdogs_checker" : {
                \		"type" : "watchdogs_checker/clang++",
                \		"cmdopt" : "-Wall",
                \	},
                \}
endif

let g:quickrun_config = {
            \	"watchdogs_checker/_" :{
            \		"runnner" : "job",
            \		"outputter/quickfix/open_cmd" : "",
            \		"hook/qfstatusline_update/enable_exit" : 1,
            \		"hook/qfstatusline_update/priority_exit" : 4,
            \},
            \}

let g:watchdogs_check_BufWritePost_enable = 1
"let g:watchdogs_check_BufWritePost_enables = {
"			\   "java" : 0,
"			\	"go" : 1,
"			\	"cpp" : 1
"			\}
"let g:watchdogs_check_CursorHold_enable = 1
let g:watchdogs_check_CursorHold_enables = {
            \   "java" : 0,
            \	"cpp" : 0
            \}

let g:watchdogs_check_BufWritePost_enable_on_wq = 0

augroup my_watchdogs
    autocmd!
    autocmd BufWritePost,TextChanged *.c WatchdogsRun
    autocmd BufRead,BufNewFile *.py,*.c WatchdogsRun
augroup END

call watchdogs#setup(g:quickrun_config)
"-----------------end watchdogs--------------------------

"--------------setting light line-----------------------
let g:lightline = {
            \   'colorscheme': 'onedark',
            \   'mode_map' : {
            \		'n' : 'N',
            \		'i'	: 'I',
            \		'R' : 'REPLACE',
            \		'v' : 'V',
            \		'V': 'V-LINE',
            \		"\<C-v>": 'V-BLOCK',
            \		"s" : "S",
            \		"S" : "S-LINE",
            \		"\<C-s>" : "S-BLOCK",
            \		't' : "TERMINAL",
            \		},
            \   'active' : {
            \        'left':[
            \            ['mode','paste'],
            \            ['readonly','fugitive', 'filename','modified', 'anzu'],
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
            \   'anzu' : 'anzu#search_status',
            \   'fugitive' : 'Myfugitive',
            \   'fileformat' : 'Myfileformat',
            \   'fileencoding': 'Myfileencoding',
            \   'filetype' : 'Myfiletype',
            \   },
            \   'component_expand':{
            \   'syntaxcheck' : 'qfstatusline#Update',
            \    },
            \   'component_type':{
            \   'syntaxcheck' : 'error',
            \   },
            \}

let g:Qfstatusline#UpdateCmd = function('lightline#update')
autocmd BufRead,TabEnter * QfstatuslineUpdate

function! Mymode()
    return winwidth(0) > 30 ? lightline#mode() : ''
endfunction

function! Myfugitive()
    return exists('*fugitive#head') ? fugitive#head():''
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

"------------end lightline-----------------

"-----------setting anzu------------------
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
"----------end anuz----------------------

"---------tweetvim setting---------------"
autocmd FileType tweetvim call s:tweetvim_my_setting()
function! s:tweetvim_my_setting()
    nnoremap <buffer>s :<C-u>TweetVimSay<CR>
    nnoremap <silent>t :Unite tweetvim<CR>
    let g:tweetvim_tweet_per_page = 300
endfunction
"------------end tweetvim----------------"
