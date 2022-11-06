source ~/.vimrc

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {"help", "vim"},
  },
  indent = {
    enable = true,
  }
}
EOF
