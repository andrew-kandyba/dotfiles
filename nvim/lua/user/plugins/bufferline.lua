require('bufferline').setup({
  options = {
    indicator = {
      icon = ' ',
    },
    show_close_icon = false,
    tab_size = 0,
    max_name_length = 25,
    offsets = {
      {
        filetype = 'NvimTree',
        text = '  Files',
        highlight = 'NormalFloat',
        text_align = 'left',
      },
    },
    modified_icon = '',
    custom_areas = {
      left = function()
        return {
          { text = ' 🦄 ', fg = '#8fff6d' },
        }
      end,
    },
  },
  highlights = {
    fill = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
      fg = { attribute = 'fg', highlight = 'NormalFloat' },
    },
    background = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    tab = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
      fg = { attribute = 'fg', highlight = 'NormalFloat' },
    },
    tab_close = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    close_button = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
      fg = { attribute = 'fg', highlight = 'NormalFloat' },
    },
    close_button_visible = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
      fg = { attribute = 'fg', highlight = 'NormalFloat' },
    },
    close_button_selected = {
      fg = { attribute = 'fg', highlight = 'NormalFloat' },
    },
    buffer_visible = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    modified = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    modified_visible = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    duplicate = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    duplicate_visible = {
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    separator = {
      fg = { attribute = 'bg', highlight = 'NormalFloat' },
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
    separator_selected = {
      fg = { attribute = 'bg', highlight = 'NormalFloat' },
      bg = { attribute = 'bg', highlight = 'NormalFloat' }
    },
    separator_visible = {
      fg = { attribute = 'bg', highlight = 'NormalFloat' },
      bg = { attribute = 'bg', highlight = 'NormalFloat' },
    },
  },
})
