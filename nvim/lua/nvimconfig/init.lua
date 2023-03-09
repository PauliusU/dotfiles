require("nvimconfig.autocommands")
require("nvimconfig.packer")
require("nvimconfig.remap")
require("nvimconfig.set")

-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25

vim.keymap.set('n', '<leader>ps', require('packer').sync, { desc = '[P]acker [S]ync' })
