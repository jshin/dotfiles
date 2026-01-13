return {
    "andymass/vim-matchup",
    init = function ()
        vim.g.matchup_matchparen_offscreen = { method = 'popup', scrolloff = 1 }
        vim.g.matchup_matchparen_deferred = 1
        vim.g.matchup_matchparen_deferred_show_delay = 200
    end
}
