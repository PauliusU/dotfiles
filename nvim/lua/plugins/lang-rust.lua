-- Rust language plugins
return {
    {
        'rust-lang/rust.vim',
        desc = 'Rust - automatic formatting on save',
        ft = 'rust', -- Lazy-load on filetype
        init = function()
            -- Enable Rust auto formatting on save
            vim.g.rustfmt_autosave = 1
            -- vim.g.rustfmt_fail_silently = 1
        end
    },
    {
        'mrcjkb/rustaceanvim',
        desc = '🦀 Supercharge your Rust experience in Neovim! A heavily modified fork of rust-tools.nvim',
        version = '^5', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        'saecki/crates.nvim',
        ft = { 'toml' },
        config = function(_, opts)
            local crates = require('crates')
            crates.setup(opts)
            crates.setup {
                completion = {
                    cmp = {
                        enabled = true,
                    }
                }
            }
            require('cmp').setup.buffer({
                sources = { { name = 'crates' }, }
            })
            crates.show()

            vim.keymap.set('n', '<leader>rcu', function()
                require('crates').upgrade_all_crates()
            end, { desc = 'rust: upgrade all crates' })
        end
    },
}
