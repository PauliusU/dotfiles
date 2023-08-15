-- Custom keyboard shortcuts for neovim

-- Set <space> as the leader key
vim.g.mapleader = " "

-- Manage config
vim.keymap.set("n", "<leader>rr", "<cmd>source $MYVIMRC<CR>", { desc = 'Reload config' })
vim.keymap.set('n', '<leader>ll', '<cmd>source %<CR>', { desc = '[L]oad file a.k.a source active buffer' })

-- Switch modes
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Explore file tree ([P]roject [V]view)' })
vim.keymap.set("i", "jk", "<Esc>", { desc = 'Exist insert mode' })
vim.keymap.set("t", "jk", "<C-\\><C-n>", { desc = 'Exit terminal mode' })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = 'Enter normal mode' })

-- Navigation
vim.keymap.set({ "n", "v", "i" }, "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>",
    { desc = "Switch tmux sessions" })
-- Switch buffers
local default_opts = { noremap = true, silent = true }
-- vim.keymap.set("n", "<S-h>", ":bprevious<CR>", default_opts)
-- vim.keymap.set("n", "<S-l>", ":bnext<CR>", default_opts)
vim.keymap.set("n", "<S-h>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<S-l>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set({ "n", "v", "i" }, "[b", "<cmd>bp<CR>", { desc = "Previous buffer :bprevious" })
vim.keymap.set({ "n", "v", "i" }, "]b", "<cmd>bn<CR>", { desc = "Next buffer :bnext" })
vim.keymap.set({ "n" }, "6", "<cmd>b#<CR>", { desc = "Toggle between two buffers. <C-^> in other layout" })
-- Switch tabs
vim.keymap.set({ "n" }, "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set({ "n" }, "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
-- Quickfix navigation
vim.keymap.set("n", "<C-A-k>", "<cmd>cnext<CR>zz", { desc = "Quickfix next" })
vim.keymap.set("n", "<C-A-j>", "<cmd>cprev<CR>zz", { desc = "Quickfix previous" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Like :cnext but use location list and not the quickfix" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Like :cprev but use location list and not the quickfix" })
-- Moving cursor in insert mode
vim.keymap.set('i', '<C-l>', '<Esc>la', { desc = 'Move backward by one char in insert mode' })
vim.keymap.set('i', '<C-h>', '<Esc>ha', { desc = 'Move forward by one char in insert mode' })
-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
-- Move selected line / block of text in visual mode
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv", { desc = 'Move line down' })
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv", { desc = 'Move line up' })

-- Resizing panes with arrow keys
vim.keymap.set("n", "<Left>", ":vertical resize +1<CR>", default_opts)
vim.keymap.set("n", "<Right>", ":vertical resize -1<CR>", default_opts)
vim.keymap.set("n", "<Up>", ":resize -1<CR>", default_opts)
vim.keymap.set("n", "<Down>", ":resize +1<CR>", default_opts)

-- Stay in the middle when navigating or searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center screen when moving down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center screen when moving up" })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Center search results' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Center search results' })

-- Copy, paste, delete
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Delete to void register' })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without messing your register' })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste over currently selected text without yanking it" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'asbjornHaland -- copy to system clipboard #1' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'asbjornHaland -- copy to system clipboard #2' })
vim.keymap.set({ "n", "v" }, "<leader>v", [["+p]], { desc = 'Paste from system clipboard' })

-- Similar to other editors (save, quit, select all)
vim.keymap.set({ "n", "v", "i" }, "<A-s>", vim.cmd.update, { desc = ":write, but only when the buffer is modified." })
vim.keymap.set({ "n", "v", "i" }, "<A-q>", "<cmd>q<CR>", { desc = '[Q]uit neovim' })
vim.keymap.set({ "n", "v", "i" }, "<C-A-q>", "<cmd>q!<CR>", { desc = 'Force [q]uit neovim' })
vim.keymap.set({ "n", "v" }, "<A-a>", "<esc>ggVG", { desc = 'Select [A]ll text' })

-- Etc
vim.keymap.set("n", "Q", "<nop>", { desc = 'Disable capital Q' })
vim.keymap.set("n", "<leader>o", vim.lsp.buf.format, { desc = 'F[o]rmat current buffer' })
vim.keymap.set({ "n", "v" }, "<A-m>", "<cmd>set wrap!<CR>", { desc = 'Toggle wrap' })
vim.keymap.set("n", "<leader>n", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Rename symbol (replace word under the cursor)" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
vim.keymap.set("n", "J", "mzJ`z", { desc = 'Append line below, but keep cursor in place' })
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", default_opts)
vim.keymap.set("v", ">", ">gv", default_opts)
-- Quotes
vim.keymap.set('n', '<leader>q"', 'ciw""<Esc>P', { desc = 'Add double [q]uotes around the word' })
vim.keymap.set('n', '<leader>q\'', 'ciw\'\'<Esc>P', { desc = 'Add single [q]uotes around the word' })
