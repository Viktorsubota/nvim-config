return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local current_session_name = require("auto-session.lib").current_session_name
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 2000,
					tabline = 2000,
					winbar = 2000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{
						"filename",
						path = 1,
						fmt = function(input)
							local line = string.gsub(input, "oil://", ""):gsub("/$", ""):gsub("/ ", " ")

							local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
							local path = vim.fn.fnamemodify(line, ":.:h")
							local filename = vim.fn.fnamemodify(line, ":t")

							local parts = { project, path, filename }
							return table.concat(parts, " ➜ ")
						end,
						color = function(_)
							return { fg = "#8AADF4" }
						end,
					},
				},
				lualine_x = { "filetype" },
				lualine_y = { "progress", "location" },
				lualine_z = { current_session_name },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
