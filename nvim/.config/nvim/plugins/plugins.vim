let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: debug wiht dap
call plug#begin(data_dir . '/plugged')

" LSP Stuff
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'onsails/lspkind-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'simrat39/rust-tools.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'folke/lsp-colors.nvim'

Plug 'folke/trouble.nvim'

" Show a 💡 when a code action is available
Plug 'kosayoda/nvim-lightbulb'

" Completion
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'

" Color Theme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

" Identation Level Lines
Plug 'lukas-reineke/indent-blankline.nvim'

" Autoclose parentesis etc
Plug 'windwp/nvim-autopairs'

" Comment Code
Plug 'numToStr/Comment.nvim'

" Misc
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim'

Plug 'tpope/vim-surround'
Plug 'phaazon/hop.nvim'

" Snippets
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Smooth scrolling
Plug 'karb94/neoscroll.nvim'

" Highlight word under the cursor
Plug 'RRethy/vim-illuminate'

" Fix/Perfomance improvements
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nathom/filetype.nvim'
Plug 'lewis6991/impatient.nvim'

Plug 'tweekmonster/startuptime.vim'
call plug#end()
