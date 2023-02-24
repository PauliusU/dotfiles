-- Line numbers
vim.opt.nu = true -- Enable line numbers
vim.opt.relativenumber = true -- Relabile line numbers
vim.opt.cursorline = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Line indents and wraps
vim.opt.smartindent = true
vim.opt.wrap = false

-- Columns
vim.opt.colorcolumn = "80"

-- Disable navite nvim backup, but save to undotree
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true -- Save undo history

-- Search
-- vim.opt.hlsearch = false
vim.opt.incsearch = true -- Incremental search (highlight matches as you type)
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override the 'ignorecase' if search contains an uppercase characters

-- Colors
vim.opt.termguicolors = true

vim.opt.scrolloff = 8 -- Never have less than 8 lines whan scrolling
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.isfname:append("@-@")

-- Faster update time
vim.opt.updatetime = 50

-- Enable mouse mode (right mouse click menu)
vim.o.mouse = 'a'
