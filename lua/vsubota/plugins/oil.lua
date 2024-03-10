return {
	"stevearc/oil.nvim",
	opts = {},
	-- Optional dependencies
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		})

		local oil = require("oil")
		vim.keymap.set("n", "<leader>pv", function()
			oil.open()
		end)
	end,
}
