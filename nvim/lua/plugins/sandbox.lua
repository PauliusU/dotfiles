-- Sandbox - plugins for testing. Not yet part of the main config
return {
	{
		"nvim-pack/nvim-spectre",
		desc = "Search and replace in files",
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile vnew" },
        -- stylua: ignore
        keys = {
            { "<leader>sr", function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
            { "<C-A-r>",    function() require("spectre").open() end, desc = "Replace in files (Spectre)" },
        },
	},
	{
		"danymat/neogen",
		desc = "Generate code documentation for your functions, classes, and more. (TSDoc, JSDoc, etc.)",
		dependencies = "nvim-treesitter/nvim-treesitter",
		-- config = true,
		-- Uncomment next line if you want to follow only stable versions
		-- version = "*"
		config = function()
			require("neogen").setup({ enabled = true })
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", opts)
			vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
		end,
	},
	{
		"cordx56/rustowl",
		ft = "rust", -- PU: Lazy-load on filetype
		version = "*", -- Latest stable version
		build = "cargo binstall rustowl",
		lazy = false, -- This plugin is already lazy
		opts = {
			client = {
				on_attach = function(_, buffer)
					vim.keymap.set("n", "<leader>xo", function()
						require("rustowl").toggle(buffer)
					end, { buffer = buffer, desc = "Toggle RustOwl" })
				end,
			},
		},
	},
	{
		-- Visualize and review your Neovim configuration activity with stats, insights, history, and heatmaps.
		"aikhe/wrapped.nvim",
		dependencies = { "nvzone/volt" }, -- UI framework dependency
		cmd = { "WrappedNvim" },
		opts = {},
	},
}
