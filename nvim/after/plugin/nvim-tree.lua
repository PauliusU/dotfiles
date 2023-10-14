-- -- Disable netrw at the very start of your init.lua (strongly advised)
-- -- but gx will stop working
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Empty setup using defaults
require("nvim-tree").setup()

vim.keymap.set('n', '<leader>i', '<cmd>NvimTreeFindFileToggle<CR>', { desc = 'Find file in file tree' })
