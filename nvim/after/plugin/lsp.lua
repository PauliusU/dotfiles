local lsp = require("lsp-zero")

lsp.preset("recommended")

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
    print('LSP loaded: ' .. client.name)

    -- if client.name == "eslint" then
    --     vim.cmd.LspStop('eslint')
    --     return
    -- end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = 'LSP [G]o to [D]efinition', buffer = bufnr, remap = false })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = 'LSP hover', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, { desc = 'LSP workspace symbol', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = 'Diagnotsic: open float', buffer = bufnr, remap = false })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { desc = 'Next diagnostic', buffer = bufnr, remap = false })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { desc = 'Prev diagnostic', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, { desc = 'LSP code action', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, { desc = 'LSP references', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, { desc = 'LSP rename', buffer = bufnr, remap = false })
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, { desc = 'LSP signature help', buffer = bufnr, remap = false })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
