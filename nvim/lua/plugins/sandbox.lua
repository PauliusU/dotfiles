-- Sandbox - plugins for testing. Not yet part of the main config
return {
    {
        -- surround.vim
        'tpope/vim-surround',
        desc = 'Control "surroundings": parentheses, brackets, quotes, XML tags, and more.'
        -- Surround word with single quotes: ysiw'
    },
    {
        "m4xshen/hardtime.nvim",
        desc = "hardtime.nvim - establish good neovim habits",
        dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" },
        config = function()
            require("hardtime").setup({
                restricted_keys = {
                    -- Override default { "n", "x" } to allow keys in normal mode
                    ["j"] = { "x" },
                    ["k"] = { "x" },
                    ["<C-P>"] = { "x" },
                },
                disabled_keys = {
                    ["<Left>"] = {},
                    ["<Right>"] = {},
                },
            })
        end
    },
    {
        'bennypowers/nvim-regexplainer',
        config = function() require 'regexplainer'.setup() end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'MunifTanjim/nui.nvim',
        }
    },
    {
        'kosayoda/nvim-lightbulb',
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true }
            })
        end
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()

            -- Show virtual lines only for the current line's diagnostics:
            vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

            -- TODO: test. If you don't want to highlight the entire diagnostic line, use:
            -- vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false } })

            vim.keymap.set("", "<leader>lk", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        desc = 'Add indentation guides even on blank lines',
        main = "ibl",
        opts = {
            indent = {
                char = '┊',
                -- char = '|',
                -- highlight = hl_name_list,
                -- show_trailing_blankline_indent = false,
            },
        },
    },
    {
        'RRethy/vim-illuminate'
    },
    {
        "chrisgrieser/nvim-puppeteer",
        desc = "Auto convert strings to py f-strings or js template strings and back",
        dependencies = "nvim-treesitter/nvim-treesitter",
        lazy = false, -- plugin lazy-loads itself
    },
    {
        "dstein64/vim-startuptime",
        -- lazy-load on a command
        cmd = "StartupTime",
        -- init is called during startup. Configuration for vim plugins typically should be set in an init function
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
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
        "folke/noice.nvim",
        desc = "Replaces the UI for messages, cmdline and the popupmenu",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },
    {
        "rcarriga/nvim-notify",
        lazy = true,
    },
    {
        "folke/neodev.nvim",
        desc = "Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.",
        opts = {}
    },
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
            { "<C-A-r>",    function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            -- left empty to use the default settings
            vim.keymap.set("n", "<leader>xt", function() require("trouble").toggle() end, { desc = "Trouble toggle" }),
            vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
                { desc = "Trouble toggle workspace_diagnostics" }),
            vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
                { desc = "Trouble toggle document_diagnostics" }),
            vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end,
                { desc = "Trouble quickfix" }),
            vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end,
                { desc = "Trouble loclist" }),
            vim.keymap.set("n", "gR", function() require("trouble").toggle("lsp_references") end,
                { desc = "Trouble lsp_references" }),
        },
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        -- keys = {
        --     { "<leader>rf", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "ToggleTerm: send current line" },
        --     { "<C-`>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm: send current line" },
        -- },
        opts = {
            vim.keymap.set("n", "<leader>rr", "<cmd>ToggleTermSendCurrentLine<cr>",
                { desc = "ToggleTerm: send current line (and run)" }),
            vim.keymap.set({ "n", "t" }, "<M-C-x>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
        }
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        --- @type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
            {
                "<C-t>",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc = "Treesitter Search",
            },
            {
                "<c-a>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        -- config = true,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
        config = function()
            require('neogen').setup({ enabled = true })
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
            vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
        end
    },
    {
        "zeioth/garbage-day.nvim",
        dependencies = "neovim/nvim-lspconfig",
        event = "VeryLazy",
        opts = {
            notifications = true,
        }
    },
    {
        'echasnovski/mini.ai',
        -- 'cit', 'cat', 'vit' - to change HTML tags
        -- 'cio', 'cao' - to change
        desc = 'Extend and create a/i textobjects',
        version = false, -- use 'main' branch and the latest commit (as opposed to 'stable', branch)
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        'rust-lang/rust.vim',
        desc = 'Rust - automatic formatting on save',
        ft = 'rust',
        init = function()
            vim.g.rustfmt_autosave = 1
            -- vim.g.rustfmt_fail_silently = 1
        end
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            heading = {
                icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            }
        },
    }
}
