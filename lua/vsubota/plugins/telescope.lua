return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local transform_mod = require("telescope.actions.mt").transform_mod

			-- or create your custom action
			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_bufnr)
					vim.cmd("copen")
				end,
			})

			require("telescope").setup({
				defaults = {
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
					sorting_strategy = "ascending",
					--- other configs
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<C-k>"] = actions.move_selection_previous, -- move to prev result
							["<C-j>"] = actions.move_selection_next, -- move to next result
							["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						},
					},
				},
			})

			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
			vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
			vim.keymap.set("n", "<leader>pl", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)
			vim.api.nvim_set_keymap("v", "<leader>pl", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>", {})

			local opts = { noremap = true, silent = true }

			opts.desc = "Show LSP references"
			vim.keymap.set("n", "<leader>pr", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Show LSP definitions"
			vim.keymap.set("n", "<leader>pd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			vim.keymap.set("n", "<leader>pi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			vim.keymap.set("n", "<leader>pt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "Show buffer diagnostics"
			vim.keymap.set("n", "<leader>pD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show outgoing calls<CR>"
			vim.keymap.set("n", "<leader>poc", "<cmd>Telescope lsp_outgoing_calls<CR>", opts)

			opts.desc = "Show incoming calls<CR>"
			vim.keymap.set("n", "<leader>pic", "<cmd>Telescope lsp_incoming_calls<CR>", opts)

			opts.desc = "Show document symbols<CR>"
			vim.keymap.set("n", "<leader>pds", "<cmd>Telescope lsp_document_symbols<CR>", opts)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})

			require("telescope").load_extension("ui-select")
		end,
	},
}
