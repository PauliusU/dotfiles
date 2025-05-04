return {
    'nvim-tree/nvim-tree.lua',
    desc = 'A File Explorer For Neovim Written In Lua',
    cmd = { 'NvimTreeFindFileToggle' }, -- lazy load the plugin if command is run
    keys = {                            -- also lazy loads if any of the listed keymaps are pressed
        { '<leader>i', '<cmd>NvimTreeFindFileToggle<CR>', desc = 'nvim-tree: find file in file tree' }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
    config = function()
        -- -- Disable netrw at the very start of your init.lua (strongly advised)
        -- -- but 'gx' will stop working
        -- vim.g.loaded_netrw = 1
        -- vim.g.loaded_netrwPlugin = 1

        -- Set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        -- Ref: https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#sorting-files-naturally-respecting-numbers-within-files-names
        local function natural_cmp(left, right)
            left = left.name:lower()
            right = right.name:lower()

            if left == right then
                return false
            end

            for i = 1, math.max(string.len(left), string.len(right)), 1 do
                local l = string.sub(left, i, -1)
                local r = string.sub(right, i, -1)

                if type(tonumber(string.sub(l, 1, 1))) == "number" and type(tonumber(string.sub(r, 1, 1))) == "number" then
                    local l_number = tonumber(string.match(l, "^[0-9]+"))
                    local r_number = tonumber(string.match(r, "^[0-9]+"))

                    if l_number ~= r_number then
                        return l_number < r_number
                    end
                elseif string.sub(l, 1, 1) ~= string.sub(r, 1, 1) then
                    return l < r
                end
            end
        end

        -- Default options: https://github.com/nvim-tree/nvim-tree.lua/blob/aaee4cd896b74f85a81bed7eef2db7869960c4d0/lua/nvim-tree.lua#L361
        require("nvim-tree").setup({
            sort_by = function(nodes)
                table.sort(nodes, natural_cmp)
            end,
            view = {
                side = "right", -- Set the tree to appear on the right-hand side
                width = 40,     -- Make panel broader. Default: 30
            },
            filters = {
                git_ignored = false,   -- Shows git ignored files in the tree
                custom = { '^.git$' }, -- Hides .git folder in the tree
            },
            renderer = {
                highlight_git = true, -- Highlight git status
                -- highlight_opened_files = "all",                          -- Highlight opened files
                -- root_folder_modifier = ":t",                             -- Show only the file name in the tree
                -- full_name = false,                                       -- Show full path in the tree
                -- group_empty = true,                                      -- Group empty folders
                -- special_files = { "README.md", "Makefile", "MAKEFILE" }, -- Special files to be highlighted
                indent_markers = {
                    enable = true,
                },
                -- icons = {
                --     git_placement = "signcolumn",
                --     show = {
                --         file = true,
                --         folder = false,
                --         folder_arrow = false,
                --         git = true,
                --     },
                -- },
            },
        })
    end
}
