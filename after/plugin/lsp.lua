local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"lua_ls",
	"jsonls",
	"yamlls",
	"pyright",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

require("lspconfig").pyright.setup({})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = true }
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)

    vim.keymap.set("n", "gD", function()
        vim.lsp.buf.declaration()
    end, opts)

    opts.desc = "Show LSP references"
    vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "ga", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "gi", function()
        vim.lsp.buf.implementation()
    end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "<leader>wa", function()
		vim.lsp.buf.add_workspace_folder()
	end, opts)
	vim.keymap.set("n", "<leader>wr", function()
		vim.lsp.buf.remove_workspace_folder()
	end, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>D", function()
		vim.lsp.buf.type_definition()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<leader>e", function()
		vim.lsp.diagnostic.show_line_diagnostics()
	end, opts)
	vim.keymap.set("n", "<leader>q", function()
		vim.lsp.diagnostic.set_loclist()
	end, opts)
	-- Set autocommands conditional on server_capabilities
	vim.api.nvim_exec(
		[[
    hi LspReferenceRead cterm=bold ctermbg=135 guibg=#463e59
    hi LspReferenceText cterm=bold ctermbg=135 guibg=#463e59
    hi LspReferenceWrite cterm=bold ctermbg=135 guibg=#463e59
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
		false
	)
end

lsp.on_attach(on_attach)

lsp.setup()

-- cmp setup

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "",
	Operator = "",
	TypeParameter = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		-- ["<CR>"] = cmp.mapping.confirm { select = true },
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		--   if cmp.visible() then
		--     cmp.select_next_item()
		--   elseif luasnip.expandable() then
		--     luasnip.expand()
		--   elseif luasnip.expand_or_jumpable() then
		--     luasnip.expand_or_jump()
		--   elseif check_backspace() then
		--     fallback()
		--   else
		--     fallback()
		--   end
		-- end, {
		--   "i",
		--   "s",
		-- }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		--   if cmp.visible() then
		--     cmp.select_prev_item()
		--   elseif luasnip.jumpable(-1) then
		--     luasnip.jump(-1)
		--   else
		--     fallback()
		--   end
		-- end, {
		--   "i",
		--   "s",
		-- }),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", max_item_count = 20 },
		{ name = "nvim_lua" },
		{ name = "buffer", Keyword_length = 3, max_item_count = 10 },
		{ name = "luasnip" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = cmp.config.window.bordered(),
		width = 10,
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})

vim.diagnostic.config({
	virtual_text = true,
})

local mason_null_ls = require("mason-null-ls")

local null_ls = require("null-ls")

local null_ls_utils = require("null-ls.utils")

mason_null_ls.setup({
	ensure_installed = {
		"prettier", -- prettier formatter
		"stylua", -- lua formatter
		"black", -- python formatter
		"pylint", -- python linter
		"debugpy",
	},
})

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- add package.json as identifier for root (for typescript monorepos)
	root_dir = null_ls_utils.root_pattern("pyproject.toml", ".null-ls-root", "Makefile", ".git", "go.mod"),
	-- setup formatters & linters
	sources = {
		--  to disable file types use
		--  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
		formatting.stylua, -- lua formatter
		formatting.isort,
		formatting.black,
		diagnostics.pylint,
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Your capabilities setup logic

-- LSP configuration for yamlls with specific settings
require("lspconfig").yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemas = {},
		},
	},
})
