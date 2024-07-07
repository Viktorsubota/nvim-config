return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local transform_mod = require("telescope.actions.mt").transform_mod
			local lga_actions = require("telescope-live-grep-args.actions")
			local builtin = require("telescope.builtin")

			-- or create your custom action
			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_bufnr)
					vim.cmd("copen")
				end,
			})

			require("telescope").setup({
				extensions = {
					live_grep_args = {
						auto_quoting = true, -- enable/disable auto-quoting
						-- define mappings, e.g.
						mappings = { -- extend mappings
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								-- freeze the current list and start a fuzzy search in the frozen list
								["<C-f>"] = actions.to_fuzzy_refine,
							},
						},
					},
				},
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

			telescope.load_extension("live_grep_args")
			telescope.load_extension("fzf")

			local builtin = require("telescope.builtin")
			-- local opts = { noremap = true, silent = true }
			local opts = {}

			opts.desc = "Find all files"
			vim.keymap.set("n", "<leader>pf", builtin.find_files, opts)

			opts.desc = "Find Git files"
			vim.keymap.set("n", "<leader>pg", builtin.git_files, opts)

			opts.desc = "Find pattern live with args"
			vim.keymap.set("n", "<leader>pl", telescope.extensions.live_grep_args.live_grep_args, opts)

			opts.desc = "Find pattern staticly by files"
			vim.keymap.set("n", "<leader>ps", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end, opts)

			opts.desc = "Find word under cursor"
			vim.keymap.set("n", "<leader>pw", builtin.grep_string, opts)

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
