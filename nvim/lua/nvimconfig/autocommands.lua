local augroup = vim.api.nvim_create_augroup
local NvimConfigGroup = augroup('NvimConfig', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = NvimConfigGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})
