vim.cmd([[colorscheme dracula]])
-- vim.cmd([[colorscheme github_dark_high_contrast]])

require("transparent").setup({
	groups = { -- table: default groups
		"Normal",
		"NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		"SignColumn",
		"CursorLineNr",
		"EndOfBuffer",
	},
	extra_groups = {
		--[[ "NoiceConfirm", ]]
		--[[ "NoiceFormatConfirm", ]]
		--[[ "NoiceFormatProgressTodo", ]]
		"NoiceMini",
		"NoicePopup",
		--[[ "NoicePopupmenu", ]]
		--[[ "NoicePopupmenuSelected", ]]
		--[[ "NoiceScrollbarThumb", ]]
		"NoiceSplit",
	}, -- table: additional groups that should be cleared
	exclude_groups = {}, -- table: groups you don't want to clear
})
