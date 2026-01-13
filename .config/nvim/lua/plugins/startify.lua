return {
    "mhinz/vim-startify",
    init = function ()
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
    end,
}
