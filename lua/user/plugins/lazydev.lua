-- Configures lua_ls for nvim config/plugin development: lazily adds type
-- definitions for vim APIs and only the plugins actually require()d, instead
-- of indexing the entire runtimepath
return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            -- Load luvit types when vim.uv is referenced
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
