function ColorMyPencils()
    -- Global function to setup colorscheme and transparency

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

    require('onedark').load()
end

ColorMyPencils()