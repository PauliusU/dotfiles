return {
    "hedyhli/outline.nvim",
    desc = "A sidebar with a tree-like outline of symbols from your code, powered by LSP",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
        { "go", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
        symbol_folding = {
            -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
            autofold_depth = 3,
        },
    },
}
