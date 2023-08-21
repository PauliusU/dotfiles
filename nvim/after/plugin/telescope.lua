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
vim.keymap.set('n', '<leader>sq', telescope_builtin.quickfix, { desc = '[S]earch [Q]uickfix' })
vim.keymap.set('n', '<leader>sl', telescope_builtin.loclist, { desc = '[S]earch [L]ocation list' })
vim.keymap.set('n', '<leader>sj', telescope_builtin.jumplist, { desc = '[S]earch [J]umplist' })
vim.keymap.set('n', '<leader>so', telescope_builtin.vim_options, { desc = '[S]earch [O]ptions' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>sa', telescope_builtin.autocommands, { desc = '[S]earch [A]utocommands' })
vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eyboard shortcuts' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.filetypes, { desc = '[S]earch [F]iletypes' })
vim.keymap.set('n', '<leader>sh', telescope_builtin.highlights, { desc = '[S]earch [H]ighlights' })
vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
    { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sp', telescope_builtin.pickers, { desc = '[S]earch [P]ickers' })

-- LSP
vim.keymap.set('n', '<leader>lr', telescope_builtin.lsp_references, { desc = 'Search [L]SP [R]eferences' })
vim.keymap.set('n', '<C-A-n>', telescope_builtin.lsp_document_symbols, { desc = 'Search LSP document Symbols' })
vim.keymap.set('n', '<leader>lw', telescope_builtin.lsp_workspace_symbols, { desc = 'Search [L]SP workspace [S]ymbols' })
vim.keymap.set('n', '<leader>lo', telescope_builtin.lsp_dynamic_workspace_symbols,
    { desc = 'Search [L]SP dynamic workspace symb[O]ls' })
vim.keymap.set('n', '<leader>ld', telescope_builtin.diagnostics, { desc = 'Search [L]SP [D]iagnostics' })
vim.keymap.set('n', '<leader>li', telescope_builtin.lsp_implementations, { desc = 'Search [L]SP [I]mplementations' })
vim.keymap.set('n', '<leader>le', telescope_builtin.lsp_definitions, { desc = 'Search [L]SP d[E]finitions' })
vim.keymap.set('n', '<leader>lt', telescope_builtin.lsp_type_definitions, { desc = 'Search [L]SP [T]ype definitions' })
vim.keymap.set('n', '<leader>ls', telescope_builtin.treesitter, { desc = 'Find treesitter [S]ymbols' })

-- GIT
vim.keymap.set('n', '<leader>gf', telescope_builtin.git_files, { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>gc', telescope_builtin.git_commits, { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>gu', telescope_builtin.git_bcommits, { desc = '[G]it buffer`s commits (with [D]iff)' })
vim.keymap.set('n', '<leader>gb', telescope_builtin.git_branches, { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>gt', telescope_builtin.git_status, { desc = '[G]it s[T]atus' })
vim.keymap.set('n', '<leader>ga', telescope_builtin.git_stash, { desc = '[G]it st[a]sh' })

-- List pickers
vim.keymap.set('n', '<leader>sb', telescope_builtin.builtin, { desc = '[S]earch Telescope [B]uiltin searches' })
vim.keymap.set('n', '<leader>sp', telescope_builtin.reloader, { desc = '[S]earch [P]ackages and reload on <cr>' })
vim.keymap.set('n', '<leader>sy', telescope_builtin.symbols, { desc = '[S]earch s[Y]mbols' })
