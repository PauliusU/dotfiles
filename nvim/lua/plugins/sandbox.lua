-- Sandbox - plugins for testing. Not yet part of the main config
return {
    {
        -- surround.vim
        -- Control "surroundings": parentheses, brackets, quotes, XML tags, and more.
        'tpope/vim-surround'
    },
    {
        -- hardtime.nvim - establish good neovim habits
        "m4xshen/hardtime.nvim", -- establish good neovim habits
        dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" },
        config = function()
            require("hardtime").setup({
                restricted_keys = {
                    -- Override default { "n", "x" } to allow keys in normal mode
                    ["j"] = { "x" },
                    ["k"] = { "x" },
                    ["<C-P>"] = { "x" },
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

            vim.keymap.set("", "<Leader>lk", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
        end,
    },
    {
        -- Add indentation guides even on blank lines
        'lukas-reineke/indent-blankline.nvim',
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
    { -- Auto convert strings to py f-strings or js template strings and back
        "chrisgrieser/nvim-puppeteer",
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
        --  splitting/joining blocks of code like arrays, hashes, statements, objects, dictionaries, etc.
        'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({ --[[ your config ]] })

            -- -- For use default preset and it work with dot
            -- vim.keymap.set('n', '<leader>m', require('treesj').toggle)
            -- -- For extending default preset with `recursive = true`, but this doesn't work with dot
            -- vim.keymap.set('n', '<leader>M', function()
            --     require('treesj').toggle({ split = { recursive = true } })
            -- end)
        end,
    },
    {
        "monaqa/dial.nvim",
        -- lazy-load on keys
        -- mode is `n` by default. For more advanced options, check the section on key mappings
        keys = { "<C-a>", { "<C-x>", mode = "n" } },
    },
    { -- Replaces the UI for messages, cmdline and the popupmenu.
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
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
        }
    },
    {
        -- Neovim setup for init.lua and plugin development with full
        -- signature help, docs and completion for the nvim lua API.
        "folke/neodev.nvim",
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
        },
    },
}
