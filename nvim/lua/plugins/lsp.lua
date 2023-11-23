-- LSP, completion and snippets
return {
    { -- Collection of LSP configs for Neovim's built-in LSP
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Mason - autamatically install and manage LSP servers, debuggers and linters.
            { 'williamboman/mason.nvim' },
            -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
            { 'williamboman/mason-lspconfig.nvim' },
        },
        config = function()
            ---
            -- Global LSP config
            ---
            require('mason').setup(
                {
                    ui = {
                        icons = {
                            package_installed = "",
                            package_pending = "",
                            package_uninstalled = "",
                        },
                    }
                }
            )

            require('mason-lspconfig').setup({
                ensure_installed = {
                    'bashls',
                    'clangd',
                    'cssls',
                    'eslint',
                    'gopls',
                    'jsonls',
                    'lua_ls',
                    'pylsp', -- has number of static analysers built-in
                    'rust_analyzer',
                    'tailwindcss',
                    'tsserver',
                }
            })

            local lspconfig = require('lspconfig')
            local lsp_defaults = lspconfig.util.default_config

            -- Keymaps common for all LSPs
            vim.keymap.set("n", "<leader>lm", '<cmd>Mason<cr>', { desc = 'Open Mason' })
            vim.keymap.set('n', '<leader>lp', '<cmd>LspInfo<cr>', { desc = 'LspInfo' })

            -- Merge the defaults lspconfig provides with capabilities nvim-cmp adds
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lsp_defaults.capabilities,
                require('cmp_nvim_lsp').default_capabilities()
            )

            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function()
                    -- client.name - lsp:server name. E.g 'eslint'
                    -- print('LSP loaded: ' .. client.name .. ' (bufnr: ' .. bufnr .. ')')

                    -- LSP: formatting code
                    vim.keymap.set("n", "<leader>o", vim.lsp.buf.format, { desc = 'lsp: format current buffer' })

                    -- LSP: definitions, declarations, references and symbols
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'lsp: go to definition', remap = false })
                    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
                        { desc = 'lsp: go to the difinion of the type symbol', remap = false })
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
                        { desc = 'lsp: [G]o to [D]eclaration', remap = false })
                    vim.keymap.set('n', '<leader>lk', vim.lsp.buf.implementation,
                        { desc = 'lsp: list all the implementation for the symbol under the cursor ', remap = false })
                    vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references,
                        { desc = 'lsp: list all references', remap = false })
                    vim.keymap.set('n', '<leader>ll', vim.lsp.buf.workspace_symbol,
                        { desc = 'lsp: query [W]orkspace [S]ymbol', remap = false })

                    -- LSP: actions and rename
                    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename,
                        { desc = 'lsp: rename all references to the symbol under the cursor', remap = false })
                    -- Select a code action available at the current cursor position
                    vim.keymap.set('n', '<leader>h', vim.lsp.buf.code_action,
                        { desc = 'lsp: code action', remap = false })
                    vim.keymap.set({ 'v', 'n' }, '<F1>', vim.lsp.buf.code_action,
                        { desc = 'lsp: code action', remap = false })

                    -- LSP: hover and signature.
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover,
                        { desc = 'lsp: hover to display information about the symbol under the cursor', remap = false })
                    -- Displays a function's signature information
                    -- vim.keymap.set('n', '<C-m>', vim.lsp.buf.signature_help,
                    -- { desc = 'lsp: signature help', remap = false })
                    vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = 'lsp: signature help', remap = false })
                    -- LSP: worspace folders
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                        { desc = 'lsp: [W]orkspace [A]dd' })
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                        { desc = 'lsp: [W]orkspace [R]emove' })
                    vim.keymap.set('n', '<leader>wl',
                        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
                        { desc = 'lsp: [W]orkspace [L]ist' })

                    -- Diagnostics (errors or warnings)
                    vim.keymap.set('n', '<leader>df', vim.diagnostic.open_float,
                        { desc = 'Show diagnostics in a floating window', remap = false })
                    vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Diagnostic: setloclist' })
                    vim.keymap.set('n', '<F8>', vim.diagnostic.goto_next,
                        { desc = 'Next diagnostic (problem)', remap = false })
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
                        { desc = 'Next diagnostic (problem)', remap = false })
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
                        { desc = 'Prev diagnostic (problem)', remap = false })
                end
            })

            ---
            -- LSP servers
            ---

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            -- Fix undefined globals
                            globals = {
                                'vim',
                                'hs', -- hammerspoon
                                'mp', -- mpv playler
                            }
                        }
                    }
                }
            })

            local on_attach = function(client, bufnr)
                print('CUSTOM ON_ATTACH')
                -- Format on save
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = vim.api.nvim_create_augroup('Format', { clear = true }),
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.formatting_seq_sync() end
                    })
                end
            end

            local function ts_organize_imports()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) }
                }
                vim.lsp.buf.execute_command(params)
            end
            vim.keymap.set("n", "<leader>lo", '<cmd>TSOrganizeImports<cr>', { desc = 'Typescript: organize imports' })

            -- TypeScript and JavaScript
            lspconfig.tsserver.setup {
                commands = {
                    TSOrganizeImports = {
                        ts_organize_imports,
                        description = "Organize Imports"
                    }
                },
            }

            lspconfig.eslint.setup({
                on_attach = function(client, bufnr)
                    if client.name == "eslint" then
                        client.server_capabilities.documentFormattingProvider = true
                    elseif client.name == "tsserver" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                end
            })

            lspconfig.jsonls.setup({})

            -- Rust
            lspconfig.rust_analyzer.setup({
                on_attach = on_attach,
                settings = {
                    ['rust-analyzer'] = {
                        cargo = {
                            -- Help with autocomplete on Cargo crates
                            allFeatures = true,
                        }
                    }
                }
            })
            lspconfig.pylsp.setup({})  -- python
            lspconfig.gopls.setup({})
            lspconfig.clangd.setup({}) -- c, cpp
            lspconfig.bashls.setup({}) -- bash
            lspconfig.yamlls.setup({})
            lspconfig.cssls.setup({})
            lspconfig.tailwindcss.setup({})
            lspconfig.ltex.setup({})
            lspconfig.prismals.setup({})
            lspconfig.sqlls.setup({})

            --
            -- Autocompletion
            ---
            vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            local select_opts = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                sources = {
                    { name = "copilot",                group_index = 2 },    -- TODO: test Copilot Source
                    { name = 'path' },                                       -- Autocomplete file paths
                    { name = 'nvim_lsp',               keyword_length = 1 }, -- LSP suggestions a.k.a. from language server
                    { name = 'nvim_lsp_signature_help' },                    -- Display function signatures with current parameter emphasized
                    { name = 'nvim_lua',               keyword_length = 2 }, -- Complete neovim's Lua runtime API such vim.lsp.*
                    { name = 'buffer',                 keyword_length = 3 }, -- Suggest words found in the current buffer (source current buffer)
                    { name = 'luasnip',                keyword_length = 2 }, -- Shows avaiable snippets and expands them if they are chosen
                    { name = 'calc' },                                       -- source for math calculation
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered()
                },
                formatting = {
                    -- abbr is the content of the suggestion.
                    -- kind is the type of data, this can be text, class, function, etc.
                    -- menu which apparently is empty by default.
                    fields = { 'menu', 'abbr', 'kind' },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = 'λ',
                            nvim_lua = 'ξ',
                            luasnip = '⋗',
                            buffer = 'Ω',
                            path = '🖫',
                        }

                        item.menu = menu_icon[entry.source.name]
                        return item
                    end,
                },
                mapping = {
                    -- Move between copleteion items
                    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
                    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

                    -- Scroll text in the documentation window
                    ['<C-e>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),

                    -- Cancel completion (close suggestion pop up)
                    ['<C-u>'] = cmp.mapping.abort(),

                    -- Confirm selection
                    ['C-i'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                    }),
                    ['<C-y>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),

                    -- Jump to the next placeholder in the snippet.
                    ['<C-f>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- Jump to the previous placeholder in the snippet.
                    ['<C-b>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    -- Autocomplete with tab.
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expandable() then
                            -- If the cursor is inside a word, trigger the completion menu.
                            luasnip.expand()
                        elseif require("copilot.suggestion").is_visible() then
                            -- If copilot is visible, accept the suggestion.
                            require("copilot.suggestion").accept()
                        elseif cmp.visible() then
                            -- TODO confirm the first suggestion
                            -- cmp.complete()
                            -- If the completion menu is visible, move to the next item.
                            -- cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                            -- If the completion menu is visible, move to the next item.
                            cmp.select_next_item(select_opts)
                        else
                            fallback() -- Insert a tab character.
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            -- If the completion menu is visible, move to the previous item.
                            cmp.select_prev_item(select_opts)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }
            })

            -- Change diagnostic icons
            -- sign_define is not a lua function, it's vimscript.
            local sign = function(opts)
                vim.fn.sign_define(opts.name, {
                    texthl = opts.name,
                    text = opts.text,
                    numhl = ''
                })
            end

            sign({ name = 'DiagnosticSignError', text = '✘' })
            sign({ name = 'DiagnosticSignWarn', text = '' })
            sign({ name = 'DiagnosticSignHint', text = '⚑' })
            sign({ name = 'DiagnosticSignInfo', text = '' })

            -- Diagnostics config
            vim.diagnostic.config({
                virtual_text = true,      -- Show diagnostic message using virtual text
                severity_sort = true,     -- Order diagnostics by severity
                signs = true,             -- Show a sign next to the line with a diagnostic.
                update_in_insert = false, -- Update diagnostics while editing in insert mode.
                underline = true,         -- Use an underline to show a diagnostic location.
                float = {                 -- Show diagnostic messages in floating windows.
                    border = 'rounded',
                    source = 'always',
                },
            })
        end,
    },
    {
        -- Standalone UI for nvim-lsp progress
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
            -- options
        },
    },
}
