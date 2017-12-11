
let g:python3_host_prog = '/usr/bin/python3'
" disable python 2 support
let g:loaded_python_provider = 1

"set rtp+=~/.config/nvim/plugged/deoplete.nvim/
"set rtp+=~/.config/nvim/plugged/echodoc.vim/
"let g:deoplete#enable_at_startup = 1
"let g:echodoc#enable_at_sartup = 1
""autocmd FileType python setlocal omnifunc=python3complete#Complete
"let g:deoplete#omni#input_patterns = {}
"let g:deoplete#omni#input_patterns.python3 = '\.'
"autocmd CompleteDone * silent! pclose!
set nohlsearch
set noshowmode
" allow buffer switching without saving
set hidden  
" always show tabline
set showtabline=2  

" utf8 support
set encoding=utf8 

" vim devicons setup
set guifont=Droid\ Sans\ Mono\ for\ Nerd\ 11

" clipboard do sistema
set clipboard^=unnamedplus,unnamed 

" number lines
set number 

" set leader key
let mapleader = "," 

" automatically change window's cwd to file's
" dir
set autochdir

set colorcolumn=120
" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5

" Enable folding
set foldmethod=indent
set foldlevel=99

" tab indentation
set expandtab
set ts=4
set sw=4
set sts=0

set fileformat=unix

let python_highlight_all = 1
syntax on

set  undolevels=1000

" Open NERDTree when Vim startsup and no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
