-- Theme and colors
return {
    {
        'navarasu/onedark.nvim', -- Onedark colorscheme
    },
    {
        'xiyaowong/transparent.nvim', -- Make any colorscheme transparent
        config = function()
            function ColorMyPencils()
                -- Global function to setup colorscheme and transparency

                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

                require('onedark').load()
            end

            ColorMyPencils()

            vim.keymap.set('n', '<leader>zx', '<cmd>:TransparentToggle<CR>',
                { desc = '<transparent.nvim>: toggle nvim transparency' })
        end
    }
}
