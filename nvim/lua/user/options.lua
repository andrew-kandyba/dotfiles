local o = vim.opt

o.backup = false
o.clipboard = 'unnamedplus'
o.completeopt = 'menuone,longest,preview'
o.confirm = true
o.expandtab = true
o.fillchars:append({ eob = ' ', vert = " "})
o.ignorecase = true
o.list = true
o.listchars = { tab = '▸ ', trail = '·' }
o.number = true
o.relativenumber = true
o.scrolloff = 8
o.shiftwidth = 4
o.sidescrolloff = 8
o.signcolumn = 'yes:2'
o.smartcase = true
o.smartindent = true
o.softtabstop = 4
o.spell = true
o.splitbelow = true
o.splitright = true
o.tabstop = 4
o.termguicolors = true
o.title = true
o.undofile = true
o.wildmode = 'longest:full,full'
o.wrap = false
