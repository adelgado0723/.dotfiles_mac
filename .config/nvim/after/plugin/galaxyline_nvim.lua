local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = { "LuaTree", "vista", "dbui" }

local colors = require("galaxyline.themes.colors").dracula

local isRecording = function()
	if vim.fn.reg_recording() ~= "" then
		return "     "
	end
	return ""
end

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

gls.left[0] = {
	FirstElement = {
		provider = function()
			return "▋"
		end,
		highlight = { colors.blue, colors.yellow },
	},
}
gls.left[1] = {
	Mode = {
		provider = isRecording,
		highlight = { colors.green, colors.bg },
	},
}
gls.left[2] = {
	ViMode = {
		provider = function()
			local alias =
				{ n = "    ", i = "    ", c = "    ", v = "  ﭑ   ", V = "  ﭑ  ", [""] = "  ﭑ  " }
			return alias[vim.fn.mode()]
		end,
		separator = "",
		separator_highlight = {
			colors.purple,
			function()
				if not buffer_not_empty() then
					return colors.purple
				end
				return colors.darkblue
			end,
		},
		highlight = { colors.darkblue, colors.purple, "bold" },
	},
}
--[[ gls.left[3] = { ]]
--[[ 	FileIcon = { ]]
--[[ 		provider = "FileIcon", ]]
--[[ 		condition = buffer_not_empty, ]]
--[[ 		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.darkblue }, ]]
--[[ 	}, ]]
--[[ } ]]
--
gls.left[4] = {
	FileName = {
		provider = { "FilePath", "FileSize" },
		condition = buffer_not_empty,
		separator = "",
		separator_highlight = { colors.purple, colors.darkblue },
		highlight = { colors.magenta, colors.darkblue },
	},
}

--[[ gls.left[5] = { ]]
--[[ 	GitIcon = { ]]
--[[ 		provider = function() ]]
--[[ 			return "  " ]]
--[[ 		end, ]]
--[[ 		condition = buffer_not_empty, ]]
--[[ 		highlight = { colors.orange, colors.purple }, ]]
--[[ 	}, ]]
--[[ } ]]
--[[ gls.left[6] = { ]]
--[[ 	GitBranch = { ]]
--[[ 		provider = "GitBranch", ]]
--[[ 		condition = buffer_not_empty, ]]
--[[ 		highlight = { colors.grey, colors.purple }, ]]
--[[ 	}, ]]
--[[ } ]]
--[[ local checkwidth = function() ]]
--[[ 	local squeeze_width = vim.fn.winwidth(0) / 2 ]]
--[[ 	if squeeze_width > 40 then ]]
--[[ 		return true ]]
--[[ 	end ]]
--[[ 	return false ]]
--[[ end ]]
--[[]]
--[[ gls.left[7] = { ]]
--[[ 	DiffAdd = { ]]
--[[ 		provider = "DiffAdd", ]]
--[[ 		condition = checkwidth, ]]
--[[ 		icon = " ", ]]
--[[ 		highlight = { colors.green, colors.purple }, ]]
--[[ 	}, ]]
--[[ } ]]
--[[ gls.left[8] = { ]]
--[[ 	DiffModified = { ]]
--[[ 		provider = "DiffModified", ]]
--[[ 		condition = checkwidth, ]]
--[[ 		icon = " ", ]]
--[[ 		highlight = { colors.orange, colors.purple }, ]]
--[[ 	}, ]]
--[[ } ]]
--[[ gls.left[9] = { ]]
--[[ 	DiffRemove = { ]]
--[[ 		provider = "DiffRemove", ]]
--[[ 		condition = checkwidth, ]]
--[[ 		icon = " ", ]]
--[[ 		highlight = { colors.red, colors.purple }, ]]
--[[ 	}, ]]
--[[ } ]]
--[[ gls.left[10] = { ]]
--[[ 	LeftEnd = { ]]
--[[ 		provider = function() ]]
--[[ 			return "" ]]
--[[ 		end, ]]
--[[ 		separator = "", ]]
--[[ 		separator_highlight = { colors.purple, colors.bg }, ]]
--[[ 		highlight = { colors.purple, colors.purple }, ]]
--[[ 	}, ]]
--[[ } ]]
gls.left[11] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}
gls.left[12] = {
	Space = {
		provider = function()
			return " "
		end,
	},
}
gls.left[13] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.blue, colors.bg },
	},
}
gls.left[14] = {
	GitIcon = {
		provider = function()
			return vim.g.currentContainer or "No Container"
		end,
		condition = buffer_not_empty,
		highlight = { colors.orange, colors.purple },
	},
}
gls.mid[1] = {
	GetLspClient = {
		provider = "GetLspClient",
		icon = "   ",
		highlight = { colors.green, colors.purple },
	},
}
gls.right[1] = {
	FileFormat = {
		provider = "FileFormat",
		separator = "",
		separator_highlight = { colors.bg, colors.purple },
		highlight = { colors.grey, colors.purple },
	},
}
gls.right[2] = {
	LineInfo = {
		provider = "LineColumn",
		separator = " | ",
		separator_highlight = { colors.darkblue, colors.purple },
		highlight = { colors.grey, colors.purple },
	},
}
gls.right[3] = {
	PerCent = {
		provider = "LinePercent",
		separator = "",
		separator_highlight = { colors.darkblue, colors.purple },
		highlight = { colors.grey, colors.darkblue },
	},
}
gls.right[4] = {
	ScrollBar = {
		provider = "ScrollBar",
		highlight = { colors.yellow, colors.purple },
	},
}

gls.short_line_left[1] = {
	BufferType = {
		provider = "FileTypeName",
		separator = "",
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.grey, colors.purple },
	},
}

gls.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
		separator = "",
		separator_highlight = { colors.purple, colors.bg },
		highlight = { colors.grey, colors.purple },
	},
}
