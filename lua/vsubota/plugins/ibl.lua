return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		vim.api.nvim_set_hl(0, "CurrentScope", { fg = "#3b4061" })
		require("ibl").setup({
			scope = {
				highlight = "CurrentScope",
				enabled = true,
				show_start = false,
				show_end = false,
			},
		})
	end,
}
