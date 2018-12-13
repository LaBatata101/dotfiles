" Go to previous and next item in quickfix list
noremap <leader>cn :cnext<CR>
noremap <leader>cp :cprev<CR>

noremap <leader>ln :lnext<CR>
noremap <leader>lp :lprev<CR>

" change buffer
noremap <leader>H :bp<CR>
noremap <leader>L :bn<CR>

" Split resizing
nmap <left> <C-w>5<
nmap <up> <C-w>5+
nmap <down> <C-w>5-
nmap <right> <C-w>5>

" split navigations
nnoremap <C-S-J> <C-W><C-J>
nnoremap <C-S-K> <C-W><C-K>
nnoremap <C-S-L> <C-W><C-L>
nnoremap <C-S-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" source it
map <leader>r :source $HOME/.config/nvim/config/init.vim<CR>
" save file
map <leader>s :w<CR>
" close buffer
map <leader>k :bd<CR>
" execute python file
map <leader>e :!python3 %<CR>

" show tabs whithespaces
nnoremap <F6> :<C-U>setlocal lcs=tab:>-,trail:-,eol:$,space:. list! list? <CR>

" Split
noremap <Leader>h :<C-u>split<CR>
nmap <Leader>v :<C-u>vsplit<CR>

autocmd FileType python noremap <buffer> <leader>t :<C-u>Autopep8<CR>

" map FuzzyFinder to Ctrl-P
map <C-P> :FZF<CR>
