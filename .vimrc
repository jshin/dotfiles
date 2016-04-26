"Setting NeoBundle
if 0 | endif

if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    "Required
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

"Required
call neobundle#begin(expand('~/vim/bundle/'))

"Let NeoBundle mangaze NeoBundle
"Required
NeoBundleFetch 'Shougo/neobundle.vim'
"ここに追加するプラグインについて書く
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite-outline'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Shougo/vimshell.vim'

"Tweetvim
NeoBundle 'mattn/webapi-vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/TweetVim'

if has('mac')
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neco-syntax'
    NeoBundle 'Shougo/neoinclude.vim'
    NeoBundle 'Shougo/neco-vim'
endif

"if !has('mac')
"    NeoBundle 'Shougo/neocomplcache.vim'
"endif

NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'cohama/vim-hier'
NeoBundle 'KazuakiM/vim-qfstatusline'
NeoBundle 'kamichidu/vim-javaclasspath'

call neobundle#end()

"Reqired
filetype plugin indent on

"表示設定
set number
set ruler
set laststatus=2
set showmatch
set helpheight=999
set showcmd
set wildmode=longest,list
set tabstop=4
set expandtab
set shiftwidth=4
set nocp
set smartindent "オートインデン
set backspace=indent,eol,start
set clipboard=unnamed,autoselect
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,sjis,utf-8
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap ' ''<LEFT>
inoremap { {}<LEFT>
inoremap {<Enter> {}<LEFT><CR><ESC><S-o>
set t_Co=256
set background=dark
colorscheme hybrid
set cursorline
hi clear CursorLine
syntax enable
"検索設定
set ignorecase
set smartcase
set wrapscan
"source /Users/takuro/.vim/colorID.vim

"マウス設定
if has("mouse")
    set mouse=a
endif

"最後の編集箇所に移動
augroup vimrcEx
    au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g`\"" | endif
augroup END

"改行時に自動コメントアウトしない
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

inoremap <Space>w   <C-o>:<C-u>w<CR>

"--------------neocomplete setting--------------------
"Disable AutoComplPop
let g:acp_enableAtStartup = 0
"Use neocomplete
let g:neocomplete#enable_at_startup = 1
"Use smartcase
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

"<TAB>: completion
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
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
endif
"-----------------neocomplete setting end ----------------{}

"---------------------unite setting------------------------
"start at insert mode 
let g:unite_enable_start_insert=1
"setting prefix key
nmap <Space> [unite]

nnoremap <silent> [unite]b :<C-u>Unite<Space>file<Space>buffer<Space>file_mru<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>

"uniteを使っている間のキーマップ
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings() "{{{
    "push ESC unite stop
    nmap <buffer> <ESC> <Plug>(unite_exit)
    "縦に分割して開く
    inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')     
    "横に分割して開く
    inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')   

endfunction
"----------------end unite setting-----------------------

"---------------setting watchdogs------------------------
if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif
let g:quickrun_config = {
            \ "watchdogs_checker/_" :{
            \       "runner/vimproc/updatetime": 10,
            \},
            \}
let g:quickrun_config['java/watchdogs_checker'] = {'type': 'watchdogs_checker/javac'}
let g:quickrun_config['watchdogs_checker/javac'] = {
            \   'command': '$JAVA_HOME/bin/javac',
            \   'cmdopt' : join([
            \       '-Xlint:all',
            \       '-sourcepath "%{javaclasspath#source_path()}"',
            \       '-classpath "%{javaclasspath#classpath()}"',
            \       '-deprecation',
            \]),
            \   'exec': '%c %o %s:p',
            \   'errorformat': '%A%f:%l:\ %m,%-Z%p^,%+C%.%#,%-G%.%#',
            \}
let g:quickrun_config["watchdogs_checker/_"] = {
            \       "outputter/quickfix/open_cmd" : "",
            \       "hook/qfstatusline_update/enable_exit" : 1,
            \       "hook/qfstatusline_update/priority_exit" : 4,
            \}

let g:watchdogs_check_BufWritePost_enable = 1
let g:watchdogs_check_BufWritePost_enables = {
            \   "java" : 0
            \}
let g:watchdogs_check_CursorHold_enable = 1
let g:watchdogs_check_CursorHold_enables = {
            \   "java" : 0
            \}
let g:Qfstatusline#UpdateCmd = function('lightline#update')

augroup my_watchdogs
    autocmd!
    autocmd InsertLeave,BufWritePost,TextChanged *.py,*.c,*.cpp WatchdogsRun
    autocmd BufRead,BufNewFile *.py,*.c,*.cpp WatchdogsRun
augroup END

call watchdogs#setup(g:quickrun_config)
"-----------------end watchdogs--------------------------
"--------------setting light line-----------------------
let g:lightline = {
            \   'colorscheme': 'landscape',
            \   'mode_map' : {'c':'NORMAL'},
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

function! Mymode()
    return winwidth(0) > 60 ? lightline#mode() : ''
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
autocmd FileType tweetvim nnoremap <buffer>s :<C-u>TweetVimSay<CR>
