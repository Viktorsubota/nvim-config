return {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	opts = {},
	config = function(_, opts)
		require("colorizer").setup(opts)
		require("colorizer").attach_to_buffer(0)
	end,
}
