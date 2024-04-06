function ApplyCustomColoros(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- Enable line highlighting for the current line by default
	vim.wo.cursorline = true

	-- Customize the highlighting color to grey
	vim.cmd("highlight CursorLine ctermbg=223 guibg=#2c3042")
	vim.cmd("highlight ColorColumn ctermbg=223 guibg=#2c3042")

	-- Number Line color
	vim.cmd("highlight LineNr guifg=#6E6C7E")
	-- Cursor Line color
	vim.cmd("highlight CursorLineNr guifg=#C9CBFF")
end

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({})

		ApplyCustomColoros()
	end,
}
