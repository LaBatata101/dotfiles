let g:python3_host_prog = '/usr/bin/python'
" disable python 2 support
let g:loaded_python_provider = 0
" skip python 2 check
let g:python_host_skip_check = 1

let updatetime=300

set cursorline
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
set clipboard=unnamedplus

" number lines
set number 
set rnu

" set leader key
let mapleader = " " 

" automatically change window's cwd to file's
" dir
"set autochdir

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

set wildignore+=*.o,*.pyc,.git/*,__pycache__/*

command! Cheatsheet :e $HOME/.config/nvim/config/cheatsheet.txt
