return {
    "lambdalisue/fern.vim",
    dependencies = {
        "lambdalisue/nerdfont.vim",
        "lambdalisue/fern-renderer-nerdfont.vim",
        "lambdalisue/fern-hijack.vim",
        "lambdalisue/fern-git-status.vim",
    },
    init = function ()
        vim.g['fern#renderer'] = 'nerdfont'
        vim.g['fern#default_hidden'] = 1
    end,
}
