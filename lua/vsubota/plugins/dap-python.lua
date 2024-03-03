return {
    "mfussenegger/nvim-dap-python",
    ft = { "py" },
    event = "VeryLazy",
    requires = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    config = function()
        local path = "/Users/viktorsubota/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
    end,
}
