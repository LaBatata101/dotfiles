local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  print("Downloading packer...")
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd([[packadd packer.nvim]])
  print("packer.nvim installed")
end

vim.cmd([[ autocmd BufWritePost packer.lua source <afile> | PackerCompile ]])

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use { 'neovim/nvim-lspconfig', ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.lsp")
    end
  }
  use { 'onsails/lspkind-nvim', after = 'nvim-lspconfig' }
  use { 'ray-x/lsp_signature.nvim', after = 'nvim-lspconfig',
    config = function()
      require("config.plugins.lsp_signature")
    end
  }
  use { 'folke/lsp-colors.nvim', after = 'nvim-lspconfig' }
  use { 'simrat39/rust-tools.nvim', ft = 'rust' }
  use 'williamboman/nvim-lsp-installer'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.treesitter")
    end
  }

  use {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    -- keys = {'<leader>td', 'gr'},
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("config.plugins.trouble")
    end
  }

  -- Show LSP load progress
  use {
    'j-hui/fidget.nvim',
    ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.fidget")
    end
  }

  -- Show a 💡 when a code action is available
  use { 'kosayoda/nvim-lightbulb', after = 'nvim-lspconfig',
    config = function()
      require("config.plugins.lightbulb")
    end
  }

  -- Completion
  use {
    'hrsh7th/nvim-cmp',
    module = 'cmp',
    event = 'InsertEnter',
    requires = {
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = { 'nvim-cmp', 'nvim-lspconfig' } },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = {'nvim-cmp', 'vim-vsnip'} }
    }
  }

  -- Snippet
  use {
    'hrsh7th/vim-vsnip',
    ft = vim.g.supported_languages,
    event = 'InsertEnter'
  }
  use {
    'hrsh7th/vim-vsnip-integ',
    after = 'vim-vsnip'
  }

  -- Themes
  use 'folke/tokyonight.nvim'

  -- Identation Level Lines
  use  { 'lukas-reineke/indent-blankline.nvim', ft = vim.g.supported_languages,
    config = function ()
      require("config.plugins.indent_blankline")
    end
  }

  -- Autoclose parentesis etc
  use {
    'windwp/nvim-autopairs',
    after = 'nvim-cmp',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- Comment Code
  use 'numToStr/Comment.nvim'

  use {
    'nvim-telescope/telescope.nvim',
    cmd = { 'Telescope', 'RustDebuggables' },
    -- keys = {'<leader>ff', '<leader>fg', '<leader>fb', 'ga'},
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-ui-select.nvim', module = "telescope._extensions.ui-select" }
    },
    config = function()
      require("config.plugins.telescope")
    end
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

  -- rename UI
  use {
    'filipdutescu/renamer.nvim',
    branch = 'master',
    requires = { 'nvim-lua/plenary.nvim' },
    after = 'nvim-lspconfig',
    config = function()
      require('renamer').setup()
    end
  }

  -- Smooth scrolling
  use 'karb94/neoscroll.nvim'

  -- Highlight word under the cursor
  use 'RRethy/vim-illuminate'

  -- Fix/Perfomance improvements
  use { 'antoinemadec/FixCursorHold.nvim', event = 'BufReadPost' }
  use 'nathom/filetype.nvim'
  use 'lewis6991/impatient.nvim'

  -- Profile neovim startup time
  use 'tweekmonster/startuptime.vim'

  -- Debug
  use { 'mfussenegger/nvim-dap', ft = vim.g.supported_languages }
  use {
    "rcarriga/nvim-dap-ui",
    requires = {"mfussenegger/nvim-dap"},
    after = 'nvim-dap',
    config = function()
      require("config.plugins.dap")
    end
  }
  use {
    "Pocco81/DAPInstall.nvim",
    config = function()
      require("config.plugins.DAPInstall")
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if Packer_bootstrap then
    require('packer').sync()
  end
end,
config = {
  compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
}})
