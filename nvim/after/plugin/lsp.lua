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

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = 'LSP [G]o to [D]eclaration', buffer = bufnr, remap = false })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = 'LSP [G]o to [D]efinition', buffer = bufnr, remap = false })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = 'LSP hover', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>lgi", vim.lsp.buf.implementation, { desc = 'LSP [G]o to [I]mplementation', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<C-m>", vim.lsp.buf.signature_help, { desc = 'LSP signature help', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {desc = 'LSP [W]orkspace [A]dd' })
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {desc = 'LSP [W]orkspace [R]emove' })
    vim.keymap.set('n', '<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {desc = 'LSP [W]orkspace [L]ist' })
    vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = 'LSP [W]orkspace [S]ymbol', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = '[L]SP type [D]efinition', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { desc = '[L]SP [R]ename', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = 'LSP code action', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = 'LSP [G]o to [R]eferences', buffer = bufnr, remap = false })
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = 'Diagnostic: open float', buffer = bufnr, remap = false })
    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic: setloclist' })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = 'Next diagnostic', buffer = bufnr, remap = false })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = 'Prev diagnostic', buffer = bufnr, remap = false })
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})

vim.keymap.set('n', '<leader>lp', '<cmd>LspInfo<cr>', { desc = 'LspInfo' })
