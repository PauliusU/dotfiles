-- Enable GitHub Copilot on startup
vim.cmd 'Copilot setup'

-- Keep Copilot enabled even if <Tab> is claimed by another plugin
-- ref: https://www.reddit.com/r/neovim/comments/sk70rk/using_github_copilot_in_neovim_tab_map_has_been/
vim.g.copilot_assume_mapped = true

vim.keymap.set('n', '<leader>cp', '<cmd>Copilot setup<cr>', { desc = 'Enable GitHub [C]o[p]ilot' })
vim.keymap.set('n', '<leader>cs', '<cmd>Copilot status<cr>', { desc = 'Print GitHub [C]opilot [s]tatus' })
vim.keymap.set('i', '<C-j>', '<Plug>(copilot-next)', { silent = true })
vim.keymap.set('i', '<C-k>', '<Plug>(copilot-previous)', { silent = true })
vim.keymap.set('i', '<C-u>', '<Plug>(copilot-suggest)', { silent = true })

