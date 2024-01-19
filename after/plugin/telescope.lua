local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fl", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

local opts = { noremap = true, silent = true }
opts.desc = "Show LSP references"
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<CR>", opts)

opts.desc = "Show LSP definitions"
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_definitions<CR>", opts)

opts.desc = "Show LSP implementations"
vim.keymap.set("n", "<leader>fi", "<cmd>Telescope lsp_implementations<CR>", opts)

opts.desc = "Show LSP type definitions"
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope lsp_type_definitions<CR>", opts)

opts.desc = "Show buffer diagnostics"
vim.keymap.set("n", "<leader>fD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

opts.desc = "Show outgoing calls<CR>"
vim.keymap.set("n", "<leader>foc", "<cmd>Telescope lsp_outgoing_calls<CR>", opts)

opts.desc = "Show incoming calls<CR>"
vim.keymap.set("n", "<leader>fic", "<cmd>Telescope lsp_incoming_calls<CR>", opts)
