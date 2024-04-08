local custom_highlights = {
	["catppuccin-mocha"] = function(colors)
		return {
			Normal = { bg = "none" },
			NormalFloat = { bg = "none" },

			-- Number Line color
			LineNr = { fg = colors.overlay0 },
			-- Cursor Line color
			CursorLineNr = { fg = colors.saphire },

			-- Customize the highlighting color to grey for current and lenth lines
			CursorLine = { bg = colors.surface0 },
			ColorColumn = { bg = colors.surface0 },

			-- Function IBL line
			CurrentScope = { fg = colors.surface1 },

			-- Gitsign colors for added, changed and deleted lines
			GitSignsAdd = { fg = colors.blue },
			GitSignsChange = { fg = colors.yellow },
			GitSignsDelete = { fg = colors.red },

			-- Collors for refs autohiglights
			LspReferenceRead = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface1 },
			LspReferenceText = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface1 },
			LspReferenceWrite = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface1 },
		}
	end,
}

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local current_colorscheme = "catppuccin-mocha"

		require("catppuccin").setup({ custom_highlights = custom_highlights["catppuccin-mocha"] })

		vim.cmd.colorscheme(current_colorscheme)
	end,
}
