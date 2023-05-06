-- vim.cmd[[colorscheme tokyonight]]
-- if not pcall(require, "tokyonight-night") then
--   return
-- end
vim.opt.termguicolors = true

rawset(require("colorbuddy").styles, "italic", require("colorbuddy").styles.none)

require("colorbuddy").colorscheme("kanagawa")

-- require("colorbuddy").colorscheme("vscode")
require("colorizer").setup()
local Color = require('colorbuddy').Color

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

-- Colors
Group.new("LineNr", c.yellow, nil, s.bold)
Group.new("LineNrAbove", c.gray, nil, nil)
Group.new("LineNrBelow", c.gray, nil, nil)

Group.new("StatusLine", nil, c.black:light():light())
Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

-- I don't think I like highlights for text
Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
Group.new("LspReferenceWrite", nil, c.gray0:light(), nil)

Group.new("TSKeyword", c.purple, nil, s.underline, c.blue)
Group.new("LuaFunctionCall", c.green, nil, s.underline + s.nocombine,
          g.TSKeyword.guisp)
Group.new("TSTitle", c.blue)

Group.new("LspParameter", nil, nil, s.italic)
Group.new("LspDeprecated", nil, nil, s.strikethrough)

-- GIT
Group.new("GitSignsAdd", c.green, nil)
Group.new("GitSignsChange", c.blue, nil)
Group.new("GitSignsDelete", c.red, nil)

-- Treesitter Context
Group.new("TreesitterContext", nil, g.Normal.bg:light())
Group.new("TreesitterContextLineNumber", c.blue, nil, s.bold)

Group.new("markdownBold", g.Normal.fg:dark(), nil, s.bold)

-- Window Layout
-- vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
Group.new("WinSeparator", nil, nil)

-- Markdown
-- Group.new("markdownH1", c.green, c.green, s.bold)
-- Group.new("htmlBold", nil, nil, s.bold)
