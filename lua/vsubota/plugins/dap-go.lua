return {
    "leoluz/nvim-dap-go",
    ft = { "go" },
    event = "VeryLazy",
    requires = "mfussenegger/nvim-dap",
    config = function()
        require("dap-go").setup()
    end,
}
