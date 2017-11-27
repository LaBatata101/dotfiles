" Your minimal init.vim/vimrc
call plug#begin('~/.config/nvim/minimal-plug') 

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'}                                                         
Plug 'zchee/deoplete-jedi' 
Plug 'Shougo/echodoc.vim'

Plug 'itchyny/lightline.vim'
Plug 'mgee/lightline-bufferline'
filetype plugin indent on
call plug#end()

let g:python3_host_prog = '/usr/bin/python3'               
" disable python 2 support                                 
let g:loaded_python_provider = 1                           
 "let g:deoplete#enable_yarp=1                              
set rtp+=~/.config/nvim/minimal-plug/deoplete.nvim/     
set rtp+=~/.config/nvim/minimal-plug/echodoc.vim
let g:deoplete#enable_at_startup = 1                       
let g:echodoc#enable_at_sartup = 1
autocmd FileType python setlocal omnifunc=python3complete#Complete   
set noshowmode


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

"function! MyFiletype()
  "return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
"endfunction

"function! MyFileformat()
  "return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol()) : ''
"endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

"function! LightlineFugitive()
  "if exists('*fugitive#head')
    "let branch = fugitive#head()
    "return branch !=# '' ? ''.branch : ''
  "endif
  "return ''
"endfunction

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
