local lsp = require("lsp-zero").preset({})

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip.loaders.from_vscode").lazy_load()

-- Fix Undefined global 'vim'
lsp.configure("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})


local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}

-- find more here: https://www.nerdfonts.com/cheat-sheet
lsp.preset("recommended")

require("mason").setup({})
require("mason-lspconfig").setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	ensure_installed = {
		"ansiblels",
		"astro",
		"bashls",
		"clangd",
		"dockerls",
		"docker_compose_language_service",
		"emmet_ls",
		"eslint",
		"golangci_lint_ls",
		"gopls",
		"html",
		"jsonls",
		"lua_ls",
		"prismals",
		"pyright",
		"rust_analyzer",
		"spectral",
		"svelte", -- requires per-project installation and configuration of typescript-svelte-plugin
		"sqlls",
		"tailwindcss",
		"tsserver",
	},
	handlers = {
		lsp.default_setup,
	},
})

lsp.configure("emmet_ls", {
	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "eruby", "svelte" },
})

lsp.configure("bashls", {
	filetypes = { "sh", "zsh" },
})

lsp.configure("spectral", {
	filetypes = { "yaml", "yml" },
	settings = {
		enable = true,
		run = "onType",
		validateLanguages = { "yaml", "yml" },
		rulesetfile = "$HOME/.config/spectral/.spectral.yaml",
	},
})

-- fix all on save
--[[ lsp.configur("eslint", { ]]
--[[ 	on_attach = function(_, bufnr) ]]
--[[ 		vim.api.nvim_create_autocmd("BufWritePre", { ]]
--[[ 			buffer = bufnr, ]]
--[[ 			command = "EslintFixAll", ]]
--[[ 		}) ]]
--[[ 	end, ]]
--[[ }) ]]

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }), -- scroll suggestions
	["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }), -- scroll suggestions
	["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- pulls up all completions ** Not working on mac
	["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
	["<C-e>"] = cmp.mapping({ -- Close suggestions
		i = cmp.mapping.abort(),
		c = cmp.mapping.close(),
	}),
	-- Accept currently selected item. If none selected, `select` first item.
	-- Set `select` to `false` to only confirm explicitly selected items.
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expandable() then
			luasnip.expand()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		elseif check_backspace() then
			fallback()
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, {
		"i",
		"s",
	}),
})

local cmp_formatting = {
	fields = { "kind", "abbr", "menu" },
	format = function(entry, vim_item)
		-- Kind icons
		vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
		-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
		vim_item.menu = ({
			nvim_lsp = "[lsp]",
			luasnip = "[snip]",
			buffer = "[buff]",
			path = "[path]",
		})[entry.source.name]
		return vim_item
	end,
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	-- documentation = {
	--   border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	-- },
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
}

local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp_mappings,
	formatting = cmp_formatting,
})

lsp.set_sign_icons({
	error = "",
	--[[ warn = '▲', ]]
	--[[ hint = "⚑", ]]
	--[[ info = "»", ]]
	--[[ error = "", ]]
	warn = "",
	hint = "",
	info = "",
})

lsp.set_preferences({
	suggest_lsp_servers = true,
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.name == "tsserver" then
		return
	end
	--[[ if client.name == "eslint" then ]]
	--[[   vim.cmd.LspStop('eslint') ]]
	--[[   return ]]
	--[[ end ]]
	--
	if client.name == "eslint" then
		vim.keymap.set("n", "<Leader><Leader>f", "<cmd>EslintFixAll<CR>", opts)
	end

	if client.name == "gopls" then
		vim.keymap.set("n", "<Leader><Leader>f", "<cmd>GoImport<CR><cmd>GoFmt<CR>", opts)
	end

	vim.keymap.set("n", "<F12>", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
	vim.keymap.set("n", "gj", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "gl", vim.diagnostic.goto_next, opts)
	vim.keymap.set("n", "gh", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "<leader><leader>a", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<Leader>fr", vim.lsp.buf.format, opts)
end)

lsp.setup()

require("typescript").setup({
	server = {
		on_attach = function(client, bufnr)
			-- You can find more commands in the documentation:
			-- https://github.com/jose-elias-alvarez/typescript.nvim#commands
			vim.keymap.set("n", "<leader>i", "<cmd>TypescriptAddMissingImports<cr>", { buffer = bufnr })
			vim.keymap.set("n", "<Leader><leader>o", "<cmd>TypescriptOrganizeImports<CR>", { buffer = bufnr })
			vim.keymap.set("n", "<Leader><leader>i", "<cmd>TypescriptAddMissingImports<CR>", { buffer = bufnr })
			vim.keymap.set("n", "<Leader>a", "<cmd>TypescriptFixAll<CR>", { buffer = bufnr })
		end,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			-- leads to funny formatting
			--[[ "svelte", ]]
		},
		settings = {
			completions = {
				completeFunctionCalls = true,
			},
		},
	},
})

lsp.configure("tsserver", {
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		-- leads to funny formatting
		--[[ "svelte", ]]
	},
	settings = {
		completions = {
			completeFunctionCalls = true,
		},
	},
})
vim.diagnostic.config({
	virtual_text = true,
})
