local function fuzzy_refine(picker)
	local search = picker.input:get() or ""
	local items = picker:items()
	picker:close()

	local refine_picker = Snacks.picker({
		title = "Refine [" .. search .. "]",
		items = items,
		focus = "input",
		layout = "telescope",
		matcher = { frecency = false },
		actions = {
			refine_again = function(p)
				fuzzy_refine(p)
			end,
		},
		confirm = "jump",
		win = {
			input = {
				keys = {
					["<C-f>"] = { "refine_again", mode = { "i", "n" }, desc = "Refine again" },
				},
			},
		},
	})
	vim.defer_fn(function()
		vim.cmd("startinsert")
	end, 50)
end

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Find files" },
		{ "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find git files" },
		{ "<leader>fs", function() Snacks.picker.grep() end, desc = "Grep (with args via -- -iglob)" },
		{ "<leader>fl", function() Snacks.picker.grep({ live = true }) end, desc = "Live grep" },
		{ "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Grep word under cursor" },
		{ "<leader>fr", function() Snacks.picker.lsp_references() end, desc = "LSP references" },
		{ "<leader>fd", function() Snacks.picker.lsp_definitions() end, desc = "LSP definitions" },
		{ "<leader>fi", function() Snacks.picker.lsp_implementations() end, desc = "LSP implementations" },
		{ "<leader>ft", function() Snacks.picker.lsp_type_definitions() end, desc = "LSP type definitions" },
		{ "<leader>fD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer diagnostics" },
		{ "<leader>foc", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Outgoing calls" },
		{ "<leader>fic", function() Snacks.picker.lsp_incoming_calls() end, desc = "Incoming calls" },
		{ "<leader>fds", function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
		{
			"<leader>fS",
			function()
				vim.ui.input({ prompt = "Search dir: ", completion = "dir" }, function(dir)
					if dir then
						Snacks.picker.grep({ cwd = dir })
					end
				end)
			end,
			desc = "Grep in directory",
		},
		{
			"<leader>fF",
			function()
				vim.ui.input({ prompt = "Search dir: ", completion = "dir" }, function(dir)
					if dir then
						Snacks.picker.files({ cwd = dir })
					end
				end)
			end,
			desc = "Find files in directory",
		},
		{ "<leader>lg", function() Snacks.lazygit.open() end, desc = "Open LazyGit" },
	},
	opts = {
		notifier = {
			enabled = true,
			timeout = 3000,
			width = { min = 40, max = 60 },
			style = "compact",
			top_down = false,
		},
		input = {
			enabled = true,
		},
		indent = {
			enabled = true,
			animate = { enabled = false },
			indent = {
				char = "▎",
			},
			scope = {
				char = "▎",
				underline = true,
			},
		},
		bigfile = {
			enabled = true,
			size = 1024 * 1024, -- 1MB
		},
		lazygit = {
			enabled = true,
		},
		picker = {
			focus = "input",
			matcher = {
				frecency = true,
			},
			layouts = {
				telescope = {
					reverse = true,
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.8,
						height = 0.9,
						border = "none",
						{
							box = "vertical",
							{ win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
							{ win = "list", border = "rounded" },
						},
						{ win = "preview", title = "{preview}", width = 0.45, border = "rounded", title_pos = "center" },
					},
				},
			},
			layout = "telescope",
			actions = {
				fuzzy_refine = function(picker)
					fuzzy_refine(picker)
				end,
			},
			win = {
				input = {
					keys = {
						["<C-j>"] = { "list_down", mode = { "i", "n" } },
						["<C-k>"] = { "list_up", mode = { "i", "n" } },
						["<C-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
						["<C-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
						["<C-f>"] = { "fuzzy_refine", mode = { "i", "n" }, desc = "Fuzzy refine results" },
						["<C-q>"] = { "qflist", mode = { "i", "n" } },
					},
				},
				list = {
					wo = { spell = false, conceallevel = 0 },
				},
				preview = {
					wo = { spell = false, conceallevel = 0 },
				},
			},
		},
	},
}
