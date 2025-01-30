vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Enable soft wrapping (visual wrap) for long lines
vim.opt.wrap = true -- Enable wrapping
vim.opt.linebreak = true -- Do not break words in the middle

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 100

vim.opt.colorcolumn = "80,100"

vim.g.mapleader = " "

vim.opt.mouse = ""

-- Always split to the right
vim.o.splitright = true

-- Always split to the bottom
vim.o.splitbelow = true

-- Enable line highlighting for the current line by default
vim.wo.cursorline = true

vim.opt.spelllang = "en_us"
vim.opt.spell = true
