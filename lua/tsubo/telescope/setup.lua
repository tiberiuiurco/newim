local telescope = require('telescope')
local actions = require('telescope.actions')
local fb_actions = require('telescope').extensions.file_browser.actions

require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				-- ["<C-h>"] = "which_key",
				-- IMPORTANT
				-- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
				["<C-h>"] = R("telescope").extensions.hop.hop, -- hop.hop_toggle_selection
				-- custom hop loop to multi selects and sending selected entries to quickfix list
				["<C-space>"] = function(prompt_bufnr)
					local opts = {
						callback = actions.toggle_selection,
						loop_callback = actions.send_selected_to_qflist
					}
					require("telescope").extensions.hop._hop_loop(prompt_bufnr,
						opts)
				end
			},
			n = { ["l"] = actions.select_default }
		}
	},
	pickers = {},
	extensions = {
		file_browser = {
			theme = "ivy",
			hijack_netrw = true,
			mappings = {
				theme = "dropdown",
				-- disables netrw and use telescope-file-browser in its place
				hijack_netrw = true,
				mappings = {
					-- your custom insert mode mappings
					["i"] = { ["<C-w>"] = function()
						vim.cmd('normal vbd')
					end },
					["n"] = {
						-- your custom normal mode mappings
						["N"] = fb_actions.create,
						["h"] = fb_actions.goto_parent_dir,
						--                    ["l"] = fb_actions.select_default,
						["/"] = function()
							vim.cmd('startinsert')
						end
					}
				}
			}
		},
		hop = {
			-- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
			keys = {
				"a", "s", "d", "f", "g", "h", "j", "k", "l", ";", "q", "w", "e",
				"r", "t", "y", "u", "i", "o", "p", "A", "S", "D", "F", "G", "H",
				"J", "K", "L", ":", "Q", "W", "E", "R", "T", "Y", "U", "I", "O",
				"P"
			},
			-- Highlight groups to link to signs and lines; the below configuration refers to demo
			-- sign_hl typically only defines foreground to possibly be combined with line_hl
			sign_hl = { "WarningMsg", "Title" },
			-- optional, typically a table of two highlight groups that are alternated between
			line_hl = { "CursorLine", "Normal" },
			-- options specific to `hop_loop`
			-- true temporarily disables Telescope selection highlighting
			clear_selection_hl = false,
			-- highlight hopped to entry with telescope selection highlight
			-- note: mutually exclusive with `clear_selection_hl`
			trace_entry = true,
			-- jump to entry where hoop loop was started from
			reset_selection = true
		}
	}
}

_ = require("telescope").load_extension "file_browser"
_ = require("telescope").load_extension "hop"
