return {
	"mfussenegger/nvim-dap-python",
	ft = { "py" },
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
		local path = "/Users/viktorsubota/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
		require("dap-python").setup(path)
	end,
}
