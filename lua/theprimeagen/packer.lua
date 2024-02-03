-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({ "rose-pine/neovim", as = "rose-pine" })
	use({ "catppuccin/nvim", as = "catppuccin" })

	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	use("nvim-lua/plenary.nvim")
	use({
		"theprimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("mbbill/undotree")

	use("tpope/vim-fugitive")

	use({
		"nvimtools/none-ls.nvim", -- configure formatters & linters
		lazy = true,
		-- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
		requires = {
			"jay-babu/mason-null-ls.nvim",
		},
	})

	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	use({
		"folke/neodev.nvim",
		config = function()
			-- Additional configuration if needed
		end,
	})

	use({
		"rcarriga/nvim-dap-ui",
		requires = "mfussenegger/nvim-dap",
		library = { plugins = { "nvim-dap-ui" }, types = true },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				-- dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function() end
		end,
	})

	use({
		"leoluz/nvim-dap-go",
		ft = { "go" },
		requires = "mfussenegger/nvim-dap",
		config = function()
			require("dap-go").setup()
		end,
	})

	-- nvim-dap
	use({
		"mfussenegger/nvim-dap",
	})
	-- nvim-dap-python
	use({
		"mfussenegger/nvim-dap-python",
		ft = { "python" },
		requires = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		config = function()
			local path = "/Users/viktorsubota/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(path)
		end,
	})

	use("lewis6991/gitsigns.nvim")

	use("tpope/vim-commentary")

	use("tpope/vim-surround")

	use({
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function()
			require("gopher").setup()
		end,
		setup = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	})
end)
