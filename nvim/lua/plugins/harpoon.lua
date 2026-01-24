return {
    'theprimeagen/harpoon',
    desc = "Harpoon 2 - quick toggle between marked files",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")

        -- REQUIRED
        harpoon:setup()
        -- REQUIRED

        vim.keymap.set("n", "<leader>ah", function() harpoon:list():add() end,
            { desc = "Harpoon: add file mark" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: toggle quick menu" })

        vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end, { desc = "Harpoon: jump to file 1" })
        vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end, { desc = "Harpoon: jump to file 2" })
        vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end, { desc = "Harpoon: jump to file 3" })
        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(4) end, { desc = "Harpoon: jump to file 4" })

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "[h", function() harpoon:list():prev() end, { desc = "Harpoon: prev file" })
        vim.keymap.set("n", "]h", function() harpoon:list():next() end, { desc = "Harpoon: next file" })

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers").new({}, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                }),
                previewer = conf.file_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>hh", function() toggle_telescope(harpoon:list()) end,
            { desc = "[P] Harpoon: Open picker window" })
    end
}
