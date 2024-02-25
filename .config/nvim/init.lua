vim.opt.encoding = 'utf-8'

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1

if vim.fn.has('vim_starting') then
    vim.g.mapleader = " "
    vim.opt.runtimepath:append('~/.cache/dein/repos/github.com/Shougo/dein.vim')
end

-- dein loading
local cache_dir = "~/.cache/dein/"
if vim.fn["dein#load_state"](cache_dir)  == 1 then
    vim.fn["dein#begin"](cache_dir)
    vim.fn["dein#load_toml"]("~/.vim/dein.toml", {lazy = 0})
    vim.fn["dein#load_toml"]("~/.vim/dein-lazy.toml", {lazy = 1})
    vim.fn["dein#load_toml"]("~/.vim/dein-nvim.toml", {lazy = 0})
    vim.fn["dein#end"]()
    vim.fn["dein#save_state"]()
end

if vim.fn["dein#check_install"]() == 1 then
    vim.fn["dein#install"]()
end

-- basic settings
vim.opt.number = true
vim.opt.ruler = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.helpheight = 99
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.autoread = true
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"

vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,cp932,euc-jp"
vim.opt.fileformats = "unix,dos,mac"
vim.opt.ambiwidth = "single"
vim.opt.foldlevelstart = 99
vim.opt.undofile = true
--vim.opt.t_Co = 256
vim.opt.updatetime = 500
--vim.opt.t_ut = nil
vim.opt.background = "dark"
vim.opt.termguicolors = true
-- vim.cmd('colorscheme iceberg')
vim.cmd.colorscheme "nightfox"
vim.opt.undodir = os.getenv("HOME") .. "/.cache/undo/nvim"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.completeopt = {"menu"}
vim.opt.pumheight = 10
vim.opt.emoji = true
vim.opt.list = true
vim.opt.listchars = { tab = "^-", space = "_" }
vim.opt.signcolumn = "yes"
vim.opt.mouse = "n"
vim.opt.inccommand = "split"
vim.opt.showcmd = false
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- keymaps
vim.keymap.set({'n', 'v'}, ':', ';', {noremap = true})
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>', {})

vim.keymap.set({'n', 'v'}, 'j', 'gj', {noremap = true})
vim.keymap.set({'n', 'v'}, 'k', 'gk', {noremap = true})
vim.keymap.set({'n', 'v'}, 'gj', 'j', {noremap = true})
vim.keymap.set({'n', 'v'}, 'gk', 'k', {noremap = true})

-- autocmd
vim.api.nvim_create_autocmd({"BufRead"}, {
    group = vim.api.nvim_create_augroup('record_last_position', { clear = true }),
    pattern = {"*"},
    callback = function()
        vim.cmd([[
            if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
        ]])
    end,
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
    group = vim.api.nvim_create_augroup('auto_comment_off', { clear = true }),
    pattern = {"*"},
    callback = function()
        vim.cmd('set formatoptions-=ro')
    end,
})

vim.api.nvim_create_autocmd({"FileType"}, {
    group = vim.api.nvim_create_augroup('complete_tag', { clear = true }),
    pattern = {"*.html", "*.xml"},
    callback = function()
        vim.keymap.set({'i'}, '</', '</<C-x><C-o>', {buffer = true})
    end,
})

vim.api.nvim_create_autocmd({"InsertEnter"}, {
    group = vim.api.nvim_create_augroup('auto_file_update_check', { clear = true }),
    pattern = {"*"},
    callback = function()
        vim.cmd("checktime")
    end,
})
-- functions
function remove_dust()
    if vim.bo.filetype ~= 'markdown' then
        local cursor = vim.fn.getpos(".")
        vim.cmd('%s/\\s\\+$//ge')
        vim.fn.setpos(".", cursor)
    end
end

--function disable_ime_on_mintty()
--    local tty = '/dev/' .. vim.fn.system('ps -o tty= $(ps -o ppid= $(ps -o ppid= $$))')
--    local command = 'execute \"!printf \'\\e'
--
--    if vim.env.$TERM_PROGRAM == 'tmux' then
--        vim.cmd(command .. 'Ptmux;\\e\\e[<0t\\e\\\\\' > \"' .. '/dev/pts/2')
--    end
--end

-- denite settings
-- local denite_keymap_option = { noremap = true, silent = true }
-- vim.keymap.set('n', '<leader>b', ':<C-u>Denite buffer file file_mru<CR>', denite_keymap_option)
-- vim.keymap.set('n', '<leader>f', ':<C-u>DeniteBufferDir -buffer-name=files file<CR>', denite_keymap_option)
-- vim.keymap.set('n', '<leader>o', ':<C-u>Denite outline<CR>', denite_keymap_option)
-- vim.keymap.set('n', '<leader>g', ':<C-u>Denite grep<CR>', denite_keymap_option)
-- 
-- local denite_do_map_option = { noremap = true, silent = true, expr = true }
-- vim.api.nvim_create_autocmd({"FileType"}, {
--     group = vim.api.nvim_create_augroup('denite_settings', { clear = true }),
--     pattern = {"denite"},
--     callback = function()
--         vim.keymap.set('n', '<CR>', vim.fn['denite#do_map']('do_action'), denite_do_map_option)
--         vim.keymap.set('n', 'a', vim.fn['denite#do_map']('choose_action'), denite_do_map_option)
--         vim.keymap.set('n', 'p', vim.fn['denite#do_map']('do_action', 'choose_action'), denite_do_map_option)
--         vim.keymap.set('n', 'q', vim.fn['denite#do_map']('quit'), denite_do_map_option)
--         vim.keymap.set('n', 'i', vim.fn['denite#do_map']('open_filter_buffer'), denite_do_map_option)
--     end,
-- })
-- end denite

--lightline settings
vim.g.lightline = {colorscheme = 'nightfox',
    mode_map = {
        n = 'N',
        i = 'I',
        R = 'RREPLACE',
        v = 'V',
        V = 'V-LINE',
        ["<C-v>"] = 'V-BLOCK',
        s = "S",
        S = "S-LINE",
        ["<C-s>"] = 'S-BLOCK'
    },
    active = {
        left = {
            {'mode', 'paste'}, {'readonly', 'filename', 'modified'}
        },
        right = {
            {'lineinfo', 'syntaxcheck'}, {'percent'}, {'charcode', 'fileformat', 'fileencoding', 'filetype'}
        }
    },
    component_function = {
        mode = 'Mymode',
        gitbranch = 'gitbranch#name',
        fileformat = 'Myfileformat',
        fileencoding = 'Myfileencoding',
        filetype = 'Myfiletype',
    },
    -- WIP. lsp diagnostics status
}

vim.cmd([[
function! Mymode()
    return winwidth(0) > 30 ? lightline#mode() : ''
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
]])
-- end lightline

-- vim-startify settings
vim.g.startify_lists = {
    { type = 'dir', header = { '   MRU' .. vim.fn.getcwd() } },
    { type = 'files', header = {'   MRU'} },
    { type = 'sessions', header = {'   Sessions'} },
    { type = 'commands', header = {'   Commands'} },
}
vim.g.startify_commands = {
    { 'Plugins Update', 'call dein#update()' },
    { 'Plugins Recache', 'call dein#recache_runtimepath()' }
}
vim.g.startify_change_to_dir = 0
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_custom_header = {
[[                               ]],
[[            __                 ]],
[[    __  __ /\_\    ___ ___     ]],
[[   /\ \/\ \\/\ \ /'' __` __`\  ]],
[[   \ \ \_/ |\ \ \/\ \/\ \/\ \  ]],
[[    \ \___/  \ \_\ \_\ \_\ \_\ ]],
[[     \/__/    \/_/\/_/\/_/\/_/ ]],
}
-- end vim-startify

-- gitgutter settings
vim.g.gitgutter_preview_win_floating = 1
-- end gitgutter

-- git-messenger settings
vim.keymap.set({'n'}, '<Leader>gm', '<Plug>(git-messenger)')
-- end git-messenger

-- vim-matchup settings
vim.g.matchup_matchparen_offscreen = { method = 'popup', scrolloff = 1 }
vim.g.matchup_matchparen_deferred = 1
vim.g.matchup_matchparen_deferred_show_delay = 200
-- end vim-matchup

-- fern.vim settings
vim.g['fern#renderer'] = 'nerdfont'
vim.g['fern#default_hidden'] = 1

local function init_fern()
    vim.wo.number = false
    vim.wo.cursorline = true
    vim.wo.winfixwidth = true

    vim.keymap.set('n',
        '<Plug>(fern-my-expand-or-enter)',
        function()
            return vim.fn['fern#smart#drawer']('<Plug>(fern-action-open-or-expand)', '<Plug>(fern-action-open-or-enter)')
        end,
        { buffer = true, expr = true })
    vim.keymap.set('n',
        '<Plug>(fern-my-expand-or-collapse)',
        function()
            return vim.fn['fern#smart#leaf']('<Plug>(fern-action-collapse)', '<Plug>(fern-action-expand)', '<Plug>(fern-action-collapse)')
        end,
        { buffer = true, expr = true })

    local fern_keymap_options = { silent = true, buffer = true }
    vim.keymap.set('n', 'd', '<Plug>(fern-action-enter)', fern_keymap_options)
    vim.keymap.set('n', 'D', '<Plug>(fern-action-new-dir)', fern_keymap_options)
    vim.keymap.set('n', 'u', '<Plug>(fern-action-leave)', fern_keymap_options)
    vim.keymap.set('n', '<CR>', '<Plug>(fern-my-expand-or-enter)', fern_keymap_options)
    vim.keymap.set('n', 'o', '<Plug>(fern-my-expand-or-collapse)', fern_keymap_options)
end

if vim.fn['dein#tap']('fern.vim') == 1 then
    vim.keymap.set('n', '<leader>d', ':Fern -drawer -toggle . <CR>', { silent = true })
    vim.api.nvim_create_autocmd({"FileType"}, {
        group = vim.api.nvim_create_augroup('my-fern', { clear = true }),
        pattern = {"fern"},
        callback = function()
            return init_fern()
        end,
    })
end
-- end fern.vim

-- nvim-treesitter
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = {"help", "vim"},
    },
    indent = {
        enable = true,
    }
}
-- end nvim-treesitter

-- mason.nvim
require("mason").setup()
require("mason-lspconfig").setup()
-- end mason.nvim

-- nvim-lsp
local lspconfig = require("lspconfig")
local capabilities = require("ddc_source_lsp").make_client_capabilities()
lspconfig.gopls.setup {
    capabilities = capabilities,
}
lspconfig.lua_ls.setup({
    on_init = function (client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
            client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                Lua = {
                    runtime = {
                        version = 'LuaJIT'
                    },
                    workspace = {
                        checkThirdParty = false,
                        library = vim.api.nvim_get_runtime_file("lua", true)
                    },
                    diagnostics = {
                        globals = { 'vim' }
                    }
                }
            })
            client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
    end
})


vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    end
})

-- gitsigns
require('gitsigns').setup()

-- fidget.nvim
require('fidget').setup {}
