-- Automatically install packer
local ensure_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

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

    -- Comments, "gc" to comment visual regions/lines
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Syntax highlighting
    -- treesitter - amazingly fast code parsing
    use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
    -- Show the context of the currently visible buffer contents (a.k.a sticky scrolling)
    use 'nvim-treesitter/nvim-treesitter-context'
    -- Highlight and search for todo comments like TODO, HACK, BUG
    use { "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" }

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
    -- Automatically add closing pair characters for (, {, ", ', etc.
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use { 'github/copilot.vim' }

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

    -- Debugging
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    -- Distraction free coding
    use("folke/zen-mode.nvim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)
