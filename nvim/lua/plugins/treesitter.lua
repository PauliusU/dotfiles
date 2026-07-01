-- treesitter - amazingly fast code parsing (main branch for nvim 0.12+)
return {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false, -- main branch must not be lazy-loaded
    dependencies = {
        -- show context of the currently visible buffer contents (a.k.a sticky scrolling)
        'nvim-treesitter/nvim-treesitter-context',
        -- text objects
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
    },
    config = function()
        vim.treesitter.language.register('bash', 'shell')

        -- Install parsers (async)
        require('nvim-treesitter').install {
            'bash',
            'c',
            'cpp',
            'css',
            'dockerfile',
            'gitignore',
            'go',
            'html',
            'javascript',
            'json',
            'lua',
            'markdown',
            'markdown_inline',
            'python',
            'regex',
            'rust',
            'toml',
            'tsx',
            'typescript',
            'vim',
            'xml',
            'yaml',
        }

        -- Highlight is built-in to nvim 0.12 (auto-enabled when parsers present)
        -- Indent + auto-install missing parsers
        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('TreesitterSetup', {}),
            callback = function(args)
                local ft = args.match
                local lang = vim.treesitter.language.get_lang(ft) or ft
                local ok = pcall(vim.treesitter.language.inspect, lang)
                if not ok then
                    -- only auto-install if a parser actually exists for this language
                    if require('nvim-treesitter').get_available and
                        vim.list_contains(require('nvim-treesitter').get_available(), lang) then
                        require('nvim-treesitter').install { lang }
                    end
                    return
                end
                if ft ~= 'python' then
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })

        -- Incremental node selection (an/in). These textobjects come from
        -- nvim-treesitter-textobjects (not core), hence remap=true below.
        vim.keymap.set('n', '<A-i>', 'van', { remap = true, desc = 'Select treesitter node' })
        vim.keymap.set('x', '<A-i>', 'an', { remap = true, desc = 'Expand to parent node' })
        vim.keymap.set('x', '<A-u>', 'in', { remap = true, desc = 'Shrink to child node' })

        -- Textobjects
        require('nvim-treesitter-textobjects').setup {
            select = { lookahead = true },
            move = { set_jumps = true },
        }

        local select_to = function(query)
            return function()
                require('nvim-treesitter-textobjects.select').select_textobject(query, 'textobjects')
            end
        end
        local goto_next_start = function(query)
            return function()
                require('nvim-treesitter-textobjects.move').goto_next_start(query, 'textobjects')
            end
        end
        local goto_next_end = function(query)
            return function()
                require('nvim-treesitter-textobjects.move').goto_next_end(query, 'textobjects')
            end
        end
        local goto_prev_start = function(query)
            return function()
                require('nvim-treesitter-textobjects.move').goto_previous_start(query, 'textobjects')
            end
        end
        local goto_prev_end = function(query)
            return function()
                require('nvim-treesitter-textobjects.move').goto_previous_end(query, 'textobjects')
            end
        end

        -- Select
        local xo = { 'x', 'o' }
        vim.keymap.set(xo, 'aa', select_to('@parameter.outer'))
        vim.keymap.set(xo, 'ia', select_to('@parameter.inner'))
        vim.keymap.set(xo, 'am', select_to('@function.outer'))
        vim.keymap.set(xo, 'im', select_to('@function.inner'))
        vim.keymap.set(xo, 'af', select_to('@call.outer'))
        vim.keymap.set(xo, 'if', select_to('@call.inner'))
        vim.keymap.set(xo, 'ac', select_to('@class.outer'))
        vim.keymap.set(xo, 'ic', select_to('@class.inner'))
        vim.keymap.set(xo, 'ai', select_to('@conditional.outer'))
        vim.keymap.set(xo, 'ii', select_to('@conditional.inner'))
        vim.keymap.set(xo, 'al', select_to('@loop.outer'))
        vim.keymap.set(xo, 'il', select_to('@loop.inner'))
        vim.keymap.set(xo, 'a=', select_to('@assignment.outer'))
        vim.keymap.set(xo, 'i=', select_to('@assignment.inner'))
        vim.keymap.set(xo, 'l=', select_to('@assignment.lhs'))
        vim.keymap.set(xo, 'r=', select_to('@assignment.rhs'))

        -- Move
        local nxo = { 'n', 'x', 'o' }
        vim.keymap.set(nxo, ']f', goto_next_start('@call.outer'), { desc = 'Next function call start' })
        vim.keymap.set(nxo, ']m', goto_next_start('@function.outer'), { desc = 'Next method def start' })
        vim.keymap.set(nxo, ']c', goto_next_start('@class.outer'), { desc = 'Next class start' })
        vim.keymap.set(nxo, ']i', goto_next_start('@conditional.outer'), { desc = 'Next conditional start' })
        vim.keymap.set(nxo, ']l', goto_next_start('@loop.outer'), { desc = 'Next loop start' })
        vim.keymap.set(nxo, ']F', goto_next_end('@call.outer'), { desc = 'Next function call end' })
        vim.keymap.set(nxo, ']M', goto_next_end('@function.outer'), { desc = 'Next method def end' })
        vim.keymap.set(nxo, ']C', goto_next_end('@class.outer'), { desc = 'Next class end' })
        vim.keymap.set(nxo, ']I', goto_next_end('@conditional.outer'), { desc = 'Next conditional end' })
        vim.keymap.set(nxo, ']L', goto_next_end('@loop.outer'), { desc = 'Next loop end' })
        vim.keymap.set(nxo, '[f', goto_prev_start('@call.outer'), { desc = 'Prev function call start' })
        vim.keymap.set(nxo, '[m', goto_prev_start('@function.outer'), { desc = 'Prev method def start' })
        vim.keymap.set(nxo, '[c', goto_prev_start('@class.outer'), { desc = 'Prev class start' })
        vim.keymap.set(nxo, '[i', goto_prev_start('@conditional.outer'), { desc = 'Prev conditional start' })
        vim.keymap.set(nxo, '[l', goto_prev_start('@loop.outer'), { desc = 'Prev loop start' })
        vim.keymap.set(nxo, '[F', goto_prev_end('@call.outer'), { desc = 'Prev function call end' })
        vim.keymap.set(nxo, '[M', goto_prev_end('@function.outer'), { desc = 'Prev method def end' })
        vim.keymap.set(nxo, '[C', goto_prev_end('@class.outer'), { desc = 'Prev class end' })
        vim.keymap.set(nxo, '[I', goto_prev_end('@conditional.outer'), { desc = 'Prev conditional end' })
        vim.keymap.set(nxo, '[L', goto_prev_end('@loop.outer'), { desc = 'Prev loop end' })

        -- Swap
        vim.keymap.set('n', '<leader>na', function()
            require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
        end, { desc = 'Swap param with next' })
        vim.keymap.set('n', '<leader>nm', function()
            require('nvim-treesitter-textobjects.swap').swap_next('@function.outer')
        end, { desc = 'Swap function with next' })
        vim.keymap.set('n', '<leader>pa', function()
            require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
        end, { desc = 'Swap param with previous' })
        vim.keymap.set('n', '<leader>pm', function()
            require('nvim-treesitter-textobjects.swap').swap_previous('@function.outer')
        end, { desc = 'Swap function with previous' })

        -- Repeatable moves: ; goes to the direction you were moving
        local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')
        vim.keymap.set(nxo, ';', ts_repeat_move.repeat_last_move_next)
        vim.keymap.set(nxo, ',', ts_repeat_move.repeat_last_move_previous)
        vim.keymap.set(nxo, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set(nxo, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set(nxo, 't', ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set(nxo, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
    end
}
