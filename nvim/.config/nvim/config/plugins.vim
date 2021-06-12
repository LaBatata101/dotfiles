call plug#begin('~/.config/nvim/plugged')

" status line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" icons for NERDTree, status line, etc.
Plug 'ryanoasis/vim-devicons'

Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Color Scheme
"Plug 'lifepillar/vim-solarized8'
"Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim' 
"Plug 'ajmwagar/vim-deus'
Plug 'morhetz/gruvbox'
"Plug 'gerardbm/vim-atomic'
"Plug 'tyrannicaltoucan/vim-quantum'

" Python autocomplete
"Plug 'ncm2/ncm2'
"Plug 'ncm2/ncm2-path'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-pyclang', { 'for': 'python' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'for': 'python',
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }


" Syntax Checker
"Plug 'w0rp/ale', {'for': ['python', 'c']}

" Git on VIM
Plug 'tpope/vim-fugitive'

" Find file
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" AutoClose for parentesis etc
Plug 'cohama/lexima.vim'

" Surround
Plug 'tpope/vim-surround'

" For comment lines
" <leader>cc comment | <leader>cu uncomment
Plug 'scrooloose/nerdcommenter'

Plug 'Yggdroot/indentLine', { 'for': 'python' }
Plug 'editorconfig/editorconfig-vim'

" wiki
"Plug 'vimwiki/vimwiki'

"Plug 'amiorin/vim-project'


Plug 'majutsushi/tagbar', { 'for': ['c', 'python'] }
" Semantic highlight for python
Plug 'numirias/semshi', {
            \ 'for': 'python',
            \ 'do': ':UpdateRemotePlugins'
            \}
Plug 'voldikss/vim-floaterm'

"Plug 'liuchengxu/vista.vim'
"Plug 'pechorin/any-jump.vim'
filetype plugin indent on    " required
call plug#end()            " required
