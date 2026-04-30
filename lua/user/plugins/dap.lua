return {
	"mfussenegger/nvim-dap",
	dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
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
	keys = {
		{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Put Debug Breakpoint" },
	},
	lazy = true,
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff0000" })

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			-- dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function() end
	end,
}
