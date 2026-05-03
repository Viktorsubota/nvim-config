local function fuzzy_refine(picker)
	local search = picker.input:get() or ""
	local items = picker:items()

	-- Swap the finder to return current filtered items
	picker.finder._find = function()
		return items
	end

	-- Update the title in-place
	picker.title = "Refine [" .. search .. "]"

	-- Clear input and refresh without recreating the picker
	picker.input:set("", "")
	picker:find({ refresh = true })
end

return {
	"folke/snacks.nvim",
	lazy = false,
	priority = 1000,
	keys = {
		{
			"<leader>fp",
			function()
				Snacks.picker.files()
			end,
			desc = "Find files",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep (with args via -- -iglob)",
		},
		{
			"<leader>fl",
			function()
				Snacks.picker.grep({ live = true })
			end,
			desc = "Live grep",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep_word()
			end,
			mode = { "n", "x" },
			desc = "Grep word/selection",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git status",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit.open()
			end,
			desc = "Open LazyGit",
		},
		{
			"<leader>?",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Search keymaps",
		},
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
				underline = false,
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
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
							},
							{ win = "list", border = "rounded" },
						},
						{
							win = "preview",
							title = "{preview}",
							width = 0.45,
							border = "rounded",
							title_pos = "center",
						},
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
