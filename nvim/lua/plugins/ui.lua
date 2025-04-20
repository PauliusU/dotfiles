return {
    {
        "folke/zen-mode.nvim",
        desc = "Distraction free coding",
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
    },
    {
        "folke/noice.nvim",
        desc = "Replaces the UI for messages, cmdline and the popupmenu",
        event = "VeryLazy",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    },
    {
        'RRethy/vim-illuminate',
        desc =
        "automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching."
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        desc = 'Add indentation guides even on blank lines',
        main = "ibl",
        opts = {
            indent = {
                char = '┊',
                -- char = '|',
                -- highlight = hl_name_list,
                -- show_trailing_blankline_indent = false,
            },
        },
    },
    {
        'kosayoda/nvim-lightbulb',
        desc =
        "shows a lightbulb 💡 in the sign column whenever a textDocument/codeAction is available at the current cursor position.",
        config = function()
            require("nvim-lightbulb").setup({
                autocmd = { enabled = true }
            })
        end
    },
}
