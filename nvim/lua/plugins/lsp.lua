-- LSP, completion, and snippets
return {
    { -- Collection of LSP configs for Neovim's built-in LSP
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Mason - autamatically install and manage LSP servers, debuggers and linters.
            { 'williamboman/mason.nvim' },
            -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim
            { 'williamboman/mason-lspconfig.nvim' },
            'WhoIsSethDaniel/mason-tool-installer.nvim',
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
                    'asm_lsp',
                    'bashls',
                    'clangd',
                    'cssls',
                    'docker_compose_language_service',
                    'dockerls',
                    'eslint',
                    'gopls',
                    'jsonls',
                    'lua_ls',
                    'prismals',
                    'pylsp', -- has number of static analyzers built-in
                    'rust_analyzer',
                    'tailwindcss',
                    'taplo', -- toml
                    'ts_ls', -- typescript
                    'yamlls',
                    -- Sandbox LSPs
                    'html',
                    'emmet_ls',
                    'harper_ls', -- markdown
                },
                -- auto-install congigured servers (with lspconfig)
                automatic_installation = true, -- not the same as 'ensure_installed'
            })

            local mason_tool_installer = require('mason-tool-installer')
            mason_tool_installer.setup({
                ensure_installed = {
                    -- 'eslint',
                    -- 'prettier',
                    -- 'stylelint',
                    -- 'typescript',
                    -- 'typescript-language-server',
                    -- 'typescript-formatter',
                    'shellcheck', -- bash linter
                    'stylua',     -- lua formatter
                },
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

                    -- LSP: etc
                    vim.keymap.set('n', '<leader>ux', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, { desc = 'LSP: toggle inlay hints', remap = false })
                    vim.keymap.set('n', '<M-C-i>', function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end, { desc = 'LSP: toggle inlay hints', remap = false })
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
            lspconfig.ts_ls.setup {
                commands = {
                    TSOrganizeImports = {
                        ts_organize_imports,
                        description = "Organize Imports"
                    }
                },
                settings = {
                    javascript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = false,
                        },
                    },
                    typescript = {
                        inlayHints = {
                            includeInlayEnumMemberValueHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayVariableTypeHints = false,
                        },
                    },
                },
            }

            lspconfig.eslint.setup({
                on_attach = function(client, _bufnr)
                    if client.name == "eslint" then
                        client.server_capabilities.documentFormattingProvider = true
                    elseif client.name == "tsserver" then
                        client.server_capabilities.documentFormattingProvider = false
                    end
                end
            })

            lspconfig.jsonls.setup({})

            -- Rust
            -- lspconfig.rust_analyzer.setup({
            --     on_attach = on_attach,
            --     settings = {
            --         ['rust-analyzer'] = {
            --             cargo = {
            --                 -- Help with autocomplete on Cargo crates
            --                 allFeatures = true,
            --             }
            --         }
            --     }
            -- })
            lspconfig.pylsp.setup({}) -- python
            lspconfig.gopls.setup({})
            lspconfig.asm_lsp.setup({
                filetypes = {
                    'asm',
                    's', -- not default
                    'vmasm'
                },
            })
            lspconfig.clangd.setup({ -- c, cpp
                -- Fix "Multiple different client offset_encodings detected" error
                -- ref: https://www.reddit.com/r/neovim/comments/12qbcua/multiple_different_client_offset_encodings/
                cmd = { "clangd", "--offset-encoding=utf-16", },
            })
            lspconfig.bashls.setup({}) -- bash
            lspconfig.yamlls.setup({})
            lspconfig.cssls.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.docker_compose_language_service.setup({})
            lspconfig.markdown_oxide.setup({})
            lspconfig.taplo.setup({}) -- toml
            lspconfig.tailwindcss.setup({})
            lspconfig.prismals.setup({})
            -- Sandbox
            lspconfig.lemminx.setup({}) -- xml
            lspconfig.html.setup({})
            lspconfig.emmet_ls.setup({
                filetypes = {
                    'html',
                    'css',
                    'sass',
                    'scss',
                    'less',
                    'typescriptreact',
                    'javascriptreact',
                    'vue',
                    'svelte',
                    -- 'markdown',
                },
            })
            lspconfig.harper_ls.setup({ -- Spell checking, grammar checking, and more
                settings = {
                    ["harper-ls"] = {
                        linters = {
                            ToDoHyphen = false,
                        },
                        -- Only link English if the text has multiple languages

                        isolateEnglish = true,
                        markdown = {
                            -- [ignores this part]()
                            -- [[ also ignores marksman links ]]
                            IgnoreLinkTitle = true,
                        },
                    },
                },
            })
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

            -- Diagnostics config
            vim.diagnostic.config({
                virtual_text = true,  -- Show diagnostic message using virtual text
                severity_sort = true, -- Order diagnostics by severity
                -- Show a sign next to the line with a diagnostic
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = '✘',
                        [vim.diagnostic.severity.WARN] = '',
                        [vim.diagnostic.severity.INFO] = '',
                        [vim.diagnostic.severity.HINT] = '⚑',
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
                    },
                    numhl = {
                        [vim.diagnostic.severity.WARN] = 'WarningMsg',
                    },
                },
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
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()

            -- Show virtual lines only for the current line's diagnostics:
            vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

            -- TODO: test. If you don't want to highlight the entire diagnostic line, use:
            -- vim.diagnostic.config({ virtual_lines = { highlight_whole_line = false } })

            vim.keymap.set("", "<leader>kl", require("lsp_lines").toggle, { desc = "[P] Toggle lsp_lines" })
        end,
    },
}
