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

let mapleader = "\<Space>"

noremap ; :
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

nnoremap <silent> <Leader>b :<C-u>Denite buffer file file_mru<CR>
nnoremap <silent> <Leader>f :<C-u>DeniteBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>c :<C-u>Denite command_history<CR>
nnoremap <silent> <Leader>j :<C-u>Denite jump<CR>
nnoremap <silent> <Leader>o :<C-u>Denite outline<CR>
nnoremap <silent> <Leader>r :<C-u>Denite file/rec<CR>
nnoremap <silent> <Leader>g :<C-u>Denite grep<CR>

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
map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)
map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)
"############# end is.vim #############
let g:traces_preview_window = "vertical botright new"

"############# tweetvim setting #############
autocmd FileType tweetvim call s:tweetvim_my_setting()
function! s:tweetvim_my_setting()
    nnoremap <buffer>s :<C-u>TweetVimSay<CR>
    nnoremap <silent>t :Unite tweetvim<CR>
    let g:tweetvim_tweet_per_page = 300
endfunction
"############# end tweetvim #############

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

"############# vim-matchup settings #############
let g:matchup_matchparen_offscreen = {'method': 'popup', 'scrolloff': 1}
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 100
"############# end vim-matchup #############

"############# defx.nvim settings #############
function! s:defx_settings() abort
    setlocal nonumber
    setlocal winfixwidth
    setlocal cursorline
    setlocal signcolumn=auto
    nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_tree') : defx#do_action('drop')
    nnoremap <silent><buffer><expr> o defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> O defx#do_action('open_tree', 'recursive')
    nnoremap <silent><buffer><expr> P defx#do_action('preview')
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
                \ -vertical-preview -preview-height=50 -preview-width=70 -floating-preview
                \ -show-ignored-files -resume <CR>

    autocmd FileType defx call s:defx_settings()
endif
"############# end defx.nvim #############

"############# vim-lsp settings #############
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_highlight_references_delay = 2000
let g:lsp_async_completion = 1
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
            \ 'bash-language-server': {
            \   'disabled': 1,
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

augroup LspPHP
    autocmd FileType dockerfile call s:lsp_keybinds()
    autocmd FileType go call s:lsp_keybinds()
    autocmd FileType php call s:lsp_keybinds()
    autocmd FileType python call s:lsp_keybinds()
    autocmd FileType sh call s:lsp_keybinds()
    autocmd FileType yaml call s:lsp_keybinds()
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
