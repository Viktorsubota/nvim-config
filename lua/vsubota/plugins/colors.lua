return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.overlay0 },
					CursorLineNr = { fg = colors.sapphire },
					CursorLine = { bg = vim.o.background == "dark" and "#3e4255" or colors.surface0 },
					ColorColumn = { bg = vim.o.background == "dark" and "#3e4255" or colors.surface0 },
					IblScope = { fg = colors.surface2 },
					GitSignsAdd = { fg = colors.blue },
					GitSignsChange = { fg = colors.yellow },
					GitSignsDelete = { fg = colors.red },
					GitSignsCurrentLineBlame = { fg = colors.overlay1 },
					LspReferenceRead = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface1 },
					LspReferenceText = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface1 },
					LspReferenceWrite = { cterm = { bold = true }, ctermbg = 135, bg = colors.surface1 },
					-- Dim inactive nvim splits
					NormalNC = { bg = vim.o.background == "dark" and colors.mantle or colors.mantle },
					-- Default floats (lighter — Harpoon, etc.)
					NormalFloat = { bg = colors.base },
					FloatBorder = { bg = colors.base, fg = colors.surface0 },
					-- LSP hover/diagnostics (darker)
					LspFloatNormal = { bg = colors.mantle },
					LspFloatBorder = { bg = colors.mantle, fg = colors.surface1 },
					-- Telescope (lighter)
					TelescopeNormal = { bg = colors.base },
					TelescopeBorder = { bg = colors.base, fg = colors.surface0 },
					TelescopeTitle = { bg = colors.base, fg = colors.blue },
					TelescopePromptNormal = { bg = colors.base },
					TelescopePromptBorder = { bg = colors.base, fg = colors.surface0 },
					TelescopePromptTitle = { bg = colors.base, fg = colors.blue },
					TelescopeResultsNormal = { bg = colors.base },
					TelescopeResultsBorder = { bg = colors.base, fg = colors.surface0 },
					TelescopeResultsTitle = { bg = colors.base, fg = colors.blue },
					TelescopePreviewNormal = { bg = colors.base },
					TelescopePreviewBorder = { bg = colors.base, fg = colors.surface0 },
					TelescopePreviewTitle = { bg = colors.base, fg = colors.blue },
					-- Snacks picker (lighter)
					SnacksPickerInput = { bg = colors.base },
					SnacksPickerInputBorder = { bg = colors.base, fg = colors.surface0 },
					SnacksPickerInputTitle = { bg = colors.base, fg = colors.blue },
					SnacksPickerList = { bg = colors.base },
					SnacksPickerListBorder = { bg = colors.base, fg = colors.surface0 },
					SnacksPickerPreview = { bg = colors.base },
					SnacksPickerPreviewBorder = { bg = colors.base, fg = colors.surface0 },
					SnacksPickerPreviewTitle = { bg = colors.base, fg = colors.blue },
					-- Plugin UIs (Lazy, Mason, etc.) — popup lighter, backdrop darker
					LazyNormal = { bg = colors.base },
					LazyBackdrop = { bg = colors.mantle },
				}
			end,

			transparent_background = true,

			background = {
				light = "latte",
				dark = "macchiato",
			},

			integrations = {
				snacks = true,
			},
		})

		vim.cmd.colorscheme("catppuccin")

		vim.api.nvim_create_autocmd("OptionSet", {
			pattern = "background",
			callback = function()
				vim.schedule(function()
					require("catppuccin").compile()
					vim.cmd.colorscheme("catppuccin")
				end)
			end,
		})
	end,
}
