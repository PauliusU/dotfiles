print("packer.lua")
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Navigation and fuzzy finding
    -- Telescope - fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Harpoon - quick file toggle
    use('theprimeagen/harpoon')
    -- Nvim-tree - a file explorer written in LUA
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    -- Git and edit history
    use('tpope/vim-fugitive')
    use('airblade/vim-gitgutter')
    use('mbbill/undotree')

    -- Syntax highlighting
    -- treesitter - amazingly fast code parsing
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    -- Onedark colorscheme
    use 'navarasu/onedark.nvim'

    -- LSP and completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
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
    }

    -- Comments
    use "terrortylor/nvim-comment"

    -- Running code
    use { 'CRAG666/code_runner.nvim', requires = 'nvim-lua/plenary.nvim' }

    -- Keyboard shortcuts help by showing pending keybinds
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {}
        end
    }

    -- Distraction free coding
    use("folke/zen-mode.nvim")
end)
