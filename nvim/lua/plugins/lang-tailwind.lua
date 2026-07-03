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
        event = "BufReadPre",
        opts = {
            options = {
                parsers = {
                    tailwind = { enable = true, lsp = true },
                },
            },
        }
    }
}
