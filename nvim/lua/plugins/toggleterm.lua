return {
    'akinsho/toggleterm.nvim',
    version = "*",
    -- keys = {
    --     { "<leader>rf", "<cmd>ToggleTermSendCurrentLine<cr>", desc = "ToggleTerm: send current line" },
    --     { "<C-`>", "<cmd>ToggleTerm<cr>", desc = "ToggleTerm: send current line" },
    -- },
    opts = {
        vim.keymap.set("n", "<leader>rr", "<cmd>ToggleTermSendCurrentLine<cr>",
            { desc = "ToggleTerm: send current line (and run)" }),
        vim.keymap.set({ "n", "t" }, "<M-C-x>", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
    }
}

