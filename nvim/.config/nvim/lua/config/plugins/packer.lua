local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use 'onsails/lspkind-nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'simrat39/rust-tools.nvim'
  use 'ray-x/lsp_signature.nvim'
  use 'folke/lsp-colors.nvim'
  use {
    'folke/trouble.nvim',
    requires = "kyazdani42/nvim-web-devicons",
  }

  -- Show LSP load progress
  use 'j-hui/fidget.nvim'

  -- Show a 💡 when a code action is available
  use 'kosayoda/nvim-lightbulb'

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' }
    }
  }

  -- Snippet
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Themes
  use 'folke/tokyonight.nvim'

  -- Identation Level Lines
  use 'lukas-reineke/indent-blankline.nvim'

  -- Autoclose parentesis etc
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- Comment Code
  use 'numToStr/Comment.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Show tabs for open files
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Surround text with (), [], "", '' etc
  use 'tpope/vim-surround'

  -- Easily jump to far text
  use {
    'phaazon/hop.nvim',
    branch = 'v1'
  }

  -- Smooth scrolling
  use 'karb94/neoscroll.nvim'

  -- Highlight word under the cursor
  use 'RRethy/vim-illuminate'

  -- Fix/Perfomance improvements
  use 'antoinemadec/FixCursorHold.nvim'
  use 'nathom/filetype.nvim'
  use 'lewis6991/impatient.nvim'

  use 'tweekmonster/startuptime.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
}})
