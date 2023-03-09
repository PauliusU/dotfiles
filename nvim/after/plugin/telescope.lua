local telescope_builtin = require('telescope.builtin')

local function FindAllFiles()
    -- Find all filles including hidden in the project
    return function()
        telescope_builtin.find_files {
            -- --files            print file list used in search
            -- --hidden           search hidden files and folders
            -- --no-ignore-vcs    don't respect ignore files (e.g. .gitignore)
            find_command = { 'rg', '--files', '--hidden', '--no-ignore-vcs' },
            previewer = false
        }
    end
end

local function FindMostFiles()
    -- Find all files exluding node_modules, .git and dist folders
    return function()
        telescope_builtin.find_files {
            -- -g                 glob - include or exlude files and directories from searching
            find_command = { 'rg', '--files', '--hidden', '--no-ignore-vcs', '-g', '!{node_modules,.git,dist}' },
            previewer = false
        }
    end
end

-- File pickers
vim.keymap.set('n', '<C-p>', FindMostFiles(), { desc = 'Find files' })
vim.keymap.set('n', '<C-A-p>', telescope_builtin.git_files, { desc = 'Search only git files' })
vim.keymap.set('n', '<C-A-s>', telescope_builtin.live_grep, { desc = 'Search string. Respects .gitignore.' })
vim.keymap.set('n', '<leader>ff', FindAllFiles(), { desc = '[F]ind all [F]iles ' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files,
    { desc = '[S]earch [F]iles. Respects .gitignore' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
    { desc = '[S]earch current [W]ord under cursor' })

-- VIM pickers
vim.keymap.set('n', '<C-A-b>', telescope_builtin.buffers, { desc = 'Search buffers' })
vim.keymap.set('n', '<leader>?', telescope_builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sc', telescope_builtin.commands, { desc = '[S]earch [C]ommands' })
vim.keymap.set('n', '<leader>st', telescope_builtin.tags, { desc = '[S]earch [T]ags' })
vim.keymap.set('n', '<leader>sch', telescope_builtin.command_history, { desc = 'Lookup in [C]earch [H]istory' })
vim.keymap.set('n', '<leader>ssh', telescope_builtin.search_history, { desc = 'Lookup in [S]earch [H]istory' })
vim.keymap.set('n', '<leader>se', telescope_builtin.colorscheme, { desc = 'Pick color schem[e]' })
vim.keymap.set('n', '<leader>sq', telescope_builtin.quickfix)
vim.keymap.set('n', '<leader>sl', telescope_builtin.loclist)
vim.keymap.set('n', '<leader>sj', telescope_builtin.jumplist)
vim.keymap.set('n', '<leader>so', telescope_builtin.vim_options)
vim.keymap.set('n', '<leader>sr', telescope_builtin.registers)
vim.keymap.set('n', '<leader>sa', telescope_builtin.autocommands)
vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps)
vim.keymap.set('n', '<leader>sf', telescope_builtin.filetypes)
vim.keymap.set('n', '<leader>sh', telescope_builtin.highlights)
vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
    { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sp', telescope_builtin.pickers)

-- LSP
vim.keymap.set('n', '<leader>lr', telescope_builtin.lsp_references)
vim.keymap.set('n', '<leader>ls', telescope_builtin.lsp_document_symbols)
vim.keymap.set('n', '<leader>lw', telescope_builtin.lsp_workspace_symbols)
vim.keymap.set('n', '<leader>lo', telescope_builtin.lsp_dynamic_workspace_symbols)
vim.keymap.set('n', '<leader>ld', telescope_builtin.diagnostics)
vim.keymap.set('n', '<leader>li', telescope_builtin.lsp_implementations)
vim.keymap.set('n', '<leader>le', telescope_builtin.lsp_definitions)
vim.keymap.set('n', '<leader>lt', telescope_builtin.lsp_type_definitions)
vim.keymap.set('n', '<leader>ld', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<C-A-n>', telescope_builtin.treesitter, { desc = 'Find treesitter symbols' })

-- GIT
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files)
vim.keymap.set('n', '<leader>gc', telescope_builtin.git_commits)
vim.keymap.set('n', '<leader>gd', telescope_builtin.git_bcommits)
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches)
vim.keymap.set('n', '<leader>gt', telescope_builtin.git_status)
vim.keymap.set('n', '<leader>gh', telescope_builtin.git_stash)

-- List pickers
vim.keymap.set('n', '<leader>sb', telescope_builtin.builtin, { desc = '[S]earch Telescope [B]uiltin searches' })
vim.keymap.set('n', '<leader>sp', telescope_builtin.reloader, { desc = '[S]earch [P]ackages and reload on <cr>' })
vim.keymap.set('n', '<leader>sy', telescope_builtin.symbols)
