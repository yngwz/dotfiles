if vim.g.vscode then
    package.path = "/Users/tim/dotfiles/nvim/vscode/?.lua;" .. package.path
    require 'settings'
    require 'keymaps'
end
