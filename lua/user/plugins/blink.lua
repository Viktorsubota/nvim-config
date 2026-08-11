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
        enabled = function()
            return not vim.tbl_contains({ "snacks_picker_input" }, vim.bo.filetype)
                and vim.bo.buftype ~= "prompt"
                and vim.b.completion ~= false
        end,
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
            ["<CR>"] = { "select_and_accept", "fallback" },
            ["<C-y>"] = { "hide", "fallback" },
        },
        completion = {
            list = { selection = { preselect = true, auto_insert = false } },
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
            providers = {
                lsp = { score_offset = 100 },       -- LSP symbols (variables, methods, functions, keywords) top priority
                snippets = { score_offset = 50 },   -- Snippets next
                buffer = { score_offset = -10 },    -- Buffer text lower
                path = { score_offset = -20 },
            },
        },
        snippets = { preset = "default" }, -- native vim.snippet
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = { "exact", "score", "sort_text", "label" },
        },
    },
    opts_extend = { "sources.default" },
}
