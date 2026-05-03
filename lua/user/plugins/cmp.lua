return {
	"saghen/blink.cmp",
	version = "1.*", -- pinned to v1; minor/patch updates allowed
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets", -- VSCode-format snippets; blink reads them directly
	},
	---@module "blink.cmp"
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "default",
			-- Match the snacks picker convention (<C-j>/<C-k> for list nav)
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			-- Snippet placeholder nav (in addition to the default <Tab>/<S-Tab>)
			["<C-l>"] = { "snippet_forward", "fallback" },
			["<C-h>"] = { "snippet_backward", "fallback" },
			["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-e>"] = { "hide", "fallback" },
			-- Inside a snippet placeholder, <CR> jumps to the next param.
			-- Otherwise it accepts the selected completion (or inserts a newline).
			["<CR>"] = { "snippet_forward", "accept", "fallback" },
		},
		completion = {
			-- Auto-insert () after picking a function (replaces nvim-autopairs cmp glue)
			accept = { auto_brackets = { enabled = true } },
			menu = { border = "rounded" },
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				window = { border = "rounded" },
			},
		},
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		sources = {
			default = { "lsp", "snippets", "buffer", "path" },
		},
		snippets = { preset = "default" }, -- native vim.snippet
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
