local separator = { '"▏"', color = 'StatusLineNonText' }

require('lualine').setup({
  options = {
    section_separators = '',
    component_separators = '',
    theme ='jellybeans',
    ignore_focus = {
      "dapui_watches", "dapui_breakpoints",
      "dapui_scopes", "dapui_console",
      "dapui_stacks", "dap-repl"
    }
  },
})
