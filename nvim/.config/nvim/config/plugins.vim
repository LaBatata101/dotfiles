"--------------------------------------------------------------------------"
" Color	Scheme							      	   "
" -------------------------------------------------------------------------"
set termguicolors
"set background=dark
let g:onedark_allow_italics = 1
let g:neodark#use_256color = 1
colorscheme neodark


"--------------------------------------------------------------------------"
" indentLine                                                               "
"--------------------------------------------------------------------------"
let g:indentLine_enabled = 1
let g:indentLine_char = '│'

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
highlight ALEErrorSign ctermfg=9
highlight ALEWarningSign ctermfg=226
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠ '
let g:ale_fixers = {
    \ 'python':['autopep8']
    \}
let g:ale_linters = {
      \ 'python':['flake8'],
      \}
let g:ale_python_flake8_options = '--max-line-length=120 --ignore=E701,W191'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 20
let g:ale_lint_on_enter = 1
let g:ale_open_list = 1 
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_keep_list_window_open = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_statusline_format = ['⨉ %d','⚠  %d','✔ OK']
let g:ale_lint_on_save = 1

"--------------------------------------------------------------------------"
" AutoPep8                                                                 "
"--------------------------------------------------------------------------"
let g:autopep8_indent_size=4
let g:autopep8_max_line_length=120
let g:autopep8_ignore="E701,W191"

"--------------------------------------------------------------------------"
"    Jedi-VIM Config                                                       "
"--------------------------------------------------------------------------"
"autocmd FileType python setlocal completeopt-=preview

"--------------------------------------------------------------------------"
"      SimpylFold Config						   "
"--------------------------------------------------------------------------"
let g:SimpylFold_docstring_preview=1

"--------------------------------------------------------------------------"
"     DevIcons                                                             "
"--------------------------------------------------------------------------"
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

"---------------------------------------------------------------------------------
"Undo Tree
"---------------------------------------------------------------------------------
if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

" nvim-completion-manager
"---------------------------------------------------------------------------------
let g:cm_completeopt = 'menu,menuone,noinsert,noselect,preview'

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
