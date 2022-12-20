local telescope_builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', function()
    -- Find files (including hidden)

    telescope_builtin.find_files {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
        previewer = false
    }
end, {})
vim.keymap.set('n', '<leader>fs', telescope_builtin.grep_string, {}) -- find string

vim.keymap.set('n', '<leader>pf', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-p>', telescope_builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescope_builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
