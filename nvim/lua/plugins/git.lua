-- Git and edit history
return {
    {
        "kdheepak/lazygit.nvim",
        -- Optional for floating window border decoration
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { '<leader>lg', '<cmd>LazyGit<CR>', desc = 'LazyGit' },
            { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'LazyGit' }
        }
    },
    {
        -- Show which lines are currently changed
        -- Adds git related signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            -- signs = {
            --     add = { text = '+' },
            --     change = { text = '~' },
            --     delete = { text = '_' },
            --     topdelete = { text = '‾' },
            --     changedelete = { text = '~' },
            -- },
            on_attach = function(bufnr)
                vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
            end,
        },

        config = function()
            -- gitsigns: Show which lines are currently changed
            require('gitsigns').setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'gitsigns: next hunk' })

                    map('n', '[c', function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'gitsigns: prev hunk' })

                    -- Actions
                    map('n', '<leader>hs', gs.stage_hunk, { desc = 'gitsigns: stage hunk' })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = 'gitsigns: reset hunk' })
                    map('v', '<leader>hn', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = 'gitsigns: stage hunk 2 ' })
                    map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = 'gitsigns: reset hunk' })
                    map('n', '<leader>hS', gs.stage_buffer, { desc = 'gitsigns: stage buffer' })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'gitsigns: undo stage hunk' })
                    map('n', '<leader>hR', gs.reset_buffer, { desc = 'gitsigns: reset buffer' })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = 'gitsigns: preview hunk' })
                    map('n', '<leader>hb', function() gs.blame_line { full = true } end,
                        { desc = 'gitsigns: blame line' })
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'gitsigns: toggle current line blame' })
                    map('n', '<leader>hd', gs.diffthis, { desc = 'gitsigns: diff this' })
                    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = 'gitsigns: diff this 2' })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = 'gitsigns: toggle deleted' })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
                current_line_blame = true,  -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
                    delay = 500, -- default: 1000
                },
            })
        end,

    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set("n", "<leader>uu", vim.cmd.UndotreeToggle, { desc = 'UndotreeToggle' })
        end
    },
}
