
" change buffer
nmap <C-A> :bp<CR>
nmap <C-D> :bn<CR>

" split navigations
nnoremap <C-S-J> <C-W><C-J>
nnoremap <C-S-K> <C-W><C-K>
nnoremap <C-S-L> <C-W><C-L>
nnoremap <C-S-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

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

" show tabs whithespaces
nnoremap <F6> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$,space:. list! list? <CR>

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

autocmd FileType python noremap <buffer> <leader>t :<C-u>Autopep8<CR>

" map FuzzyFinder to Ctrl-P
map <C-P> :FZF<CR>

map <F2> :NERDTreeToggle<CR>
