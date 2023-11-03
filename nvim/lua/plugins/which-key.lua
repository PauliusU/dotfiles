-- Which-key - keyboard shortcut help by showing pending keybinds
return {
    "folke/which-key.nvim",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        local wk = require("which-key")
        wk.register({
            u = { name = "UI" },
            s = { name = "Telescope search" },
        }, { prefix = "<leader>" })
        require("which-key").setup {}
    end
}
