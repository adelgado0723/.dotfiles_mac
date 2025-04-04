require("user.lazy")
-- Most (all?) of these depend on plugins
require("user.env")
require("user.keymaps")
require("user.autocmds")
require("user.options")

if vim.g.vscode then
    vim.cmd [[source $HOME/.config/nvim/vscode/settings.vim]]
end
