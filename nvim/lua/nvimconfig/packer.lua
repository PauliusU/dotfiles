print("packer.lua")
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Navigation
    -- Telescope - fuzzy finder
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Harpoon - quick file toggle
    use('theprimeagen/harpoon')

    -- Git and edit history
    use('tpope/vim-fugitive')
    use('airblade/vim-gitgutter')
    use('mbbill/undotree')

    -- Syntax highlighting, colors and themes
    -- treesitter - amazingly fast code parsing
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    -- Onedark colorscheme
    use 'navarasu/onedark.nvim'

    -- LSP and completion
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
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

    -- Distraction free coding
    use("folke/zen-mode.nvim")
end)
