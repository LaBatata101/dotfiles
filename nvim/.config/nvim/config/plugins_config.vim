"--------------------------------------------------------------------------"
" Color	Scheme							      	   "
" -------------------------------------------------------------------------"
set termguicolors
set background=dark
let g:onedark_allow_italics = 1
let g:neodark#use_256color = 1
"let g:quantum_black = 1
"let g:quantum_italics = 1
let gruvbox_italic = '1'
colorscheme gruvbox


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
"highlight ALEErrorSign ctermfg=9
"highlight ALEWarningSign ctermfg=226
"let g:ale_sign_error = '❌'
"let g:ale_sign_warning = '⚠️'
"let g:ale_fixers = {
    "\ 'python':['autopep8'],
    "\ 'c':['clang-format']
    "\}
"let g:ale_linters = {
      "\ 'python':['flake8'],
      "\ 'c':['clang'],
      "\}
let g:ale_python_flake8_options = '--max-line-length=120 --ignore=E701,W191,E402'
let g:ale_c_clangformat_options = '-style="{BasedOnStyle: google, IndentWidth: 4}"'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_delay = 10
let g:ale_lint_on_enter = 1
let g:ale_open_list = 0 
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5
"let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"let g:ale_statusline_format = ['⨉ %d','⚠  %d','✔ OK']
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_set_ballons = 1

"--------------------------------------------------------------------------"
" AutoPep8                                                                 "
"--------------------------------------------------------------------------"
let g:autopep8_indent_size=4
let g:autopep8_max_line_length=120
let g:autopep8_ignore="E701,W191"

"--------------------------------------------------------------------------"
"      SimpylFold Config						   "
"--------------------------------------------------------------------------"
let g:SimpylFold_docstring_preview=1


" ncm2
"--------------------------------------------------------------------------------------------------
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
"inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<CR>", 'n')

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

"let g:ncm2_pyclang#library_path = '/usr/lib/libclang.so'
"==================================================================================================

"--------------------------------------------------------------------------------------------------
" LanguageClient
"--------------------------------------------------------------------------------------------------
set hidden
"let g:LanguageClient_settingsPath = '/home/labatata/.config/nvim/settings.json'
"let g:LanguageClient_useFloatingHover = 1
"let g:LanguageClient_hoverPreview = 'Always'
"let g:LanguageClient_serverCommands = {
    "\ 'python': ['/home/labatata/.pyenv/shims/python', '-vv', '--log-file', '~/pyls.log'],
    "\ }
"let g:LanguageClient_diagnosticsDisplay = {
    "\  1: {
    "\      "name": "Error",
    "\      "texthl": "ALEError",
    "\      "signText": "✘",
    "\      "signTexthl": "ALEErrorSign",
    "\  },
    "\  2: {
    "\      "name": "Warning",
    "\      "texthl": "ALEWarning",
    "\      "signText": "⚠",
    "\      "signTexthl": "ALEWarningSign",
    "\  },
    "\  3: {
    "\      "name": "Information",
    "\      "texthl": "ALEInfo",
    "\      "signText": "ℹ",
    "\      "signTexthl": "ALEInfoSign",
    "\  },
    "\  4: {
    "\      "name": "Hint",
    "\      "texthl": "ALEInfo",
    "\      "signText": "➤",
    "\      "signTexthl": "ALEInfoSign",
    "\  },
    "\}

"highlight ALEErrorSign ctermfg=9
"highlight ALEWarningSign ctermfg=226

"let g:LanguageClient_preferredMarkupKind = ['plaintext']
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
"==================================================================================================

"let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Python highlighter
let g:semshi#error_sign=0

let g:floaterm_keymap_new = '<F7>'
let g:floaterm_keymap_kill = '<F11>'
let g:floaterm_keymap_toggle = '<F12>'
