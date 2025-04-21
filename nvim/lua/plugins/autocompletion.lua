-- Autocompletion
return {
    {
        'hrsh7th/nvim-cmp',    -- Completion engine
        event = "InsertEnter", -- Load cmp on InsertEnter
        -- these dependencies will only be loaded when cmp loads
        -- dependencies are always lazy-loaded unless specified otherwise
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },                -- LSP completion source
            { 'hrsh7th/cmp-buffer' },                  -- Suggest words found in the current buffer
            { 'hrsh7th/cmp-path' },                    -- Autocomplete file paths
            { 'hrsh7th/cmp-nvim-lua' },                -- Autocomplete Neovim's Lua runtime API
            { 'hrsh7th/cmp-nvim-lsp-signature-help' }, -- Display function signatures with the current parameter emphasized

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },     -- Luasnip source for autocomplete
            -- Snippets sandbox
            { 'rafamadriz/friendly-snippets' }, -- Adds a number of user-friendly snippets

        },
        config = function()
            require('plugins.lsp')
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        event = "InsertEnter",
        config = function()
            -- Check if the plugin is loaded correctly with :LuaSnipListAvailable
            require('snippets.luasnip')
        end,
    },
    { -- Automatically add closing pair characters for (, {, ", ', etc.
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        -- Autotag
        -- For React apps, you often want to close tags quickly. windwp/nvim-ts-autotag is exactly what you want.
        'windwp/nvim-ts-autotag',
        event = "InsertEnter",
        ft = { "html", "javascript", "javascriptreact", "typescriptreact", "svelte", "vue" },
        config = function()
            require('nvim-ts-autotag').setup()
        end
    },
    {
        "zbirenbaum/copilot.lua",
        desc = "GitHub Copilot. Run ':Copilot auth' to get started.",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        next = "<C-h>",
                        prev = "<C-l>",
                    }
                },
                filetypes = {
                    yaml = true,
                    markdown = true,
                    gitcommit = true,
                }
            })

            vim.keymap.set('n', '<leader>cp', '<cmd>Copilot enable<cr>', { desc = 'Enable GitHub [C]o[p]ilot' })
            vim.keymap.set('n', '<leader>cs', '<cmd>Copilot status<cr>', { desc = 'Print GitHub [C]opilot [s]tatus' })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = function()
            require("copilot_cmp").setup()
        end
    },
}
