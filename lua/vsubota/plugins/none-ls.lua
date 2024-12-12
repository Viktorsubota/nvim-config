-- Function to check if a file exists
local function file_exists(file_path)
	local file = io.open(file_path, "r")
	if file then
		io.close(file)
		return true
	else
		return false
	end
end

-- Function to find .pylintrc in Git root
local function find_pylintrc_in_git_root()
	local git_root_cmd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]

	if git_root_cmd ~= "" then
		local git_root = vim.fn.trim(git_root_cmd)
		local pylintrc_path = git_root .. "/.pylintrc"

		return file_exists(pylintrc_path) and pylintrc_path or nil
	else
		return nil
	end
end

return {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			local mason_null_ls = require("mason-null-ls")

			mason_null_ls.setup({
				ensure_installed = {
					"prettier", -- prettier formatter
					"stylua", -- lua formatter

					"black", -- python formatter
					"pylint", -- python linter
					"debugpy",
					"isort",
					"ruff",

					"gopls",
					"gofmt",
					"goimports",
					"golines",
					"delve",
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim", -- configure formatters & linters
		event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			local null_ls_utils = require("null-ls.utils")

			local formatting = null_ls.builtins.formatting -- to setup formatters
			local diagnostics = null_ls.builtins.diagnostics -- to setup linters

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({

				debug = true,
				autostart = true,

				-- add package.json as identifier for root (for typescript monorepos)
				root_dir = null_ls_utils.root_pattern("pyproject.toml", ".null-ls-root", "Makefile", ".git", "go.mod"),
				-- setup formatters & linters
				sources = {
					--  to disable file types use
					--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)

					formatting.stylua, -- lua formatter

					formatting.isort,
					formatting.black.with({
						extra_args = { "--line-length", "100" },
					}),
					diagnostics.pylint.with({
						extra_args = { "--rcfile", find_pylintrc_in_git_root() or "" },
					}),

					formatting.gofmt,
					formatting.goimports,
					formatting.golines,
				},

				-- configure format on save
				on_attach = function(current_client, bufnr)
					if current_client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									filter = function(client)
										--  only use null-ls for formatting instead of lsp server
										return client.name == "null-ls"
									end,
									bufnr = bufnr,
								})
							end,
						})
					end
				end,
			})
		end,
	},
}
