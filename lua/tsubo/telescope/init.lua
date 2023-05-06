SHOULD_RELOAD_TELESCOPE = true
local reloader = function()
    if SHOULD_RELOAD_TELESCOPE then
        R "plenary"
        R "telescope"
        R "tj.telescope.setup"
    end
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local themes = require "telescope.themes"

local set_prompt_to_entry_value = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry or not type(entry) == "table" then return end

    action_state.get_current_picker(prompt_bufnr):reset_prompt(entry.ordinal)
end

local M = {}

function M.edit_neovim()
    local opts_with_preview, opts_without_preview

    opts_with_preview = {
        prompt_title = "~ dotfiles ~",
        shorten_path = false,
        cwd = "~/.config/newim",
        layout_strategy = "flex",
        layout_config = {
            width = 0.9,
            height = 0.8,
            horizontal = {width = {padding = 0.15}},
            vertical = {preview_height = 0.75}
        },
        mappings = {i = {["<C-y>"] = false}},
        attach_mappings = function(_, map)
            map("i", "<c-y>", set_prompt_to_entry_value)
            map("i", "<M-c>", function(prompt_bufnr)
                actions.close(prompt_bufnr)
                vim.schedule(function()
                    require("telescope.builtin").find_files(opts_without_preview)
                end)
            end)

            return true
        end
    }

    opts_without_preview = vim.deepcopy(opts_with_preview)
    opts_without_preview.previewer = false

    require("telescope.builtin").find_files(opts_with_preview)
end

function M.git_files()
    local path = vim.fn.expand "%:h"
    if path == "" then path = nil end

    local width = 0.75
    if path and string.find(path, "sourcegraph.*sourcegraph", 1, false) then
        width = 0.5
    end

    local opts = themes.get_dropdown {
        winblend = 5,
        previewer = false,
        shorten_path = false,

        cwd = path,

        layout_config = {width = width}
    }

    require("telescope.builtin").git_files(opts)
end

function M.edit_zsh()
    require("telescope.builtin").find_files {
        shorten_path = false,
        cwd = "~/.config/zsh/",
        prompt = "~ dotfiles ~",
        hidden = true,

        layout_strategy = "horizontal",
        layout_config = {preview_width = 0.55}
    }
end

function M.file_browser()
    local opts

    opts = {
        sorting_strategy = "ascending",
        scroll_strategy = "cycle",
        layout_config = {prompt_position = "top"},
        attach_mappings = function(prompt_bufnr, map)
            local current_picker = action_state.get_current_picker(prompt_bufnr)

            local modify_cwd = function(new_cwd)
                local finder = current_picker.finder

                finder.path = new_cwd
                finder.files = true
                current_picker:refresh(false, {reset_prompt = true})
            end

            map("i", "-", function()
                modify_cwd(current_picker.cwd .. "/..")
            end)

            map("i", "~", function() modify_cwd(vim.fn.expand "~") end)

            -- local modify_depth = function(mod)
            --   return function()
            --     opts.depth = opts.depth + mod
            --
            --     current_picker:refresh(false, { reset_prompt = true })
            --   end
            -- end
            --
            -- map("i", "<M-=>", modify_depth(1))
            -- map("i", "<M-+>", modify_depth(-1))

            map("n", "yy", function()
                local entry = action_state.get_selected_entry()
                vim.fn.setreg("+", entry.value)
            end)

            return true
        end
    }

    require("telescope").extensions.file_browser.file_browser(opts)
end

function M.find_files()
    -- local opts = themes.get_ivy {
    --   hidden = false,
    --   sorting_strategy = "ascending",
    --   layout_config = { height = 9 },
    -- }
    require("telescope.builtin").find_files {
        sorting_strategy = "descending",
        scroll_strategy = "cycle",
        layout_config = {
            -- height = 10,
        }
    }
end

function M.fs()
    local opts = themes.get_ivy {
        hidden = false,
        sorting_strategy = "descending"
    }
    require("telescope.builtin").find_files(opts)
end

function M.curbuf()
    local opts = themes.get_dropdown {
        winblend = 10,
        border = true,
        previewer = false,
        shorten_path = false
    }
    require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.buffers() require("telescope.builtin").buffers {shorten_path = false} end

function M.help_tags()
    require("telescope.builtin").help_tags {show_version = true}
end

function M.vim_options()
    require("telescope.builtin").vim_options {
        layout_config = {width = 0.5},
        sorting_strategy = "ascending"
    }
end

function M.builtin() require("telescope.builtin").builtin() end

return M
