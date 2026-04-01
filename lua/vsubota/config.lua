-- Higlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Higlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", {clear = true}),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Workaround: Neovim 0.12.0 treesitter 'range' bug in non-file buffers
-- https://github.com/neovim/neovim/issues/35312
-- Remove this after upgrading to 0.12.1+
local ok, ts_hl = pcall(require, "vim.treesitter.highlighter")
if ok and ts_hl then
    local orig_on_line = ts_hl._on_line
    if orig_on_line then
        ts_hl._on_line = function(...)
            local success, err = pcall(orig_on_line, ...)
            if not success and err and tostring(err):find("'range'") then
                return
            end
            if not success then
                error(err)
            end
        end
    end
end
