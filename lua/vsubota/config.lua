local o = vim.opt

o.colorcolumn = nil

-- Line numbers etc in Netrw
vim.cmd([[let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro']])

-- Always split to the right
vim.o.splitright = true

-- Always split to the bottom
vim.o.splitbelow = true

