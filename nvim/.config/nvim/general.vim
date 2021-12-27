let g:python3_host_prog = '/usr/bin/python'
" disable python 2 support
let g:loaded_python_provider = 0
" skip python 2 check
let g:python_host_skip_check = 1

" set updatetime=1000 " 1 sec

" in millisecond, used for both CursorHold and CursorHoldI,
" use updatetime instead if not defined
let g:cursorhold_updatetime = 350

set mouse=a

set cursorline
set nohlsearch
set noshowmode

" allow buffer switching without saving
set hidden  

" always show tabline
set showtabline=2  

" clipboard do sistema
set clipboard=unnamedplus

" number lines
set number 
set rnu

" set leader key
let mapleader = " " 

set colorcolumn=120

" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5

" tab indentation
set expandtab
set ts=4
set sw=4
set sts=0

set undolevels=1000

set wildignore+=*.o,*.pyc,.git/*,__pycache__/*

set termguicolors

set completeopt=menu,menuone,noselect

set autoindent

set signcolumn=yes

set pumblend=20
