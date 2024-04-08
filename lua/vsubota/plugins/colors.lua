local custom_highlights = {
	["catppuccin-macchiato"] = function(colors)
		return {
			-- Number Line color
			LineNr = { fg = colors.overlay0 },
			-- Cursor Line color
			CursorLineNr = { fg = colors.saphire },

			-- Customize the highlighting color to grey for current and lenth lines
			CursorLine = { bg = "#303347" },
			ColorColumn = { bg = "#303347" },
			-- CursorLine = { bg = colors.surface0 },
			-- ColorColumn = { bg = colors.surface0 },

			-- Function IBL line
			IblScope = { fg = colors.surface1 },

			-- Gitsign colors for added, changed and deleted lines
			GitSignsAdd = { fg = colors.blue },
			GitSignsChange = { fg = colors.yellow },
			GitSignsDelete = { fg = colors.red },

			-- Collors for refs autohiglights
			LspReferenceRead = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface0 },
			LspReferenceText = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface0 },
			LspReferenceWrite = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface0 },
		}
	end,
}

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		local current_colorscheme = "catppuccin-macchiato"
		-- local current_colorscheme = "catppuccin-latte"

		require("catppuccin").setup({
			custom_highlights = custom_highlights[current_colorscheme],
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.25, -- percentage of the shade to apply to the inactive window
			},
		})

		vim.cmd.colorscheme(current_colorscheme)
	end,
}
