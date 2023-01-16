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

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if packer_bootstrap then
    require('packer').sync()
end

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

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
