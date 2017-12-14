" Author: LaBatata101
" Last Update: 2017/11/11
"--------------------------------------------------------------------------"
" Commands:
"   <leader> = ,
"<
"   <leader>cc  ->  comment line
"   <leader>cu  ->  uncomment line
"   <leader>s   ->  save file
"   <leader>r   ->  source file
"   <leader>k   ->  close buffer
"   <leader>q   ->  quit vim
"   <leader>e	->  execute python file
"   <space>     ->  fold
"   Ctrl-P      ->  FuzzyFinder
"   Ctrl-A      ->  previus buffer
"   Ctrl-D      ->  next buffer
"   <F2>        ->  NERDTree
"   <F5>        ->  Show White Spaces
"--------------------------------------------------------------------------"

"set nocompatible              " required
"filetype off                  " required

call plug#begin('~/.vim/plugged')

" status line
Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'

" icons for NERDTree, status line, etc.
Plug 'ryanoasis/vim-devicons'
" colors for vim-devicons
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" correct folding for python
Plug 'tmhedberg/SimpylFold', { 'for': 'python' }
" indent when hit enter for (parentheses), [brackets], {braces}
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }

" Color Scheme
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'

" Python autocomplete
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Syntax Checker
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'w0rp/ale', {'for': 'python'}
Plug 'tell-k/vim-autopep8', {'for': 'python'}

" Git on VIM
Plug 'tpope/vim-fugitive'

" Find file
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" AutoClose for parentesis etc
Plug 'jiangmiao/auto-pairs'

" For comment lines
" <leader>cc comment | <leader>cu uncomment
Plug 'scrooloose/nerdcommenter'

" display vertical at each indentation level
Plug 'Yggdroot/indentLine'
" undo tree
Plug 'mbbill/undotree'
Plug 'editorconfig/editorconfig-vim'
Plug 'majutsushi/tagbar', { 'on': 'TagBar' }
filetype plugin indent on    " required
call plug#end()            " required

"--------------------------------------------------------------------------"
" Basic Config                     					   "
"--------------------------------------------------------------------------"
set backspace=indent,eol,start

"set noshowmode
" allow buffer switching without saving
set hidden  
" always show tabline
set showtabline=2  

" utf8 support
set encoding=utf8 

" vim devicons setup
set guifont=Droid\ Sans\ Mono\ for\ Nerd\ 11

" clipboard do sistema
set clipboard=unnamed 

" number lines
set number 
" relative number line
set rnu

" set leader key
let mapleader = "," 

" Caso o arquivo seja modificado FORA do vim 
" ele é atualizado DENTRO do vim
set autoread

" automatically change window's cwd to file's
" dir
set autochdir

set colorcolumn=120

set noshowmode
" Start scrolling slightly before the cursor reaches an edge
set scrolloff=5
set sidescrolloff=5

" highlight search results
set hlsearch
" clear the highlight
" map <leader>c :noh<CR>

" set incremental search, like modern browser
set incsearch
" enhanced command line completion
set wildmenu
" show incomplete commands
set showcmd

" change buffer
map <leader>a :bp<CR>
map <leader>s :bn<CR>

" split navigations
map <C-S-J> <C-W><C-J>
map <C-S-K> <C-W><C-K>
map <C-S-L> <C-W><C-L>
map <C-S-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" tab indentation
set autoindent
set expandtab
set ts=4
set sw=4
set sts=0
set smarttab

set fileformat=unix

" Enable folding with the spacebar
nnoremap <space> za

let python_highlight_all = 1
syntax on

" source it
map <leader>r :source %<CR>
" save file
map <leader>s :w<CR>
" close buffer
map <leader>k :bd<CR>
" quit vim
map <leader>q :x<CR>
" execute python file
map <leader>e :!python3 %<CR>

set  undolevels=1000

" show tabs whithespaces
nnoremap <F6> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$,space:. list! list? <CR>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

autocmd FileType python noremap <buffer> <leader>t :<C-u>Autopep8<CR>
"--------------------------------------------------------------------------"
" Color	Scheme							      	   "
" -------------------------------------------------------------------------"
"set termguicolors
set background=dark
let g:one_allow_italics = 1
colorscheme one 


"--------------------------------------------------------------------------"
" indentLine                                                               "
"--------------------------------------------------------------------------"
let g:indentLine_enabled = 1
let g:indentLine_char = '▏'
let g:indentLine_color_term = 239

"--------------------------------------------------------------------------"
" Powerline setup                                                          "
"--------------------------------------------------------------------------"

set laststatus=2
    if !has('gui_running')
  set t_Co=256
endif

"--------------------------------------------------------------------------"
" A.L.E Configuration							   "
"--------------------------------------------------------------------------"
highlight ALEErrorSign ctermfg=160
highlight ALEWarningSign ctermfg=226
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠ '
let g:ale_linters = {
      \ 'python':['flake8'],
      \}
let g:ale_python_flake8_options = '--max-line-length=120 --ignore=E701,W191'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 50
let g:ale_lint_on_enter = 1
let g:ale_open_list = 1 
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_keep_list_window_open = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['⨉ %d','⚠  %d','✔ OK']
let g:ale_lint_on_save = 1

"--------------------------------------------------------------------------"
" FuzzyFinder								   "
"--------------------------------------------------------------------------"
" map FuzzyFinder to Ctrl-P
map <C-P> :FZF<CR>

"--------------------------------------------------------------------------"
" NERDTree								   "
"--------------------------------------------------------------------------"
" Open NERDTree when Vim startsup and no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
map <F2> :NERDTreeToggle<CR>

"--------------------------------------------------------------------------"
" AutoPep8                                                                 "
"--------------------------------------------------------------------------"
let g:autopep8_indent_size=4
let g:autopep8_max_line_length=120
let g:autopep8_ignore="E701,W191"

"--------------------------------------------------------------------------"
"    Jedi-VIM Config                                                       "
"--------------------------------------------------------------------------"
autocmd FileType python setlocal completeopt-=preview

"--------------------------------------------------------------------------"
"      SimpylFold Config						   "
"--------------------------------------------------------------------------"
let g:SimpylFold_docstring_preview=1

"--------------------------------------------------------------------------"
"     DevIcons                                                             "
"--------------------------------------------------------------------------"
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

"--------------------------------------------------------------------------"
" Status Line								   "
"--------------------------------------------------------------------------"
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \	  'left': [ [ 'mode', 'paste' ],
      \		    [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \	  'right': [ [ 'lineinfo' ],
      \		     [ 'percent' ],
      \		     [ 'fileformat', 'fileencoding', 'filetype', 'filesize' ] ]
      \ },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v│%LL',
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \	  'filesize': 'FileSize',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if (bytes >= 1024)
    let kbytes = bytes / 1024
  endif
  if (exists('kbytes') && kbytes >= 1000)
    let mbytes = kbytes / 1000
  endif

  if bytes <= 0
    return '0'
  endif

  if (exists('mbytes'))
    return mbytes . 'MB '
  elseif (exists('kbytes'))
    return kbytes . 'KB '
  else
    return bytes . 'B '
  endif
endfunction

let g:lightline.tabline = {'left': [['buffers']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

let g:lightline#bufferline#modified = ' +'
let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#unnamed = '[No Name]'

"---------------------------------------------------------------------------------
"Undo Tree
"---------------------------------------------------------------------------------
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter [/\?] :set hlsearch
    autocmd CmdlineLeave [/\?] :set nohlsearch
augroup END
