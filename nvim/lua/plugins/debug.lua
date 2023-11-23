-- Debugging
return {
    'mfussenegger/nvim-dap', -- DAP client for nvim
    dependencies = {
        -- Creates a beautiful debugger UI
        'rcarriga/nvim-dap-ui',

        -- Installs the debug adapters for you
        'williamboman/mason.nvim',
        'jay-babu/mason-nvim-dap.nvim',

        -- Go
        'leoluz/nvim-dap-go',

        -- Node.js.
        -- adapter that allows Neovim (through the nvim-dap) to communicate with JavaScript and interestingly, it’s the same adapter used in VS Code.
        "mxsdev/nvim-dap-vscode-js",
        { -- download and build a copy of vscode-js-debug in order to use plugin above
            "microsoft/vscode-js-debug",
            -- build "microsoft/vscode-js-debug" from sorce
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
        },
        -- parsing of json with comments for launch.json files generated by VS Code users
        { 'Joakker/lua-json5', build = './install.sh' },

    },
    config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Nicer breakpoint icons instead of default 'B'
        vim.fn.sign_define('DapBreakpoint', { text = '🟥', texthl = '', linehl = '', numhl = '' })
        vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

        require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want
                'delve', -- Go
            },
        }

        require("dap-vscode-js").setup({
            -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
            -- Use lazy path instead of default packer path
            debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
            adapters = { 'chrome', 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node',
                'chrome' }, -- which adapters to register in nvim-dap
        })

        local js_based_languages = {
            "typescript",
            "javascript",
            "typescriptreact",
            "svelte",
            "vue"
        }

        for _, language in ipairs(js_based_languages) do
            require("dap").configurations[language] = {
                { -- single Node.js files
                    -- use nvim-dap-vscode-js's pwa-node debug adapter
                    type = "pwa-node",
                    -- launch a new process to attach the debugger to
                    request = "launch",
                    -- name of the debug action you have to select for this config
                    name = "Launch current file in new node process",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    -- for compiled languages like TypeScript or Svelte.js
                    sourceMaps = true,
                },
                { -- node processes like express applications
                    -- attach to a node process that has been started with
                    -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
                    -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
                    --
                    -- use nvim-dap-vscode-js's pwa-node debug adapter
                    type = "pwa-node",
                    -- attach to an already running node process with --inspect flag
                    -- default port: 9222
                    request = "attach",
                    -- name of the debug action
                    name = "Attach debugger to existing `node --inspect` process",
                    -- allows us to pick the process using a picker
                    processId = require 'dap.utils'.pick_process,
                    -- for compiled languages like TypeScript or Svelte.js
                    sourceMaps = true,
                    -- resolve source maps in nested locations while ignoring node_modules
                    resolveSourceMapLocations = { "${workspaceFolder}/**",
                        "!**/node_modules/**" },
                    -- path to src in vite based projects (and most other projects as well)
                    -- cwd = "${workspaceFolder}",
                    cwd = "${workspaceFolder}/src",
                    -- we don't want to debug code inside node_modules, so skip it!
                    skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
                },
                { -- web applications
                    -- use nvim-dap-vscode-js's pwa-chrome debug adapter
                    type = "pwa-chrome",
                    request = "launch",
                    -- name of the debug action
                    name = "Launch \"localhost\" in Chrome to debug client side code",
                    url = "http://localhost:3000",
                    -- for TypeScript/Svelte
                    sourceMaps = true,
                    webRoot = "${workspaceFolder}",
                    protocol = "inspector",
                    port = 9222,
                    -- skip files from vite's hmr
                    skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
                    -- save Chrome profile in a file
                    userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
                }
            }
        end

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'debug: Start/Continue' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'debug: Step Over' })
        vim.keymap.set('n', '<F4>', dap.step_into, { desc = 'debug: Step Into' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'debug: Step Into' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'debug: Step Out' })
        vim.keymap.set('n', '<S-F11>', dap.step_out, { desc = 'debug: Step Out' })
        vim.keymap.set('n', '<F9>', dap.toggle_breakpoint, { desc = 'debug: Toggle Breakpoint 2' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'debug: Toggle Breakpoint' })
        vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end, { desc = 'debug: Set Breakpoint' })

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        }

        -- dap.listeners.after.event_initialized["dapui_config"] = function()
        --     dapui.open({})
        -- end
        -- dap.listeners.before.event_terminated["dapui_config"] = function()
        --     dapui.close({})
        -- end
        -- dap.listeners.before.event_exited["dapui_config"] = function()
        --     dapui.close({})
        -- end

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'debug: See last session result.' })

        -- Install golang specific config
        require('dap-go').setup()
    end,
}
