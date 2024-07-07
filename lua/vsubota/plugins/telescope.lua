local opts = { noremap = true, silent = true }

return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
        keys = {
            { "<leader>pf",  "<cmd>Telescope find_files <CR>",          desc = "Find all files",                 opts },
            { "<leader>pg",  "<cmd>Telescope git_files <CR>",           desc = "Find Git files",                 opts },
            { "<leader>ps",  "<cmd>Telescope live_grep_args <CR>",      desc = "Project search with arguments",  opts },
            { "<leader>pl",  "<cmd>Telescope live_grep <cr>",           desc = "find pattern staticly by files", opts },
            { "<leader>pw",  "<cmd>Telescope grep_string",              desc = "find word under cursor",         opts },
            { "<leader>pr",  "<cmd>Telescope lsp_references<cr>",       desc = "show lsp references",            opts },
            { "<leader>pd",  "<cmd>Telescope lsp_definitions<cr>",      desc = "show lsp definitions",           opts },
            { "<leader>pi",  "<cmd>Telescope lsp_implementations<cr>",  desc = "show lsp implementations",       opts },
            { "<leader>pt",  "<cmd>Telescope lsp_type_definitions<cr>", desc = "show lsp type definitions",      opts },
            { "<leader>pd",  "<cmd>Telescope diagnostics bufnr=0<cr>",  desc = "show buffer diagnostics",        opts },
            { "<leader>poc", "<cmd>Telescope lsp_outgoing_calls<cr>",   desc = "show outgoing calls<cr>",        opts },
            { "<leader>pic", "<cmd>Telescope lsp_incoming_calls<cr>",   desc = "show incoming calls<cr>",        opts },
            { "<leader>pds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "show document symbols<cr>",      opts },
        },

		cmd = { "Telescope" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local actions = require("telescope.actions")
			local transform_mod = require("telescope.actions.mt").transform_mod
			local lga_actions = require("telescope-live-grep-args.actions")
			local action_state = require("telescope.actions.state")

			-- or create your custom action
			local custom_actions = transform_mod({
				open_trouble_qflist = function(prompt_bufnr)
					vim.cmd("copen")
				end,
			})

			telescope.setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
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
				pickers = {
					live_grep = {
						mappings = {
							i = {
								["<C-f>"] = function(prompt_bufnr)
									local current_prompt = action_state.get_current_line()
									actions.close(prompt_bufnr)

									builtin.grep_string({
										prompt_title = "Live Grep: file filter",
										search = current_prompt,
									})
								end,
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
			telescope.load_extension("ui-select")
		end,
	},
}
