-- Highlight and search for todo comments like TODO, HACK, BUG
return
{
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
        require('todo-comments').setup({
            highlight = {
                -- pattern or table of patterns, used for highlighting (vim regex)
                pattern = [[.*<(KEYWORDS)\s*]],
            },
            search = {
                -- match without the extra colon. You'll likely get false positives
                pattern = [[\b(KEYWORDS)\b]],
            }
        })

        local jumpKeywords = {
            keywords = {
                "TODO", "FIX", "TEST", "WARNING", "HACK", "BUG"
            }
        }
        local function prevTodo()
            require("todo-comments").jump_prev(jumpKeywords)
        end
        local function nextTodo()
            require("todo-comments").jump_next(jumpKeywords)
        end

        vim.keymap.set('n', '<leader>tt', '<cmd>TodoTelescope<CR>',
            { desc = 'telescope_todo-comments: [S]earch [T]odos' })
        vim.keymap.set('n', '<leader>tq', '<cmd>TodoQuickFix<CR>',
            { desc = 'todo-comments: add TODOs to quickfix list' })
        vim.keymap.set('n', '<leader>tl', '<cmd>TodoLocList<CR>',
            { desc = 'todo-comments: show location list to show project TODOs' })
        vim.keymap.set("n", "]t", nextTodo, { desc = "todo-comments: next todo comment" })
        vim.keymap.set("n", "[t", prevTodo, { desc = "todo-comments: previous todo comment" })
    end
}
