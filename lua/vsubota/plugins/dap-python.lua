return {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local path = "/Users/viktorsubota/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)

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
