local plugins = {
	{
		"nvim-lua/popup.nvim",
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"dracula/vim",
	},
	{
		"simrat39/symbols-outline.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
	},
	-- impatient.nvim - faster uptime
	{
		"lewis6991/impatient.nvim",
	},
	-- Harpoon
	{
		"ThePrimeagen/harpoon",
	},
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			"williamboman/mason-lspconfig.nvim",

			-- Autocompletion
			{
				"hrsh7th/nvim-cmp",
				event = "InsertEnter",
				dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" },
			},
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			-- Snippets
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
			},
			"rafamadriz/friendly-snippets",
			"Shougo/neosnippet.vim",
			"Shougo/neosnippet-snippets",
		},
	},
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/playground",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	-- vim fugitive
	{
		"tpope/vim-fugitive",
	},
	-- vim-rhubarb for github integration
	{
		"tpope/vim-rhubarb",
	},
	-- netrw replacement oil.nvim
	{
		"stevearc/oil.nvim",
	},
	-- open browser
	{
		"tyru/open-browser.vim",
	},
	-- Go
	{
		"ray-x/go.nvim",
		ft = "go",
	},
	-- Typescript
	{
		"jose-elias-alvarez/typescript.nvim",
	},
	-- Debugging
	{
		"mfussenegger/nvim-dap",
	},
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	{
		"theHamsta/nvim-dap-virtual-text",
	},
	{
		"ray-x/guihua.lua",
		run = "cd lua/fzy && make",
	},
	-- Auto Closing Pairs
	{
		"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitt,
	},
	{
		"kyazdani42/nvim-web-devicons",
	},
	-- Comments
	{
		"numToStr/Comment.nvim",
	},
	-- Git
	{
		"lewis6991/gitsigns.nvim",
	},

	-- Toggle term
	{
		"akinsho/toggleterm.nvim",
	},
	-- rest.nvim
	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
	},
	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		--[[ config = function() ]]
			--[[ require("rest-nvim").setup() ]]
		--[[ end, ]]
	},
	{
		"nvim-lua/plenary.nvim",
	},
	-- database plugin
	{
		"tpope/vim-dadbod",
	},

	-- run and debug jest tests
	{
		"David-Kunz/jester",
		config = function()
			require("jester").setup({
				setopt = true,
				dap = {
					console = "externalTerminal",
				},
			})
		end,
	},
	-- Status line
	{
		"NTBBloodbath/galaxyline.nvim",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	-- statuscol
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			require("statuscol").setup({
				setopt = true,
			})
			--[[ vim.o.statuscolumn = "%@v:lua.ScFa@%C%T%@v:lua.ScLa@%s%T@v:lua.ScNa@%=%{v:lua.ScLn()}%T" ]]
		end,
	},
	-- buffer delete without closing last buffer
	{
		"moll/vim-bbye",
	},
	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim", -- for formatters and linte,
	},
	-- AutoSave.nvim
	{
		"Pocco81/auto-save.nvim",
		config = function()
			require("auto-save").setup({})
		end,
	},
	-- refactoring.nvim
	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	-- hex color preview
	{
		"gko/vim-coloresque",
	},
	-- markdown-preview.nvim
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = "markdown",
	},
	-- copilot
	{
		"github/copilot.vim",
	},
	-- replaces matchparen.vim
	{
		"monkoose/matchparen.nvim",
		config = function()
			require("matchparen").setup({
				on_startup = true, -- Should it be enabled by default
				hl_group = "MatchParen", -- highlight group for matched characters
				augroup_name = "matchparen", -- almost no reason to touch this unless there is already augroup with such name
			})
		end,
	},
	-- indent guides for Neovim
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		main = "ibl",
		opts = {
			show_end_of_line = true,
			char = "▏",
			--[[ char = "│", ]]
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "oil" },
			show_trailing_blankline_indent = true,
			show_current_context = true,
		},
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("eol:↴")
		end,
	},
	{
		"jamestthompson3/nvim-remote-containers",
		cmd = { "AttachToContainer", "BuildImage", "StartImage", "ComposeUp", "ComposeDown", "ComponseDestroy" },
	},
}

return plugins
