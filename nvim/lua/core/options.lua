-- Neovim options

-- Line numbers
vim.opt.number = true         -- Show line nubmers
vim.opt.relativenumber = true -- Relative line numbers
vim.opt.cursorline = true     -- Highlight the screen line of the cursor

-- Tabs
vim.opt.tabstop = 4 -- Number of visual spaces per TAB
vim.opt.softtabstop = 4 -- Number of spaces in tab when editing
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Tabs are spaces i.e. use spaces instead of tabs

-- Line indents and wraps
vim.opt.smartindent = true -- Do smart autoindenting when starting a new line
vim.opt.wrap = false

-- Columns
vim.opt.colorcolumn = "80" -- Show border for good code style

-- Disable native nvim backup, but save to undotree
vim.opt.swapfile = false
vim.opt.backup = false
-- vim.opt.undodir = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/.vim/undodir"
vim.opt.undofile = true -- Save undo history

-- Search
-- vim.opt.hlsearch = false
vim.opt.incsearch = true  -- Incremental search (highlight matches as you type)
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override the 'ignorecase' if search contains an uppercase characters

-- Appearance and colors
vim.opt.termguicolors = true

-- Faster update time
vim.opt.updatetime = 50

-- Enable mouse mode (right mouse click menu)
vim.opt.mouse = 'a'

-- Spelling
vim.opt.spelllang = 'lt,en'

-- ETC
vim.opt.scrolloff = 8      -- Never have less than 8 lines when scrolling
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default

-- Sandbox (testing to include in the main config)
