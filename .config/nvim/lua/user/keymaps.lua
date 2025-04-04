local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows -- Handled with iterm
keymap("n", "˚", ":resize +2<CR>", opts)
keymap("n", "∆", ":resize -2<CR>", opts)
keymap("n", "˙", ":vertical resize -2<CR>", opts)
keymap("n", "¬", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Telescope --
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>", opts)
keymap("n", "<leader>tc", "<cmd>Telescope colorscheme<cr>", opts)
keymap("n", "<leader>fa", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", opts)

-- telescope-dap
keymap("n", "<leader>dcc", '<cmd>lua require"telescope".extensions.dap.commands{}<CR>', opts)
keymap("n", "<leader>dco", '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>', opts)
keymap("n", "<leader>dlb", '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>', opts)
keymap("n", "<leader>dv", '<cmd>lua require"telescope".extensions.dap.variables{}<CR>', opts)
keymap("n", "<leader>df", '<cmd>lua require"telescope".extensions.dap.frames{}<CR>', opts)

-- dashboard-nvim
-- keymap("n", "<leader>ss", "<cmd>SessionSave<cr>", opts)
-- keymap("n", "<leader>sl", "<cmd>SessionLoad<cr>", opts)
-- keymap("n", "<leader>cn", "<cmd>DashboardNewFile<cr>", opts)
-- keymap("n", "<leader>db", "<cmd>Dashboard<cr>", opts)

-- eslint
--[[ keymap("n", "<Leader><Leader>f", "<cmd>silent !eslint_d % --fix <CR>", opts) ]]

-- go.nvim
keymap("n", "<Leader><Leader>l", ":GoLint<CR>", opts)
--[[ keymap("n", "<Leader><Leader>f", ":GoImport<CR>:GoFmt<CR>", opts) ]]
--[[ keymap("n", "<Leader><Leader>i", ":GoImport<CR>", opts) ]]
--[[ keymap("n", "<Leader><Leader>d", ":GoDebug<CR>", opts) ]]
keymap("n", "<Leader><Leader>t", ":GoTest<CR>", opts)
keymap("n", "<leader><leader>tu", ":GoTestFunc<CR>", opts)
keymap("n", "<leader><leader>tf", ":GoTestFile<CR>", opts)
--[[ keymap("n", "<F2>", "<cmd>GoRename<CR>", opts) ]]

--[[ Gitsigns ]]
keymap("n", "<leader>l", "<cmd>Gitsigns next_hunk<CR>", opts)
keymap("n", "<leader>h", "<cmd>Gitsigns prev_hunk<CR>", opts)
keymap("n", "<leader>j", "<cmd>Gitsigns preview_hunk_inline<CR>", opts)

-- image preview

-- Debugging dap
keymap("n", "<F5>", '<cmd>lua require"dap".continue()<CR>', opts)
keymap("n", "<F10>", '<cmd>lua require"dap".step_over()<CR>', opts)
keymap("n", "<F9>", '<cmd>lua require"dap".step_into()<CR>', opts)
keymap("n", "<F8>", '<cmd>lua require"dap".step_out()<CR>', opts)
keymap("n", "<leader>b", '<cmd>lua require"dap".toggle_breakpoint()<CR>', opts)
keymap("n", "<leader>B", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: ", opts))<CR>', opts)
keymap(
	"n",
	"<leader>bl",
	'<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: ", opts))<CR>',
	opts
)

keymap("n", "<leader>dr", '<cmd>lua require"dap".repl.open()<CR>', opts)
keymap("n", "<leader>dl", '<cmd>lua require"dap".repl.run_last()<CR>', opts)

keymap("n", "<leader>dsc", '<cmd>lua require"dap.ui.variables".scopes()<CR>', opts)
keymap("n", "<leader>dhh", '<cmd>lua require"dap.ui.variables".hover()<CR>', opts)
keymap("v", "<leader>dvh", '<cmd>lua require"dap.ui.variables".visual_hover()<CR>', opts)

keymap("n", "<leader>duh", '<cmd>lua require"dap.ui.widgets".hover()<CR>', opts)
keymap(
	"n",
	"<leader>duf",
	"<cmd>lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>",
	opts
)

-- quit
keymap("n", "<leader><leader>q", "<cmd>q<CR>", opts)

-- quitall
keymap("n", "<leader>qa", "<cmd>quitall<CR>", opts)

-- delete buffer
keymap("n", "<leader>bd", "<cmd>Bdelete<CR>", opts)

-- close all but window cursor is on
keymap("n", "<leader>on", "<cmd>on<CR>", opts)

-- close all but buffer cursor is on
keymap("n", "<leader>bon", "<cmd>%bd|e#<CR>", opts)

-- write
keymap("n", "<leader><leader>w", "<cmd>w<CR>", opts)

-- nvim-dap-ui -
keymap("n", "<leader>`", "<cmd>lua require('dapui').eval()<CR>", opts)

-- cd to current file dir
keymap("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)

-- source config
keymap("n", "<leader>s", ":so $MYVIMRC<CR>", opts)

-- paste but keep current yank buffer
--[[ keymap("v", "<leader>p", '"_dP', opts) ]]

-- yank into system clipboard
keymap("v", "<leader>y", '"+y', opts)
keymap("n", "<leader>y", '"+y', opts)

-- markdown to email and copy to clipboard
keymap("n", "<leader>oe", ":w !pandoc -t html5 -s | xclip -selection clipboard<CR>", opts)

-- print file
--[[ keymap("n", "<C-p>", "<cmd>TOhtml | ! xdg-open %<CR>", opts) ]]

-- rest.nvim
keymap("n", "<leader>rr", "<Plug>RestNvim<cr>", opts)
keymap("n", "<leader>rp", "<Plug>RestNvimPreview<cr>", opts)
keymap("n", "<leader>rl", "<Plug>RestNvimLast<cr>", opts)

-- copilot
vim.cmd([[imap <silent><script><expr> ∆ copilot#Accept("\<CR>")]])
--[[ keymap("i", "∆", "<Plug>(copilot-accept)<CR>", opts) ]]
keymap("i", "¬", "<Plug>(copilot-next)", opts)
keymap("i", "˙", "<Plug>(copilot-previous)", opts)
keymap("i", "˚", "<Plug>(copilot-dismiss)<CR>", opts)
vim.g.copilot_no_tab_map = true

-- harpoon
keymap("n", "<leader>ha", ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<leader>h<leader>", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
keymap("n", "<leader>ht", ":Telescope harpoon marks<CR>", opts)
keymap("n", "<leader>hh", ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<leader>hj", ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", "<leader>hk", ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap("n", "<leader>hl", ':lua require("harpoon.ui").nav_file(4)<CR>', opts)

-- oil.nvim
keymap("n", "-", ':lua require("oil").open()<CR>', opts)
keymap("n", "<leader>e", ':lua require("oil").open()<CR>', opts)
--[[ keymap("n", "<leader>e", ':lua require("oil").open_float()<CR>', opts) ]]

-- tmux-sessionizer using fzf
keymap("n", "<C-s>", ":silent !tmux neww tmux-sessionizer<cr>", opts)
keymap("n", "<C-a>g", ":silent !tmux neww lazygit<cr>", opts)

-- symbols-outline.nvim
keymap("n", "<leader><leader>b", "<cmd>SymbolsOutline<cr>", opts)

--[[ image preview ]]
keymap(
	"n",
	"<leader><leader>c",
	":!tmux splitw -h /bin/bash -c \"$HOME/.nix-profile/bin/chafa './*/' . expand(\"<cword>\") . '' && read -p'$*'\"",
	opts
)

-- refactoring.nvim
-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader><leader>r",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)

-- jester
-- run test under cursor
keymap("n", "<leader><leader>jj", ':lua require"jester".run()<CR>', opts)
-- run file
keymap("n", "<leader><leader>jf", ':lua require"jester".run_file()<CR>', opts)
-- run last test
keymap("n", "<leader><leader>jl", ':lua require"jester".run_last()<CR>', opts)
-- debug test under cursor
keymap("n", "<leader><leader>jd", ':lua require"jester".debug()<CR>', opts)
