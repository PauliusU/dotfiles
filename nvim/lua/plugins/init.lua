return {
    -- Navigation and fuzzy finding
    { -- Telescope - fuzzy finder
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    -- Harpoon - quick file toggle
    'theprimeagen/harpoon',
    { -- Nvim-tree - a file explorer written in LUA
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    },

    -- Git and edit history
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim', -- Show which lines are currently changed
    "sindrets/diffview.nvim",  -- View git diffs
    'mbbill/undotree',

    -- Comments, "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    -- Syntax highlighting
    -- treesitter - amazingly fast code parsing
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- Show the context of the currently visible buffer contents (a.k.a sticky scrolling)
    'nvim-treesitter/nvim-treesitter-context',
    -- Highlight and search for todo comments like TODO, HACK, BUG
    { "folke/todo-comments.nvim",        dependencies = "nvim-lua/plenary.nvim" },

    -- Theme and colors
    'navarasu/onedark.nvim',      -- Onedark colorscheme
    'xiyaowong/transparent.nvim', -- Make any colorscheme transparent

    -- UI
    "folke/zen-mode.nvim",           -- Distraction free coding
    {
        'nvim-lualine/lualine.nvim', -- Fancier statusline
        dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
    },

    -- LSP and completion
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            -- LSP Configuration & Plugins
            { 'neovim/nvim-lspconfig' },
            -- Automatically install LSPs to stdpath
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    },
    { -- Automatically add closing pair characters for (, {, ", ', etc.
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    { 'windwp/nvim-ts-autotag' },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            print('Copilot started')
            require("copilot").setup({
                suggestion = {
                    auto_trigger = true,
                    keymap = {
                        next = "<C-h>",
                        prev = "<C-l>",
                    }
                },
            })

            vim.keymap.set('n', '<leader>cp', '<cmd>Copilot enable<cr>', { desc = 'Enable GitHub [C]o[p]ilot' })
            vim.keymap.set('n', '<leader>cs', '<cmd>Copilot status<cr>', { desc = 'Print GitHub [C]opilot [s]tatus' })
        end,
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function()
            require("copilot_cmp").setup()
        end
    },

    -- Debugging
    'mfussenegger/nvim-dap',
    { "rcarriga/nvim-dap-ui",      dependencies = { "mfussenegger/nvim-dap" } },
    { "mxsdev/nvim-dap-vscode-js", dependencies = { "mfussenegger/nvim-dap" } },

    -- Running code
    { 'CRAG666/code_runner.nvim',  dependencies = 'nvim-lua/plenary.nvim' },

    -- Keyboard shortcuts help by showing pending keybinds
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end
    },

    -- Sandbox (testing to include in the main config)
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    },
    'tpope/vim-surround',
    {
        "m4xshen/hardtime.nvim", -- establish good neovim habits
        dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" }
    }
}
