return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    config = function() 
        vim.keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>")
    end
}
