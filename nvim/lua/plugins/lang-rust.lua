-- Rust language plugins
return {
    {
        'rust-lang/rust.vim',
        ft = 'rust', -- Lazy-load on filetype
        init = function()
            -- Enable Rust auto formatting on save
            vim.g.rustfmt_autosave = 1
        end
    },
    {
        -- Rust tools
        'simrat39/rust-tools.nvim',
        ft = 'rust',
        dependencies = 'neovim/nvim-lspconfig',
        config = function()
            local rt = require("rust-tools")
            rt.setup({
                server = {
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set("n", "<Leader>rh", rt.hover_actions.hover_actions, { buffer = bufnr })
                        -- Code action groups
                        vim.keymap.set("n", "<Leader>ra", rt.code_action_group.code_action_group, { buffer = bufnr })
                    end,
                },
            })
        end
    },
    {
        'saecki/crates.nvim',
        ft = { 'rust', 'toml' },
        config = function(_, opts)
            local crates = require('crates')
            crates.setup(opts)
            crates.show()

            vim.keymap.set('n', '<leader>rcu', function()
                require('crates').upgrade_all_crates()
            end, { desc = 'rust: upgrade all crates' })
        end
    },
}
