return {
    "leoluz/nvim-dap-go",
    dependencies = {
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },
    keys = {
        { "<leader>dt", function() require("dap-go").debug_test() end, ft = "go", desc = "Debug Go test" },
        { "<leader>dl", function() require("dap-go").debug_last_test() end, ft = "go", desc = "Debug last Go test" },
    },
    config = function()
        require("dap-go").setup()
    end,
}
