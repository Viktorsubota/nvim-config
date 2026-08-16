vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

-- Window navigation (<C-h/j/k/l>) is handled by vim-tmux-navigator

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Right>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Up>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Down>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Left>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("i", "<Right>", "<Nop>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "<C-w>g", "<cmd>split<CR>")

vim.keymap.set("v", "<leader>bd", "y:let @\"=system('base64 --decode', @\")<cr>gvP")
vim.keymap.set("v", "<leader>be", "y:let @\"=system('base64', @\")<cr>gvP")

-- Yank buffer path: yp = full path, yd = directory (oil-aware).
-- Honors register prefixes like native yank ("ayp); with no register
-- it also copies to the system clipboard.
local function yank_path(kind)
    return function()
        local path
        if vim.bo.filetype == "oil" then
            local oil = require("oil")
            local dir = oil.get_current_dir()
            if kind == "file" then
                local entry = oil.get_cursor_entry()
                path = entry and dir and (dir .. entry.name) or dir
            else
                path = dir
            end
        else
            local name = vim.api.nvim_buf_get_name(0)
            if name ~= "" then
                path = kind == "file" and name or vim.fs.dirname(name)
            end
        end
        if not path or path == "" then
            vim.notify("No path for this buffer", vim.log.levels.WARN)
            return
        end
        local reg = vim.v.register
        vim.fn.setreg(reg, path)
        if reg == '"' then
            vim.fn.setreg("+", path)
        end
        vim.notify("Yanked: " .. path)
    end
end

vim.keymap.set("n", "yp", yank_path("file"), { desc = "Yank file path (oil: entry under cursor)" })
vim.keymap.set("n", "yd", yank_path("dir"), { desc = "Yank directory path" })

-- Snippet placeholder navigation in Normal/Select mode (<Tab> / <S-Tab>)
vim.keymap.set({ "n", "s" }, "<Tab>", function()
    if vim.snippet.active({ direction = 1 }) then
        return "<cmd>lua vim.snippet.jump(1)<CR>"
    else
        return "<Tab>"
    end
end, { expr = true, silent = true, desc = "Jump to next snippet placeholder" })

vim.keymap.set({ "n", "s" }, "<S-Tab>", function()
    if vim.snippet.active({ direction = -1 }) then
        return "<cmd>lua vim.snippet.jump(-1)<CR>"
    else
        return "<S-Tab>"
    end
end, { expr = true, silent = true, desc = "Jump to previous snippet placeholder" })
