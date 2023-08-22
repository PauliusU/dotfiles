local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
})

-- Fix undefined global 'vim' and hammerspoon 'hs'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim', 'hs' }
            }
        }
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-u>'] = cmp.mapping.abort(), -- Close suggestions pop-up
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-i>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = '✘',
        warn = '▲',
        hint = '⚑',
        info = ''
    }
})

lsp.on_attach(function(client, bufnr)
    -- client.name - lsp:server name. E.g 'eslint'
    -- print('LSP loaded: ' .. client.name)

    -- LSP
    -- LSP: definitions, declarations, references and symbols
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        { desc = 'lsp: [G]o to [D]efinition', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
        { desc = 'lsp: go to type [D]efinition', buffer = bufnr, remap = false })
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
        { desc = 'lsp: [G]o to [D]eclaration', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>lgi', vim.lsp.buf.implementation,
        { desc = 'lsp: [G]o to [I]mplementation', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references,
        { desc = 'lsp: [G]o to [R]eferences', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol,
        { desc = 'lsp: query [W]orkspace [S]ymbol', buffer = bufnr, remap = false })
    -- LSP: actions and rename
    vim.keymap.set('n', '<S-F6>', vim.lsp.buf.rename, { desc = 'lsp: rename', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<F1>', vim.lsp.buf.code_action,
        { desc = 'lsp: code action', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>h', vim.lsp.buf.code_action,
        { desc = 'lsp: code action', buffer = bufnr, remap = false })
    -- LSP: popups (hover, signature help)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'lsp: hover', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<C-m>', vim.lsp.buf.signature_help,
        { desc = 'lsp: signature help', buffer = bufnr, remap = false })
    -- LSP: worspace folders
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'lsp: [W]orkspace [A]dd' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'lsp: [W]orkspace [R]emove' })
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { desc = 'lsp: [W]orkspace [L]ist' })

    -- Diagnostics (errors or warnings)
    vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float,
        { desc = 'Diagnostic: open float', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic: setloclist' })
    vim.keymap.set('n', '<F2>', vim.diagnostic.goto_next,
        { desc = 'Next diagnostic (problem)', buffer = bufnr, remap = false })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
        { desc = 'Next diagnostic (problem)', buffer = bufnr, remap = false })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
        { desc = 'Prev diagnostic (problem)', buffer = bufnr, remap = false })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

vim.keymap.set('n', '<leader>lp', '<cmd>LspInfo<cr>', { desc = 'LspInfo' })
