local dap = require('dap')
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: toggle breakpoint' })
vim.keymap.set('n', 'F5', dap.continue, { desc = 'Debug: continue' })
vim.keymap.set('n', 'F6', dap.step_out, { desc = 'Debug: step out' })
vim.keymap.set('n', 'F7', dap.step_into, { desc = 'Debug: step into' })
vim.keymap.set('n', 'F8', dap.step_over, { desc = 'Debug: step over' })

local dapui = require('dapui');
dapui.setup()
vim.keymap.set('n', 'F9', dapui.open, { desc = 'Debug: DAP UI open' })
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.after.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.after.event_exited['dapui_config'] = function()
    dapui.close()
end

