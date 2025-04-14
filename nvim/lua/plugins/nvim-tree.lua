return {
    'nvim-tree/nvim-tree.lua',
    desc = 'A File Explorer For Neovim Written In Lua',
    cmd = { 'NvimTreeFindFileToggle' }, -- lazy load the plugin if command is run
    keys = {                            -- also lazy loads if any of the listed keymaps are pressed
        { '<leader>i', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'nvim-tree: find file in file tree' }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
    config = function()
        -- -- Disable netrw at the very start of your init.lua (strongly advised)
        -- -- but 'gx' will stop working
        -- vim.g.loaded_netrw = 1
        -- vim.g.loaded_netrwPlugin = 1

        -- Set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        -- Default options: https://github.com/nvim-tree/nvim-tree.lua/blob/aaee4cd896b74f85a81bed7eef2db7869960c4d0/lua/nvim-tree.lua#L361
        require("nvim-tree").setup({
            filters = {
                git_ignored = false,   -- shows git ignored files in the tree
                custom = { '^.git$' }, -- hides .git folder in the tree
            },
        })
    end
}
