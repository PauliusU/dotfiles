local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local NvimConfigGroup = augroup('NvimConfig', {})
local YankGroup = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = YankGroup,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({ "BufWritePre" }, {
    -- Delete line postspaces
    group = NvimConfigGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufWritePre', {
    -- Fix linting problems with ESling
    group = NvimConfigGroup,
    pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
    command = 'silent! EslintFixAll',
})
