local cmp = require 'cmp'
local lspkind = require('lspkind')

vim.opt.completeopt = {"menu", "menuone", "noselect"}

-- Don't show the dumb matching stuff.
vim.opt.shortmess:append "c"

local lspkind = require("lspkind")
lspkind.init({symbol_map = {Copilot = ""}})

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg = "#6CC644"})

-- Complextras.nvim configuration
vim.api.nvim_set_keymap("i", "<C-x><C-m>",
                        [[<c-r>=luaeval("require('complextras').complete_matching_line()")<CR>]],
                        {noremap = true})

vim.api.nvim_set_keymap("i", "<C-x><C-d>",
                        [[<c-r>=luaeval("require('complextras').complete_line_from_cwd()")<CR>]],
                        {noremap = true})

cmp.setup({
    mapping = {
        ["<C-n>"] = cmp.mapping.select_next_item {
            behavior = cmp.SelectBehavior.Insert
        },
        ["<C-p>"] = cmp.mapping.select_prev_item {
            behavior = cmp.SelectBehavior.Insert
        },
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping {
            i = cmp.mapping.complete(),
            c = function(_ --[[fallback]] )
                if cmp.visible() then
                    if not cmp.confirm {select = true} then
                        return
                    end
                else
                    cmp.complete()
                end
            end
        },
        --    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<tab>"] = cmp.config.disable,
        ["<c-y>"] = cmp.mapping(cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }, {"i", "c"}),
        ["<c-CR>"] = cmp.mapping.confirm({
            -- this is the important line
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        })
    },
    sources = cmp.config.sources({
        {name = 'copilot', keyword_length = 0}, {name = 'nvim_lsp'},
        {name = 'nvim_lua'}, {name = 'luasnip'} -- For luasnip users.
    }, {{name = 'buffer'}}),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end
    },
    sorting = {
        -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
            cmp.config.compare.offset, cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                    return false
                elseif entry1_under < entry2_under then
                    return true
                end
            end, cmp.config.compare.kind, cmp.config.compare.sort_text,
            cmp.config.compare.length, cmp.config.compare.order
        }
    },
    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
                eruby = "[erb]"
            }
        }
    },
    experimental = {
        -- I like the new menu better! Nice work hrsh7th
        native_menu = false,
        -- Let's play with this for a day or two
        ghost_text = false
    }
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({'/', '?'}, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {{name = 'buffer'}}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
})
