-- Distraction free coding
return {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    config = function()
        require("zen-mode").setup {
            window = {
                width = 90,
                options = {
                    number = true,
                    relativenumber = true,
                }
            },
        }

        vim.keymap.set("n", "<leader>uz", function()
            require("zen-mode").toggle()
            vim.wo.wrap = false
            ColorMyPencils()
        end, { desc = "Toggle ZEN mode" })
    end
}
