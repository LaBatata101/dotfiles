call plug#begin('~/.config/nvim/plugged')

" status line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" icons for NERDTree, status line, etc.
Plug 'ryanoasis/vim-devicons'
" colors for vim-devicons
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Color Scheme
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'

" Python autocomplete
Plug 'roxma/nvim-completion-manager'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-jedi'
Plug 'Shougo/echodoc.vim'
" Syntax Checker
"Plugin 'scrooloose/syntastic'
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'w0rp/ale', {'for': 'python'}
Plug 'tell-k/vim-autopep8', {'for': 'python'}

" Git on VIM
Plug 'tpope/vim-fugitive'

" Find file
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" AutoClose for parentesis etc
Plug 'cohama/lexima.vim'

" For comment lines
" <leader>cc comment | <leader>cu uncomment
Plug 'scrooloose/nerdcommenter'

Plug 'Yggdroot/indentLine'
" undo tree
Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
filetype plugin indent on    " required
call plug#end()            " required
