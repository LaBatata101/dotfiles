vim.g.mapleader = ' '

vim.g.python3_host_prog = '/usr/bin/python'
vim.g.loaded_python_provider = 0
vim.g.python_host_skip_check = 1

vim.g.cursorhold_updatetime = 250

vim.opt.mouse = 'a'
vim.opt.cursorline = true
-- vim.opt.nohlsearch = true
vim.opt.showmode = false

vim.opt.hidden = true -- allow buffer switching without saving

vim.opt.showtabline = 2 -- always show tabline

vim.opt.clipboard = 'unnamedplus'

vim.opt.number = true
vim.opt.rnu = true

vim.opt.colorcolumn = '120'

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.undolevels = 1000

vim.opt.wildignore:append {'*.o', '*.pyc', '.git/', '__pycache__/'}

vim.opt.termguicolors = true

vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

vim.opt.autoindent = true

vim.opt.signcolumn = 'yes'

vim.opt.pumblend = 20

vim.opt.linebreak = true

-- vim.cmd [[autocmd CursorMoved <buffer> :nohlsearch]]
