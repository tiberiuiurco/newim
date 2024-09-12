if not pcall(require, "nvim-treesitter") then return end

-- alt+<space>, alt+p -> swap next
-- alt+<backspace>, alt+p -> swap previous
-- swap_previous = {
--   ["<M-s><M-P>"] = "@parameter.inner",
--   ["<M-s><M-F>"] = "@function.outer",
-- },

local list = require("nvim-treesitter.parsers").get_parser_configs()
list.lua = {
    install_info = {
        url = "https://github.com/tjdevries/tree-sitter-lua",
        revision = "0e860f697901c9b610104eb61d3812755d5211fc",
        files = {"src/parser.c", "src/scanner.c"},
        branch = "master"
    }
}

local swap_next, swap_prev = (function()
    local swap_objects = {
        p = "@parameter.inner",
        f = "@function.outer",
        e = "@element"
        -- Not ready, but I think it's my fault :)
        -- v = "@variable",
    }

    local n, p = {}, {}
    for key, obj in pairs(swap_objects) do
        n[string.format("<M-Space><M-%s>", key)] = obj
        p[string.format("<M-BS><M-%s>", key)] = obj
    end

    return n, p
end)()

local _ = require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "go", "html", "javascript", "json", "markdown", "ocaml", "python",
        "query", "rust", "toml", "tsx", "typescript", "vim", "org"
    },

    -- highlight = {enable = true},

    refactor = {
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = false},
        smart_rename = {
            enable = false,
            keymaps = {
                -- mapping to rename reference under cursor
                smart_rename = "grr"
            }
        },
        navigation = {
            enable = false,
            keymaps = {
                goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
                list_definitions = "gnD" -- mapping to list all definitions in current file
            }
        }
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
            node_incremental = "<M-w>", -- increment to the upper named parent
            node_decremental = "<M-C-w>", -- decrement to the previous node
            scope_incremental = "<M-e>" -- increment to the upper scope (as defined in locals.scm)
        }
    },

    textobjects = {
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["]p"] = "@parameter.inner",
                ["]m"] = "@function.outer",
                ["]]"] = "@class.outer"
            },
            goto_next_end = {
                ["]M"] = "@function.outer",
                ["]["] = "@class.outer"
            },
            goto_previous_start = {
                ["[p"] = "@parameter.inner",
                ["[m"] = "@function.outer",
                ["[["] = "@class.outer"
            },
            goto_previous_end = {
                ["[M"] = "@function.outer",
                ["[]"] = "@class.outer"
            }
        },
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@conditional.outer",
                ["ic"] = "@conditional.inner",
                ["aa"] = "@parameter.outer",
                ["ia"] = "@parameter.inner",
                ["av"] = "@variable.outer",
                ["iv"] = "@variable.inner"
            }
        },
        swap = {enable = true, swap_next = swap_next, swap_previous = swap_prev}
    },

		-- rainbow = {
		-- 	enable = true,
		-- 	-- list of languages you want to disable the plugin for
		-- 	disable = { 'jsx', 'cpp' },
		-- 	-- Which query to use for finding delimiters
		-- 	query = 'rainbow-parens',
		-- 	-- Highlight the entire buffer all at once
		-- 	strategy = require('ts-rainbow').strategy.global,
		-- }
}

require'treesitter-context'.setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20 -- The Z-index of the context window
}
-- vim.treesitter.query.set("lua", "context", "")

local read_query = function(filename)
    return table.concat(vim.fn.readfile(vim.fn.expand(filename)), "\n")
end

-- Overrides any existing tree sitter query for a particular name
-- vim.treesitter.set_query("rust", "highlights", read_query "~/.config/nvim/queries/rust/highlights.scm")
-- vim.treesitter.set_query("sql", "highlights", read_query "~/.config/nvim/queries/sql/highlights.scm")

vim.cmd [[highlight IncludedC guibg=#373b41]]

vim.cmd [[nnoremap <space>th :TSHighlightCapturesUnderCursor<CR>]]
