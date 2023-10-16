-- treesitter - amazingly fast code parsing
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- update parsers on install
    event = {            -- lazy load plugin only in the buffer context
        'BufReadPre',    -- when opening a buffer for an already existing file
        'BufNewFile',    -- when opening a buffer for a file that doesn't exist yet
    },
    dependencies = {
        -- show context of the currently visible buffer contents (a.k.a sticky scrolling)
        'nvim-treesitter/nvim-treesitter-context',
        -- text objects
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
        -- See `:help nvim-treesitter`
        require('nvim-treesitter.configs').setup {
            -- Add languages to be installed here that you want installed for treesitter
            -- A list of parser names, or "all":
            -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
            ensure_installed = {
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
                'markdown_inline', -- dependency for "folke/noice.nvim"
                'markdown',
                'python',
                'regex', -- dependency for "folke/noice.nvim"
                'rust',
                'toml',
                'tsx',
                'typescript',
                'vim', -- Vimscript
                'yaml',
            },

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            -- Automatically install missing parsers when entering buffer
            auto_install = true,

            highlight = {
                -- better syntax highlighting. `false` will disable the whole extension
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, disable = { 'python' } }, -- better indentation
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<A-i>',
                    node_incremental = '<A-i>',
                    scope_incremental = '<A-o>',
                    node_decremental = '<A-u>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm

                        -- Parameter/argument
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',

                        -- Function definition
                        ['am'] = '@function.outer',
                        ['im'] = '@function.inner',

                        -- Function call
                        ['af'] = '@call.outer',
                        ['if'] = '@call.inner',

                        -- Class
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',

                        -- Conditional
                        ['ai'] = '@conditional.outer',
                        ['ii'] = '@conditional.inner',

                        -- Loop
                        ['al'] = '@loop.outer',
                        ['il'] = '@loop.inner',

                        -- You can use the capture groups defined in textobjects.scm
                        ['a='] = { query = '@assignement.outter', desc = 'Select outter part of an assignement' },
                        ['i='] = { query = '@assignement.inner', desc = 'Select inner part of an assignement' },
                        ['l='] = { query = '@assignement.lhs', desc = 'Select left hand side of an assignement' },
                        ['r='] = { query = '@assignement.rhs', desc = 'Select right hand side of an assignement' },

                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']f'] = { query = '@call.outer', desc = 'Next function call start' },
                        [']m'] = { query = '@function.outer', desc = 'Next function/methon def start' },
                        [']c'] = { query = '@class.outer', desc = 'Next class start' },
                        [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
                        [']l'] = { query = '@loop.outer', desc = 'Next loop start' },
                    },
                    goto_next_end = {
                        [']F'] = { query = '@call.outer', desc = 'Next function call end' },
                        [']M'] = { query = '@function.outer', desc = 'Next function/methon def end' },
                        [']C'] = { query = '@class.outer', desc = 'Next class end' },
                        [']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
                        [']L'] = { query = '@loop.outer', desc = 'Next loop end' },
                    },
                    goto_previous_start = {
                        ['[f'] = { query = '@call.outer', desc = 'Previous function call start' },
                        ['[m'] = { query = '@function.outer', desc = 'Previous function/methon def start' },
                        ['[c'] = { query = '@class.outer', desc = 'Previous class start' },
                        ['[i'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
                        ['[l'] = { query = '@loop.outer', desc = 'Previous loop start' },
                    },
                    goto_previous_end = {
                        ['[F'] = { query = '@call.outer', desc = 'Previous function call end' },
                        ['[M'] = { query = '@function.outer', desc = 'Previous function/methon def end' },
                        ['[C'] = { query = '@class.outer', desc = 'Previous class end' },
                        ['[I'] = { query = '@conditional.outer', desc = 'Previous conditional end' },
                        ['[L'] = { query = '@loop.outer', desc = 'Previous loop end' },
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>na'] = '@parameter.inner', -- swap parameter/arument with next
                        ['<leader>nm'] = '@function.outer',  -- swap function with next
                    },
                    swap_previous = {
                        ['<leader>pa'] = '@parameter.inner', -- swap parameter/arument with previous
                        ['<leader>pm'] = '@function.outer',  -- swap function with previous
                    },
                },
            },
        }

        local ts_repeat_move = require('nvim-treesitter.textobjects.repeatable_move')

        -- vim way: ; goes to the direction you were moving
        vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move)
        vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_opposite)

        -- optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f)
        vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F)
        vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t)
        vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T)
    end
}
