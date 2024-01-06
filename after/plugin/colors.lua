function ColorMyPencils(color)
	color = color or "catppuccin"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	-- Enable line highlighting for the current line by default
	vim.wo.cursorline = true

	-- Customize the highlighting color to grey
	vim.cmd("highlight CursorLine ctermbg=135 guibg=#362E4A")
end

ColorMyPencils()
