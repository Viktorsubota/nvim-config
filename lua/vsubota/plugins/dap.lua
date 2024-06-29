return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	-- cmd = {
	-- 	"DapContinue",
	-- 	"DapLoadLaunchJSON",
	-- 	"DapRestartFrame",
	-- 	"DapSetLogLevel",
	-- 	"DapShowLog",
	-- 	"DapStepInto",
	-- 	"DapStepOut",
	-- 	"DapStepOver",
	-- 	"DapTerminate",
	-- 	"DapToggleBreakpoint",
	-- 	"DapToggleRepl",
	-- },
	config = function()
		vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
	end,
}
