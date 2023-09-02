-- Enable GitHub Copilot on startup
vim.cmd 'Copilot setup'

-- Keep Copilot enabled even if <Tab> is claimed by another plugin
-- ref: https://www.reddit.com/r/neovim/comments/sk70rk/using_github_copilot_in_neovim_tab_map_has_been/
vim.g.copilot_assume_mapped = true

vim.keymap.set('n', '<leader>cp', '<cmd>Copilot setup<cr>', { desc = 'Enable GitHub [C]o[p]ilot' })
vim.keymap.set('n', '<leader>cs', '<cmd>Copilot status<cr>', { desc = 'Print GitHub [C]opilot [s]tatus' })
vim.keymap.set('i', '<C-h>', '<Plug>(copilot-next)', { silent = true, desc = 'Copilot next suggestion' })
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-previous)', { silent = true, desc = 'Copilot previous suggestion' })
vim.keymap.set('i', '<C-u>', '<Plug>(copilot-suggest)', { silent = true, desc = 'Copilot suggest' })
vim.keymap.set('i', '<C-t>', '<Plug>(copilot-accept)', { silent = true, desc = 'Copilot accept suggestion' })
vim.keymap.set('i', '<C-y>', [[:call copilot#Accept()<CR>]], { desc = 'Copilot accept suggestion' })
