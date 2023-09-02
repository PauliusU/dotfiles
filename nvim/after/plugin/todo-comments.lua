require('todo-comments').setup({
    highlight = {
        pattern = [[.*<(KEYWORDS)\s*]], -- pattern or table of patterns, used for highlighting (vim regex)
    },
    search = {
        pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    }
})

local jumpKeywords = { keywords = { "FIX", "TEST", "TODO", "WARNING" } }
local function prevTodo()
    require("todo-comments").jump_prev(jumpKeywords)
end
local function nextTodo()
    require("todo-comments").jump_next(jumpKeywords)
end

vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<CR>', { desc = 'telescope_todo-comments: [S]earch [T]odos' })
vim.keymap.set('n', '<leader>tt', '<cmd>TodoQuickFix<CR>', { desc = 'Add TODOs to quickfix list' })
vim.keymap.set('n', '<leader>tl', '<cmd>TodoLocList<CR>', { desc = 'Show location list to show project TODOs' })
vim.keymap.set("n", "]t", nextTodo, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", prevTodo, { desc = "Previous todo comment" })
