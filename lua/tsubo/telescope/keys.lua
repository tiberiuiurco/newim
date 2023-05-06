local builtin = require('telescope.builtin')

local sorters = require "telescope.sorters"
local map_tele = require "tsubo.telescope.mappings"

-- Dotfiles
map_tele("<leader>en", "edit_neovim")
map_tele("<leader>ez", "edit_zsh")

-- Files
map_tele("<leader>ft", "git_files")
map_tele("<leader>o", "find_files")
vim.api.nvim_set_keymap("n", "<space>fe",
                        ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
                        {noremap = true})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

--
map_tele("<leader>fq", "fs")
map_tele("<leader>fp", "projects")

-- Nvim
map_tele("<space>fb", "buffers")
map_tele("<space>ff", "curbuf")
map_tele("<space>fh", "help_tags")
map_tele("<space>bo", "vim_options")

-- Telescope Meta
map_tele("<space>fB", "builtin")
