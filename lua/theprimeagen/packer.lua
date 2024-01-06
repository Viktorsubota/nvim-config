-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { "catppuccin/nvim", as = "catppuccin" }

  use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

  use "nvim-lua/plenary.nvim"
  use {
	  "theprimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }

  use "mbbill/undotree"

  use "tpope/vim-fugitive"

  use {
      'nvimtools/none-ls.nvim', -- configure formatters & linters
      lazy = true,
      -- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
      requires = {
          'jay-babu/mason-null-ls.nvim',
      }
  }

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

    -- nvim-dap
    use {
        'mfussenegger/nvim-dap',
        config = function()
            require("core.utils").load_mappings("dap")
        end
    }
    -- nvim-dap-python
    use {
        'mfussenegger/nvim-dap-python',
        ft = 'python',
        requires = {
            'mfussenegger/nvim-dap',
            'rcarriga/nvim-dap-ui',
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
            require("core.utils").load_mappings("dap_python")
        end,
    }
end)

