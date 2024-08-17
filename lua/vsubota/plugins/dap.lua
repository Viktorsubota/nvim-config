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
        vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")

        local dap, dapui = require("dap"), require("dapui")
        dapui.setup()

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
