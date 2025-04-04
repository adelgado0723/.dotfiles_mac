--
local api = vim.api
--vim.go
-- Run gofmt + goimport on save
-- api.nvim_exec([[ autocmd BufWritePre *.go :silent! GoFmt ]], false)
--
-- api.nvim_exec([[
-- augroup GoCommentMappingGroup
-- autocmd FileType go nmap <Leader>gc :lua require('go.comment').gen() <CR>
-- augroup END
-- ]], false)

-- use eslint for formatting these
-- api.nvim_exec([[
-- augroup EslintFormatFile
-- autocmd FileType tsx nmap <Leader><Leader>f :EslintFixAll<CR>
-- augroup END
-- ]], false)
--
--
-- api.nvim_exec([[
-- augrou EslintFormatFile
-- autocmd FileType ts nmap <Leader><Leader>f :EslintFixAll<CR>
-- augroup END
-- ]], false)
--
-- api.nvim_exec([[
-- augrou EslintFormatFile
-- autocmd FileType js nmap <Leader><Leader>f :EslintFixAll<CR>
-- augroup END
-- ]], false)

-- Eslint
-- api.nvim_command('autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>')

-- set spell check on in Markdown files
api.nvim_create_augroup("setSpellOnMD", { clear = true })
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = "setSpellOnMD",
	pattern = { "*.txt", "*.md", "*.tex", "*.markdown" },
	command = "setlocal spell",
})

-- go to last loc when opening a buffer
local lastLocationGroup = api.nvim_create_augroup("LastLocation", { clear = true })
api.nvim_create_autocmd("BufReadPost", {
	command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
	group = lastLocationGroup,
})

-- Highlight on yank
local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
api.nvim_create_autocmd("TextYankPost", {
	command = "silent! lua vim.highlight.on_yank()",
	group = yankGrp,
})

-- Use internal formatting for bindings like gq.
local lspGQFormatGrp = api.nvim_create_augroup("LspGQFormat", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.bo[args.buf].formatexpr = nil
	end,
	group = lspGQFormatGrp,
})

-- netrw key bindings
--[[ function NetrwBindigns() ]]
--[[ 	print("Hello from NetrwBindigns") ]]
--[[   vim.api.nvim_set_keymap("n", "<TAB>", "mf", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "<S-TAB>", "mF", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "<leader><TAB>", "mu", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "ff", "%:w<CR>:buffer #<CR>", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "fe", "R", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "fc", "mc", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "fC", "mtmc", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "fx", "mm", { noremap = true, silent = true }) ]]
--[[   vim.api.nvim_set_keymap("n", "fX", "mtmm", { noremap = true, silent = true }) ]]
--[[ end ]]
--[[]]
--[[ local netrwBindingsGrp = api.nvim_create_augroup("NetrwBindigns", { clear = true }) ]]
--[[ api.nvim_create_autocmd("FileType netrw", { ]]
--[[ 	callback = function() NetrwBindigns() end, ]]
--[[ 	group = netrwBindingsGrp, ]]
--[[ }) ]]
--[[]]
