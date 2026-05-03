return {
	{
		"mason-org/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate" },
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"mason-org/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lsp_winhighlight = "Normal:LspFloatNormal,FloatBorder:LspFloatBorder"

			-- Style diagnostic floats globally; default [d/]d open the float on jump
			vim.diagnostic.config({
				float = { winhighlight = lsp_winhighlight },
				jump = { float = true },
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local map = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, noremap = true })
					end

					-- Drop nvim 0.11+ defaults that share the gr prefix and cause gr/gi/gd timeoutlen lag
					for _, lhs in ipairs({ "grr", "grn", "gri", "gra", "grt", "grx" }) do
						pcall(vim.keymap.del, "n", lhs)
					end

					-- IDE-conventional nav (Snacks pickers — auto-jump on single, picker on multiple, tagstack-aware)
					map("n", "gd", function() Snacks.picker.lsp_definitions() end)
					map("n", "gD", vim.lsp.buf.declaration)
					map("n", "gr", function() Snacks.picker.lsp_references() end)
					map("n", "gi", function() Snacks.picker.lsp_implementations() end)
					map("n", "gO", function() Snacks.picker.lsp_symbols() end)
					map("n", "K", function()
						vim.lsp.buf.hover({ winhighlight = lsp_winhighlight })
					end)
					-- <C-s> is the 0.11+ default but tmux owns it; keep <C-g>
					map({ "n", "i" }, "<C-g>", function()
						vim.lsp.buf.signature_help({ winhighlight = lsp_winhighlight })
					end)

					-- Code actions / rename / diagnostic float / codelens
					map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action)
					map("n", "<leader>rn", vim.lsp.buf.rename)
					map("n", "<leader>cd", vim.diagnostic.open_float)
					map("n", "<leader>cl", vim.lsp.codelens.run)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- Auto-refresh codelens (gopls test runners, rust-analyzer Run/Debug, etc.)
					if client and client:supports_method("textDocument/codeLens") then
						local codelens_group = vim.api.nvim_create_augroup("lsp_codelens_refresh", { clear = false })
						vim.api.nvim_clear_autocmds({ group = codelens_group, buffer = ev.buf })
						vim.lsp.codelens.refresh({ bufnr = ev.buf })
						vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
							group = codelens_group,
							buffer = ev.buf,
							callback = function()
								vim.lsp.codelens.refresh({ bufnr = ev.buf })
							end,
						})
					end

					if client and client:supports_method("textDocument/documentHighlight") then
						local highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
						vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = ev.buf })
						vim.api.nvim_create_autocmd("CursorHold", {
							group = highlight_group,
							buffer = ev.buf,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter" }, {
							group = highlight_group,
							buffer = ev.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- Apply nvim-cmp capabilities to every server
			vim.lsp.config("*", {
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
			})

			vim.lsp.config("gopls", {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_markers = { "go.work", "go.mod", ".git" },
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
						analyses = { unusedparams = true },
						staticcheck = true,
						gofumpt = true,
						codelenses = {
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true, -- "run test" / "run benchmark" above test funcs
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
					},
				},
			})

			vim.lsp.config("ruff", {
				on_attach = function(client, _)
					-- defer hover to pyright
					client.server_capabilities.hoverProvider = false
				end,
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
						hint = {
							enable = true,
							setType = true,
							arrayIndex = "Enable",
						},
					},
				},
			})

			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"dockerls",
					"gopls",
					"jsonls",
					"lua_ls",
					"marksman",
					"pyright",
					"ruff",
					"terraformls",
					"ts_ls",
					"yamlls",
				},
				automatic_enable = true,
			})
		end,
	},
}
