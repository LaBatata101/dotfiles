" Go to previous and next item in quickfix list
noremap <leader>ln :lnext<CR>
noremap <leader>lp :prev<CR>
noremap <leader>lo :lw<CR>
noremap <leader>ll :lcl<CR>

" change buffer
noremap <leader>p :bp<CR>
noremap <leader>n :bn<CR>

" close buffer
map <leader>k :bd<CR>

" restore splits
noremap <leader>o :only<CR>

" Split resizing
nmap <left> <C-w>5<
nmap <up> <C-w>5+
nmap <down> <C-w>5-
nmap <right> <C-w>5>

" Split
noremap <Leader>h :<C-u>split<CR>
nmap <Leader>v :<C-u>vsplit<CR>

" split navigations
nnoremap <leader>J <C-W><C-J>
nnoremap <leader>K <C-W><C-K>
nnoremap <leader>L  <C-W><C-L>
nnoremap <leader>H <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space>ff za

" source it
map <leader>r :source $HOME/.config/nvim/init.vim<CR>
" save file
map <leader>s :w<CR>

" show tabs whithespaces
nnoremap <F6> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$,space:. list! list? <CR>

" compile C program and run it
map <F5> :!clang % -o %< && %< <CR>


autocmd FileType python noremap <buffer> <leader>t :<C-u>Autopep8<CR>

" map FuzzyFinder to Ctrl-P
map <C-P> :Files<CR>
" Search for text inside files
nnoremap <C-g> :Rg<Cr>
