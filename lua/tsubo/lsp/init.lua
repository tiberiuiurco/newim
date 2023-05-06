local neodev = vim.F.npcall(require, "neodev")
if neodev then
	neodev.setup {
		override = function(_, library)
			library.enabled = true
			library.plugins = true
		end,
	}
end

local lspconfig = vim.F.npcall(require, "lspconfig")
if not lspconfig then
	return
end

local is_mac = vim.fn.has "macunix" == 1

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
		bufopts)
	vim.keymap.set('n', '<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<leader>f',
		function() vim.lsp.buf.format { async = true } end, bufopts)
end

require('lspkind').init({
	-- DEPRECATED (use mode instead): enables text annotations
	--
	-- default: true
	-- with_text = true,

	-- defines how annotations are shown
	-- default: symbol
	-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	mode = 'symbol_text',
	-- default symbol map
	-- can be either 'default' (requires nerd-fonts font) or
	-- 'codicons' for codicon preset (requires vscode-codicons font)
	--
	-- default: 'default'
	preset = 'codicons',
	-- override preset symbols
	--
	-- default: {}
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "ﰠ",
		Variable = "",
		Class = "ﴯ",
		Interface = "",
		Module = "",
		Property = "ﰠ",
		Unit = "塞",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "פּ",
		Event = "",
		Operator = "",
		TypeParameter = ""
	}
})

require('lspconfig')['lua_ls'].setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = {
					-- Vim
					'vim', -- Busted
					"describe", "it", "before_each", "after_each", "teardown",
					"pending", "clear", -- Colorbuddy
					"Color", "c", "Group", "g", "s", -- Custom
					"RELOAD"
				}
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true)
			}
		}
	}
}
require('lspconfig')['tsserver'].setup {
	capabilities = capabilities,
	on_attach = on_attach
}
require('lspconfig')['clangd'].setup {
	capabilities = capabilities,
	on_attach = on_attach
}
require 'lspconfig'.rust_analyzer.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"rustup", "run", "stable", "rust-analyzer",
	}
}
-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require 'lspconfig'.html.setup { capabilities = capabilities }

-- ANGULARLS
-- local project_library_path =
--     "/home/tsubo/.config/nvm/versions/node/v19.8.1/lib/node_modules/@angular/language-server/"
-- local cmd = {
--     "ngserver", "--stdio", "--tsProbeLocations", project_library_path,
--     "--ngProbeLocations", project_library_path
-- }
--
-- require'lspconfig'.angularls.setup {
--     cmd = cmd,
--     on_new_config = function(new_config, new_root_dir) new_config.cmd = cmd end
-- }
require('lspconfig')['angularls'].setup({
	capabilities = capabilities,
	on_attach = on_attach
})

-- MASON + Sumneko_lua
require("mason").setup()
require("mason-lspconfig").setup {}

require("colorbuddy").colorscheme("gruvbuddy")
