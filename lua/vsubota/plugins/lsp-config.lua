return {
	{
		"williamboman/mason.nvim",

		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			-- Setup key maps ------------------------------------

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, noremap = true }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition({
							on_list = function(options)
								vim.fn.setqflist({}, " ", options)
								vim.cmd.cfirst()
								vim.cmd("normal! zz")
							end,
						})
					end, opts)
					vim.keymap.set("n", "H", function()
						vim.lsp.buf.hover({ border = "rounded" })
					end, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set({ "n", "i" }, "<C-g>", function()
						vim.lsp.buf.signature_help({ border = "rounded" })
					end, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					local client = vim.lsp.get_clients({ id = ev.data.client_id })[1]
					if client ~= nil and client.supports_method("textDocument/documentHighlight") then
						local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
						vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = ev.buf })
						vim.api.nvim_create_autocmd("CursorHold", {
							group = highlight_group,
							buffer = ev.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd("CursorMoved", {
							group = highlight_group,
							buffer = ev.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			vim.keymap.set("n", "<space>vd", function()
				vim.diagnostic.open_float({ border = "rounded" })
			end)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = { border = "rounded" } })
			end)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = { border = "rounded" } })
			end)
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- LSP Support
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local util = require("lspconfig.util")

			require("mason-lspconfig").setup({
				auto_install = true,
				ensure_installed = {
					"bashls",
					"lua_ls",
					"dockerls",
					"pyright",
					"ruff",
					"gopls",
					"terraformls",
				},
				handlers = {
					-- default handler for servers without a dedicated one
					function(server_name)
						lspconfig[server_name].setup({
							capabilities = capabilities,
						})
					end,

					["gopls"] = function()
						lspconfig.gopls.setup({
							capabilities = capabilities,
							cmd = { "gopls" },
							filetypes = { "go", "gomod", "gowork", "gotmpl" },
							root_dir = util.root_pattern("go.work", "go.mod", ".git"),
							settings = {
								gopls = {
									completeUnimported = true,
									usePlaceholders = true,
									analyses = {
										unusedparams = true,
									},
									staticcheck = true,
									gofumpt = true,
								},
							},
						})
					end,
					["ruff"] = function()
						lspconfig.ruff.setup({
							capabilities = capabilities,
							on_attach = function(client, _)
								-- Disable hover in favor of pyright
								client.server_capabilities.hoverProvider = false
							end,
						})
					end,
					["lua_ls"] = function()
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = {
										version = "LuaJIT",
									},
									diagnostics = {
										globals = { "vim" },
									},
									telemetry = {
										enable = false,
									},
									hint = {
										enable = true,
										setType = true,
										arrayIndex = "Enable",
									},
								},
							},
						})
					end,
				},
			})
		end,
	},
}
