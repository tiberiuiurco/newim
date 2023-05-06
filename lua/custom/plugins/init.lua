return {
    "tpope/vim-surround", 'tjdevries/gruvbuddy.nvim', "nvim-lua/plenary.nvim",
    "tjdevries/express_line.nvim", "norcalli/nvim-colorizer.lua",
    "tjdevries/colorbuddy.nvim", "Mofiqul/vscode.nvim", "rebelot/kanagawa.nvim",
    {
        "terrortylor/nvim-comment",
        config = function() require('nvim_comment').setup() end
    }

}
