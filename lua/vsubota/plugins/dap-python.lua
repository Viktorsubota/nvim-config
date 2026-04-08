return {
    "mfussenegger/nvim-dap-python",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    keys = {
        { "<leader>dm", function() require("dap-python").test_method() end, ft = "python", desc = "Debug Python method" },
        { "<leader>dc", function() require("dap-python").test_class() end, ft = "python", desc = "Debug Python class" },
    },
    config = function()
        require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

        local configs = require("dap").configurations.python
        table.insert(configs, {
            name = "Pytest: Current File",
            type = "python",
            request = "launch",
            module = "pytest",
            args = {
                "${file}",
                "-sv",
                "--log-cli-level=INFO",
                "--log-file=test_out.log",
            },
            console = "integratedTerminal",
        })
    end,
}
