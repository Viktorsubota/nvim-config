return {
	"leoluz/nvim-dap-go",
	ft = { "go" },
	event = "VeryLazy",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("dap-go").setup()
	end,
}
