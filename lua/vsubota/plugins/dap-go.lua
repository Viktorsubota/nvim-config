return {
	"leoluz/nvim-dap-go",
	ft = "go",
	cmd = {
		"DapContinue",
		"DapLoadLaunchJSON",
		"DapRestartFrame",
		"DapSetLogLevel",
		"DapShowLog",
		"DapStepInto",
		"DapStepOut",
		"DapStepOver",
		"DapTerminate",
		"DapToggleBreakpoint",
		"DapToggleRepl",
	},
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		require("dap-go").setup()
	end,
}
