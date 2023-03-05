local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

require('packer').reset()

require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

local use = require('packer').use

use 'wbthomason/packer.nvim'

use('tpope/vim-surround')
use('tpope/vim-commentary')
use('tpope/vim-unimpaired')
use('tpope/vim-sleuth')
use('tpope/vim-repeat')
use('sheerun/vim-polyglot')
use('farmergreg/vim-lastplace')
use('nelstrom/vim-visual-star-search')
use('jessarcher/vim-heritage')
use('ray-x/go.nvim')
use('ray-x/guihua.lua')

-- Automatically set the working directory to the project root.
 use({
   'airblade/vim-rooter',
   setup = function()
     -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
     vim.g.rooter_manual_only = 1
   end,
   config = function()
     vim.cmd('Rooter')
   end,
 })

-- Automatically add closing brackets, quotes, etc.
 use({
   'windwp/nvim-autopairs',
   config = function()
     require('nvim-autopairs').setup()
   end,
 })

-- Add smooth scrolling to avoid jarring jumps
 use({
   'karb94/neoscroll.nvim',
   config = function()
     require('neoscroll').setup()
   end,
 })

-- Split arrays and methods onto multiple lines, or join them back up.
 use({
   'AndrewRadev/splitjoin.vim',
   config = function()
     vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
     vim.g.splitjoin_trailing_comma = 1
     vim.g.splitjoin_php_method_chain_full = 1
   end,
 })

 -- Automatically fix indentation when pasting code.
 use({
   'sickill/vim-pasta',
   config = function()
     vim.g.pasta_disabled_filetypes = { 'fugitive' }
   end,
 })

 use({
   'nvim-telescope/telescope.nvim',
   requires = {
     'nvim-lua/plenary.nvim',
     'kyazdani42/nvim-web-devicons',
     'nvim-telescope/telescope-live-grep-args.nvim',
     { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
   },
   config = function()
     require('user/plugins/telescope')
   end,
 })

 -- File tree sidebar
 use({
   'kyazdani42/nvim-tree.lua',
   requires = 'kyazdani42/nvim-web-devicons',
   config = function()
     require('user/plugins/nvim-tree')
   end,
 })

-- A status line
use({
   'nvim-lualine/lualine.nvim',
   requires = 'kyazdani42/nvim-web-devicons',
   config = function()
     require('user/plugins/lualine')
   end,
 })

 -- Display indentation lines.
 use({
   'lukas-reineke/indent-blankline.nvim',
   config = function()
     require('user/plugins/indent-blankline')
   end,
 })

-- Display buffers as tabs.
 use({
   'akinsho/bufferline.nvim',
   requires = 'kyazdani42/nvim-web-devicons',
   config = function()
     require('user/plugins/bufferline')
   end,
 })

-- Colorscheme
vim.cmd.colorscheme('habamax')

vim.api.nvim_set_hl(0, 'FloatBorder', {
    fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
})

vim.api.nvim_set_hl(0, 'VertSplit', {
    guifg = fg,
    guibg = bg,
})

vim.api.nvim_set_hl(0, 'CursorLineBg', {
    fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
})

vim.api.nvim_set_hl(0, 'DiffChange', {
    guibg = none,
})

-- Git integration.
use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup()
    vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
    vim.keymap.set('n', 'gr', ':Gitsigns reset_hunk<CR>')
    vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
  end,
})

-- Git commands.
use({
  'tpope/vim-fugitive',
  requires = 'tpope/vim-rhubarb',
})
-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = function()
    require('nvim-treesitter.install').update({ with_sync = true })
  end,
  requires = {
    'JoosepAlviste/nvim-ts-context-commentstring',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('user/plugins/treesitter')
  end,
})

-- Language Server Protocol.
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim'
  },
  config = function()
    require('user/plugins/lspconfig')
  end,
})

-- Completion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('user/plugins/cmp')
  end,
})

-- Debugging
use({
    'mfussenegger/nvim-dap',
    config = function()
      require('user/plugins/debugging')
    end,
})

use({
  'rcarriga/nvim-dap-ui',
  config = function()
      require('dapui').setup()
  end,
})

use({
  'leoluz/nvim-dap-go',
  config = function()
    require('dap-go').setup()
  end,
})

use({'nvim-telescope/telescope-dap.nvim'})

use({
  'theHamsta/nvim-dap-virtual-text',
  config = function()
    require('nvim-dap-virtual-text').setup()
  end,
})

if packer_bootstrap then
    require('packer').sync()
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

