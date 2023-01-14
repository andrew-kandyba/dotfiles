local g = vim.g
local key = vim.keymap

g.mapleader = ' '
g.maplocalleader = ' '

-- When text is wrapped, move by terminal rows, not lines, unless a count is provided.
key.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
key.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting.
key.set('v', '<', '<gv')
key.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
key.set('v', 'y', 'myy`y')

-- Disable annoying command line typo.
key.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it.
key.set('v', 'p', '"_dP')

 -- Easy insertion of a trailing ; or , from insert mode.
key.set('i', ';;', '<Esc>A;')
key.set('i', ',,', '<Esc>A,')

 -- Quickly clear search highlighting.
key.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Move lines up and down.
key.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
key.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
key.set('n', '<A-j>', ':move .+1<CR>==')
key.set('n', '<A-k>', ':move .-2<CR>==')
key.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
key.set('v', '<A-k>', ":move '<-2<CR>gv=gv")
