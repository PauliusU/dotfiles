--[[

VIM-FUGITIVE default shortcuts:
    '-' adds/removes the file under the cursor to/from the staging area
    'dd' opens the file in diff mode in two splits
    'cc' to commit your changes and write the commit message

-- ]]
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus for vim-fugitive" })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "[G]it [P]ush" })
vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "[G]it pul[L]" })

local NvimConfig_Fugitive = vim.api.nvim_create_augroup("NvimConfig_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = NvimConfig_Fugitive,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)

        -- rebase always
        vim.keymap.set("n", "<leader>P", function()
            vim.cmd.Git({ 'pull', '--rebase' })
        end, opts)

        -- NOTE: It allows me to easily set the branch I am pushing and any tracking
        -- needed if I did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})
