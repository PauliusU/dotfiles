-- Harpoon - quick toggle between marked files
return {
    'theprimeagen/harpoon',
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- Add and view file marks
        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Harpoon: add file mark" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: toggle quick menu" })
        vim.keymap.set("n", "<leader>uh", ui.toggle_quick_menu, { desc = "Harpoon: toggle quick menu" })
        require('telescope').load_extension('harpoon')
        vim.keymap.set("n", "<leader>fh", ":Telescope harpoon marks<cr>", { desc = "Harpoon: marks" })

        -- Navigation shortcuts
        vim.keymap.set("n", "<C-j>", function() ui.nav_file(1) end, { desc = "Harpoon: jump to file 1" })
        vim.keymap.set("n", "<C-k>", function() ui.nav_file(2) end, { desc = "Harpoon: jump to file 2" })
        vim.keymap.set("n", "<C-l>", function() ui.nav_file(3) end, { desc = "Harpoon: jump to file 3" })
        vim.keymap.set("n", "<C-h>", function() ui.nav_file(4) end, { desc = "Harpoon: jump to file 4" })
        vim.keymap.set("n", "]h", ui.nav_next, { desc = "Harpoon: next file" })
        vim.keymap.set("n", "[h", ui.nav_next, { desc = "Harpoon: prev file" })
    end
}
