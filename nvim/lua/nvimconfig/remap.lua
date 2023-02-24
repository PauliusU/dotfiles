-- Set <space> as the leader key
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>r", "<cmd>source $MYVIMRC<CR>") -- Reload config
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- Explore file tree (project view)
vim.keymap.set("i", "jk", "<Esc>") -- Enter normal mode

-- Navigation
vim.keymap.set({ "n", "v", "i" }, "[b", "<cmd>bp<CR>", { desc = "Previous buffer :bprevious" })
vim.keymap.set({ "n", "v", "i" }, "]b", "<cmd>bn<CR>", { desc = "Next buffer :bnext" })

-- Move lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- Append line below, but keep cursor in space

-- Stay in the middle when navigating or searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever -- paste without messing your register
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland -- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
-- vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>") -- disable capital Q
vim.keymap.set({ "n", "v", "i" }, "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>o", vim.lsp.buf.format) -- Format current buffer

-- Quickfix navigation
-- TODO resolve conflict with harpoon shortcuts
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Rename symbol (replace word under the cursor)
vim.keymap.set("n", "<leader>n", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- -- Similar to other editors
-- Save with Alt-S
vim.keymap.set({ "n", "v", "i" }, "<A-s>", vim.cmd.update)
-- Quit with Alt-Q
vim.keymap.set({ "n", "v", "i" }, "<A-q>", "<cmd>q<CR>")
-- Force quit with Ctrl-Alt-Q
vim.keymap.set({ "n", "v", "i" }, "<C-A-q>", "<cmd>q!<CR>")
-- Select all with Alt-A
vim.keymap.set({ "n", "v" }, "<A-a>", "<esc>ggVG")

vim.keymap.set({ "n", "v" }, "<A-m>", "<cmd>set wrap!<CR>") -- Toggle wrap
