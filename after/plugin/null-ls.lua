local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	-- you can reuse a shared lspconfig on_attach callback here
	sources = {
		null_ls.builtins.formatting.prettierd,
		null_ls.builtins.formatting.lua_format
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			--     group = augroup,
			--     buffer = bufnr,
			--     callback = function()
			--         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
			--         vim.lsp.buf.format()
			--     end
			-- })
		end
	end
})
