-- Run code from within Neovim
return {
    'CRAG666/code_runner.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    event = 'BufEnter', -- Lazy load when entering a buffer
    config = function()
        require('code_runner').setup({
            -- put here the commands by filetype
            filetype = {
                java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
                python = "python3 -u",
                typescript = "tsx", -- similar to ts-node --esm --swc
                rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
            },
        })

        vim.keymap.set('n', '<leader>re', ':RunCode<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rl', ':RunFile<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rt', ':RunFile tab<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>xx', ':RunFile tab<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rt', ':RunFile tab<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
        vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
    end
}
