return {
    { "itchyny/lightline.vim",
        lazy = false,
        dependencies = {
            "EdenEast/nightfox.nvim",
            "cocopon/iceberg.vim",
            "itchyny/vim-gitbranch",
        },
        init = function ()
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
                        {'mode', 'paste'}, {'readonly', 'gitbranch', 'filename', 'modified'}
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
        end,
    },
}
