return {
    {
        "nvim-telescope/telescope.nvim",
        priority = 100,
        config = function()
            require "tsubo.telescope.setup"
            require "tsubo.telescope.keys"
        end
    }, "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-hop.nvim", "nvim-tree/nvim-web-devicons"
}
