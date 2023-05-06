return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {"tpope/vim-dadbod"},
    config = function()
        vim.g.dbs = {
            {name = 'Licenta', url = "mysql://root@192.168.0.195/management"}
        }
    end
}
