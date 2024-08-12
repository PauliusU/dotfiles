-- Which-key - keyboard shortcut help by showing pending keybinds
return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")
        wk.add({
            { "<leader>s", group = "Telescope search" },
            { "<leader>u", group = "UI" },
        })
        require("which-key").setup {}
    end
}
