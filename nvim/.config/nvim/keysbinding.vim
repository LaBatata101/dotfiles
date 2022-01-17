" save file
map <leader>s :w<CR>

" split navigations
nnoremap <leader>J <C-W><C-J>
nnoremap <leader>K <C-W><C-K>
nnoremap <leader>L  <C-W><C-L>
nnoremap <leader>H <C-W><C-H>

" restore splits
noremap <leader>o :only<CR>

" Split
noremap <Leader>h :<C-u>split<CR>
nmap <Leader>v :<C-u>vsplit<CR>

" change buffer
noremap <leader>p :bp<CR>
noremap <leader>n :bn<CR>

" close buffer
map <leader>k :bd<CR>

" Split resizing
nmap <left> <C-w>5<
nmap <up> <C-w>5+
nmap <down> <C-w>5-
nmap <right> <C-w>5>

" source it
map <leader>r <cmd>source $MYVIMRC<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <silent> ga <cmd>Telescope lsp_code_actions<CR>

" LSP
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <leader>rn     <cmd>lua vim.lsp.buf.rename()<CR>

" Trouble
nnoremap <leader>td     <cmd>TroubleToggle document_diagnostics<CR>
nnoremap <silent> gr    <cmd>TroubleToggle lsp_references<CR>

" Hop
nnoremap <leader><leader> <cmd>HopWord<CR>
