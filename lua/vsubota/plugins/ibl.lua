return {
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require("ibl").setup({
			scope = {
				enabled = false,
				show_start = true,
				show_end = true,
			},
		})
	end,
}
