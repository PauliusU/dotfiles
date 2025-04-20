return {
    "zeioth/garbage-day.nvim",
    desc = "Garbage collector that stops inactive LSP clients to free RAM",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
        notifications = true,
    }
}
