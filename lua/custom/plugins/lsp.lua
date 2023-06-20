return {
	{ "neovim/nvim-lspconfig", config = function() require "tsubo.lsp" end },
	"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
	"folke/neodev.nvim", "jose-elias-alvarez/null-ls.nvim",
	{ "j-hui/fidget.nvim", tag = "legacy", config = function()
		require("fidget").setup {
			text = {
				spinner = "moon",
			},
			align = {
				bottom = true,
			},
			window = {
				relative = "editor",
			},
		}
	end }
}
