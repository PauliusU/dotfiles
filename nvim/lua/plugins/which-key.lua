-- Which-key - keyboard shortcut help by showing pending keybinds
return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        require("which-key").setup {}
    end
}
