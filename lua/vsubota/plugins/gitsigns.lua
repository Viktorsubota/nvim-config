return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>gu", "<cmd>:Gitsigns reset_hunk<CR>", { desc = "Reset git hunk" })
		vim.keymap.set("v", "<leader>gu", "<cmd>:'<,'>Gitsigns reset_hunk<CR>", { desc = "Reset git hunk selection" })
		vim.keymap.set("n", "<leader>gp", "<cmd>:Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })

		vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#8aadf4" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#eed49f" })
		vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ed8796" })

		require("gitsigns").setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
		})
	end,
}
