return {
    "m4xshen/hardtime.nvim",
    desc = "hardtime.nvim - establish good neovim habits",
    dependencies = { 'MunifTanjim/nui.nvim', "nvim-lua/plenary.nvim" },
    config = function()
        require("hardtime").setup({
            restricted_keys = {
                -- Override default { "n", "x" } to allow keys in normal mode
                ["j"] = { "x" },
                ["k"] = { "x" },
                ["<C-P>"] = { "x" },
            },
            disabled_keys = {
                ["<Left>"] = {},
                ["<Right>"] = {},
            },
        })
    end
}
