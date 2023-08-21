-- Packer
vim.keymap.set('n', '<leader>ps', require('packer').sync, { desc = '[P]acker [S]ync' })

-- Autotag
-- For React apps, you often want to close tags quickly. windwp/nvim-ts-autotag is exactly what you want.
require('nvim-ts-autotag').setup()

-- surround.vim
-- Control "surroundings": parentheses, brackets, quotes, XML tags, and more.

-- refactoring.nvim
-- The Refactoring library based off the Refactoring book by Martin Fowler
require('refactoring').setup({})
vim.keymap.set("x", "<leader>re", ":Refactor extract ")
vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

-- prompt for a refactor to apply when the remap is triggered
-- Note that not all refactor support both normal and visual mode
vim.keymap.set({ "n", "x" }, "<leader>rw", function() require('refactoring').select_refactor() end, { desc = 'Prompt refactor' })

-- load refactoring Telescope extension
require("telescope").load_extension("refactoring")
vim.keymap.set( {"n", "x"}, "<leader>rt", function() require('telescope').extensions.refactoring.refactors() end)

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
vim.keymap.set( "n", "<leader>rn", function() require('refactoring').debug.printf({below = false}) end)

-- Print var
-- Supports both visual and normal mode
vim.keymap.set({"x", "n"}, "<leader>ru", function() require('refactoring').debug.print_var() end)

-- Supports only normal mode
vim.keymap.set("n", "<leader>rc", function() require('refactoring').debug.cleanup({}) end)
