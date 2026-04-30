-- Equalize splits on terminal resize (e.g. tmux zoom/unzoom)
vim.api.nvim_create_autocmd("VimResized", {
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
