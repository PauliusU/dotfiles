return {
    -- { -- update preconfigured nvim-lspconfig options
    --     'neovim/nvim-lspconfig',
    --     opts = {
    --         servers = { -- automatically install tailwind lsp without mason
    --             tailwindcss = {},
    --         }
    --     },
    -- },
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup({
                user_default_options = {
                    tailwind = true,
                }
            })
        end
    }
}
