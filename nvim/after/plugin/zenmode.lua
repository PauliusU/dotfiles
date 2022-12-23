require("zen-mode").setup {
    window = {
        width = 90,
        options = {
            number = true,
            relativenumber = true,
        }
    },
}

vim.keymap.set("n", "<leader>z", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
    ColorMyPencils()
end)
