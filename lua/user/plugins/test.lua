-- vim-test + vimux: run tests in a real tmux pane (`:TestNearest` etc.)
return {
	"vim-test/vim-test",
	dependencies = { "preservim/vimux" },
	keys = {
		{ "<leader>tt", "<cmd>TestNearest<CR>", desc = "Test nearest" },
		{ "<leader>tf", "<cmd>TestFile<CR>", desc = "Test file" },
		{ "<leader>tp", "<cmd>TestSuite<CR>", desc = "Test suite/package" },
		{ "<leader>tl", "<cmd>TestLast<CR>", desc = "Test last" },
		{ "<leader>tv", "<cmd>TestVisit<CR>", desc = "Visit last test file" },
	},
	init = function()
		vim.g["test#strategy"] = "vimux"
		-- Verbose output for the languages where it matters
		vim.g["test#go#gotest#options"] = "-v"
		vim.g["test#python#pytest#options"] = "-v"
		vim.g["test#javascript#jest#options"] = "--verbose"
		-- vimux pane: open horizontally below at 30% height
		vim.g.VimuxOrientation = "v"
		vim.g.VimuxHeight = "30"
		-- Always create a dedicated pane instead of hijacking an existing nearby one
		vim.g.VimuxUseNearest = 0
	end,
}
