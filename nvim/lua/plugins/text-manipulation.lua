return {
    {
        'Wansmer/treesj',
        desc = 'splitting/joining blocks of code like arrays, hashes, statements, objects, dictionaries, etc.',
        keys = {
            { 'M',          ':TSJToggle<cr>',   desc = ":TSJToggle" },
            { '<C-g>',      ':TSJToggle<cr>',   desc = ":TSJToggle" },
            { '<leader>m',  desc = ":TSJToggle" },
            { '<leader>j',  desc = ":TSJoin" },
            { '<leader>qs', ':TSJSplit<cr>',    desc = ':TSJSplit' },
        },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                langs = {
                    -- lua = require('treesj.langs.lua'),
                    -- typescript = require('treesj.langs.typescript'),
                    -- javascript = require('treesj.langs.javascript'),
                    -- python = require('treesj.langs.python'),
                    -- rust = require('treesj.langs.rust'),
                    -- go = require('treesj.langs.go'),
                    -- c = require('treesj.langs.c'),
                    -- cpp = require('treesj.langs.cpp'),
                }
            })

            -- -- For use default preset and it work with dot
            -- vim.keymap.set('n', '<leader>m', require('treesj').toggle)
            -- -- For extending default preset with `recursive = true`, but this doesn't work with dot
            -- vim.keymap.set('n', '<leader>M', function()
            --     require('treesj').toggle({ split = { recursive = true } })
            -- end)
        end,
    },
    {
        -- ❗DISABLED plugin (to test nvim-surround)
        -- surround.vim
        'tpope/vim-surround',
        enabled = false,
        desc = 'Control "surroundings": parentheses, brackets, quotes, XML tags, and more.'
        -- Surround word with single quotes: ysiw'
    },
    {
        "kylechui/nvim-surround",
        -- csqb - replaces the nearest set of quotes with parentheses
        version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
}
