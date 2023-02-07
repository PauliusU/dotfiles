require('nvim_comment').setup()

-- Comment and stay in the same line with Ctrl + / (despite _ in the shortcut)
vim.keymap.set({"n", "i", "v"}, "<C-_>", "<cmd>CommentToggle<CR>")
-- Comment and move to the next line with Alt - /
vim.keymap.set({"n", "i", "v"}, "<A-/>", "<cmd>CommentToggle<CR><esc>j")
