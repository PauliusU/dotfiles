-- nvim/init.lua

-- Reduce Neovim startup time
vim.loader.enable()

require('core.options')
require('core.keymaps')
require('core.autocommands')
require('core.lazy_plugin_manager')
