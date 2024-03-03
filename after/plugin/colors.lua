function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- Enable line highlighting for the current line by default
	vim.wo.cursorline = true

	-- Customize the highlighting color to grey
	vim.cmd("highlight CursorLine ctermbg=223 guibg=#2c3042")
	vim.cmd("highlight ColorColumn ctermbg=223 guibg=#2c3042")
end

require("catppuccin").setup({
	-- transparent_background = true,
	-- dim_inactive = {
	-- 	enabled = true, -- dims the background color of inactive window
	-- 	shade = "dark",
	-- 	percentage = 0.15, -- percentage of the shade to apply to the inactive window
	-- },
})

ColorMyPencils()
