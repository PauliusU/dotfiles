-- Install lazy.nvim automatically if needed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set('n', '<leader>pp', require('lazy').sync, { desc = 'lazy: sync plugins' })
vim.keymap.set('n', '<leader>la', '<cmd>Lazy<cr>', { desc = 'lazy: open plugin manager' })

-- Load lazy.nvim from nvim/lua/plugins folder
-- NOTE: Make sure `mapleader` is set before lazy so mappings are correct
require('lazy').setup('plugins')
