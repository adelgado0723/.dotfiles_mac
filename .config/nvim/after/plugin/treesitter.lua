local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 20
vim.opt.foldlevelstart = 20
--[[ vim.opt.foldcolumn = "1" ]]
--[[ vim.opt.foldenable = true ]]
local vim = vim
local api = vim.api
local M = {}
-- function to create a list of commands and convert them to autocommands
-------- This function is taken from https://github.com/norcalli/nvim_utils
function M.nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		api.nvim_command("augroup " .. group_name)
		api.nvim_command("autocmd!")
		for _, def in ipairs(definition) do
			local command = table.concat(vim.tbl_flatten({ "autocmd", def }), " ")
			api.nvim_command(command)
		end
		api.nvim_command("augroup END")
	end
end

local autoCommands = {
	-- other autocommands
	open_folds = {
		{ "BufReadPost,FileReadPost", "*", "normal zR" },
	},
}

M.nvim_create_augroups(autoCommands)


configs.setup({
	ensure_installed = {
		"astro",
		"bash",
		"c",
		"comment",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"gowork",
		"graphql",
		"html",
		"http",
		"java",
		"javascript",
		"jsdoc",
		"json",
		"latex",
		"make",
		"python",
		"regex",
		"rust",
		"svelte",
		"todotxt",
		"tsx",
		"typescript",
		"vim",
		"yaml",
	}, -- one of "all", or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = false, disable = { "yaml" } },
	ts_context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
