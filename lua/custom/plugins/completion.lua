return {
    {"hrsh7th/nvim-cmp"}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-nvim-lua"},
    {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"}, {"onsails/lspkind-nvim"},
    {"L3MON4D3/LuaSnip", config = function() require("tsubo.snips") end},
    {"saadparwaiz1/cmp_luasnip", dependencies = {"L3MON4D3/LuaSnip"}},
    {"rafamadriz/friendly-snippets"}, {"tamago324/cmp-zsh"}
}
