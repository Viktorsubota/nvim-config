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
		-- IDE-standard function keys for stepping (no modifier conflicts)
		{ "<F5>", "<cmd>DapContinue<cr>", desc = "DAP continue" },
		{ "<F10>", "<cmd>DapStepOver<cr>", desc = "DAP step over" },
		{ "<F11>", "<cmd>DapStepInto<cr>", desc = "DAP step into" },
		{ "<F12>", "<cmd>DapStepOut<cr>", desc = "DAP step out" },
		-- Breakpoints
		{ "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "DAP toggle breakpoint" },
		{
			"<leader>dB",
			function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			desc = "DAP conditional breakpoint",
		},
		-- Session control
		{ "<leader>dr", "<cmd>DapToggleRepl<cr>", desc = "DAP toggle REPL" },
		{ "<leader>dx", "<cmd>DapTerminate<cr>", desc = "DAP terminate" },
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			desc = "DAP UI toggle",
		},
	},
	lazy = true,
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		dapui.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff0000" })

		-- Open the DAP UI on attach/launch; intentionally leave it open after the session
		-- exits so panes (scopes/stacks/console) stay available for inspection
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
	end,
}
