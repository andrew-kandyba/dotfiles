local key = vim.keymap

key.set('n', '<F5>', ":lua require'dap'.continue()<CR>")
key.set('n', '<F7>', ":lua require'dap'.step_over()<CR>")
key.set('n', '<F6>', ":lua require'dap'.step_into()<CR>")
key.set('n', '<F8>', ":lua require'dap'.step_out()<CR>")
key.set('n', '<leader>br', ":lua require'dap'.toggle_breakpoint()<CR>")
key.set("n", "<leader>BR", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
key.set("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
