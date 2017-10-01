set encoding=utf-8
scriptencoding utf-8

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    "Required
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

    "In the noremal mode, a cursor is vertical bar
    let &t_SI .= "\e[6 q"
    "In the insert mode, a cursor is block
    let &t_EI .= "\e[2 q"
    "In the replace mode, a cursor is under bar
    let &t_SR .= "\e[4 q"
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

set number
set ruler
set laststatus=2
set showmatch
set matchtime=1
source $VIMRUNTIME/macros/matchit.vim
set helpheight=999
set wildmode=longest,list
set tabstop=4
set expandtab
set shiftwidth=4
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
if has('termguicolors')
    set termguicolors
    colorscheme onedark
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
let g:python_highlight_all=1

if has('mouse')
    set mouse=a
endif

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap <silent> <S-t> :tabnew<CR>

"Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"nnoremap / /\v
"============= functions =============
"move to the last edit point
augroup record_last_edit
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

"if the file is edited by  another editor, it will be updated automatically
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
"============= end functions =============

"============= neocomplete setting =============
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
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"endif

if !exists('g:neocomplete#text_mode_filetypes')
    let g:neocomplete#text_mode_filetypes = {}
endif
let g:neocomplete#text_mode_filetypes = {'tex' : 1}

"============= neocomplete setting end =============

"============= neosnippet settings =============
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
"============= end neosnippet =============

"============= unite setting =============
"start at insert mode
let g:unite_enable_start_insert=1
"setting prefix key
nmap <Space> [unite]

nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer file file_mru<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
nnoremap <silent> [unite]d :<C-u>Unite directory_mru<CR>
nnoremap <silent> [unite]h :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]n :<C-u>Unite file/new<CR>

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
"============= end unite setting =============

"============= setting quickrun =============
if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
"============= end quickrun =============

"============= setting for ale =============

let g:ale_sign_error = '>'
let g:ale_sign_warning = '!'
let g:ale_lint_on_text_changed = 'never'
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
    autocmd User ALELint call lightline#update()
augroup END
"============= end ale =============

"============= setting lightline =============
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
            \		},
            \   'active' : {
            \        'left':[
            \            ['mode','paste'],
            \            ['readonly','fugitive', 'filename','modified'],
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
            \   'fugitive' : 'Myfugitive',
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

"============= end lightline =============

"============= setting incsearch.vim =============
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
nmap n <Plug>(incsearch-nohl)<Plug>(anzu-n-with-echo)
nmap N <Plug>(incsearch-nohl)<Plug>(anzu-N-with-echo)
"============= end incsearch.vim =============

"============= tweetvim setting =============
autocmd FileType tweetvim call s:tweetvim_my_setting()
function! s:tweetvim_my_setting()
    nnoremap <buffer>s :<C-u>TweetVimSay<CR>
    nnoremap <silent>t :Unite tweetvim<CR>
    let g:tweetvim_tweet_per_page = 300
endfunction
"============= end tweetvim =============

"============= gundo settings =============
let g:gundo_prefer_python3 = 1

"============= end gundo =============

"============= previm settings =============
let g:previm_enable_realtime = 1

"============= end previm =============
