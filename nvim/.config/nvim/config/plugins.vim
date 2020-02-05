call plug#begin('~/.config/nvim/plugged')

" status line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" icons for NERDTree, status line, etc.
Plug 'ryanoasis/vim-devicons'

Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Color Scheme
Plug 'lifepillar/vim-solarized8'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim' 
Plug 'ajmwagar/vim-deus'
Plug 'morhetz/gruvbox'

" Python autocomplete
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-path'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-pyclang'

" Syntax Checker
Plug 'w0rp/ale', {'for': ['python', 'c']}

" Git on VIM
Plug 'tpope/vim-fugitive'

" Find file
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" AutoClose for parentesis etc
Plug 'cohama/lexima.vim'

" Surround
Plug 'tpope/vim-surround'

" For comment lines
" <leader>cc comment | <leader>cu uncomment
Plug 'scrooloose/nerdcommenter'

Plug 'Yggdroot/indentLine'
Plug 'editorconfig/editorconfig-vim'

" wiki
"Plug 'vimwiki/vimwiki'

Plug 'amiorin/vim-project'

Plug 'Shougo/neco-vim', { 'for': 'vim' }
Plug 'tyrannicaltoucan/vim-quantum'

Plug 'majutsushi/tagbar', { 'for': ['c', 'python'] }
" Semantic highlight for python
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

Plug 'liuchengxu/vista.vim'
filetype plugin indent on    " required
call plug#end()            " required
