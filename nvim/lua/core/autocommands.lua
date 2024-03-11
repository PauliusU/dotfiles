-- Neovim autocommands

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
    -- Delete line postspaces on file save. Trim white space before saving
    group = NvimConfigGroup,
    -- Apply to all file types
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

autocmd('BufWritePre', {
    -- Fix linting problems on file save with ESlint
    group = NvimConfigGroup,
    pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
    command = 'silent! EslintFixAll',
})

autocmd("BufEnter", {
    -- Turn off automaticly commenting the new line
    -- ref: https://www.reddit.com/r/neovim/comments/17fc669/turn_off_auto_commenting_lazynvim/?share_id=pD0z5W3DJ2RslBQ94PcV_
    callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
    desc = "Disable New Line Comment",
})
