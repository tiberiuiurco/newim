vim.g.mapleader = " "
vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.laststatus = 3

-- Keybindings
vim.api.nvim_set_keymap("n", "y", '"+y', {noremap = true})
vim.api.nvim_set_keymap("v", "y", '"+y', {noremap = true})
vim.api.nvim_set_keymap("n", "p", '"+p', {noremap = true})
vim.api.nvim_set_keymap("v", "p", '"+p', {noremap = true})

vim.api.nvim_set_keymap("n", "dd", '"_dd', {noremap = true})
vim.api.nvim_set_keymap("v", "dd", '"_dd', {noremap = true})

-- Bind change to discard the content
vim.api.nvim_set_keymap("n", "c", '"_c', {noremap = true})
vim.api.nvim_set_keymap("v", "c", '"_c', {noremap = true})
