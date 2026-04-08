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
				}
			end,

			transparent_background = true,

			background = {
				light = "latte",
				dark = "macchiato",
			},

			dim_inactive = {
				enabled = true,
				shade = "dark",
				percentage = 0.25,
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
