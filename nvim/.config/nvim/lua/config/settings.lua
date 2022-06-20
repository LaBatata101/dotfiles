vim.g.mapleader = " "

vim.g.python3_host_prog = "/usr/bin/python"
vim.g.loaded_python_provider = 0
vim.g.python_host_skip_check = 1

vim.g.cursorhold_updatetime = 250

vim.opt.mouse = "a"
vim.opt.cursorline = true
-- vim.opt.nohlsearch = true
vim.opt.showmode = false

vim.opt.hidden = true -- allow buffer switching without saving

vim.opt.showtabline = 2 -- always show tabline

vim.opt.clipboard = "unnamedplus"

vim.opt.number = true
vim.opt.rnu = true

vim.opt.colorcolumn = "120"
vim.opt.textwidth = 119

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.undolevels = 1000

vim.opt.wildignore:append({ "*.o", "*.pyc", ".git/", "__pycache__/" })

vim.opt.termguicolors = true

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.autoindent = true

vim.opt.signcolumn = "yes"

vim.opt.pumblend = 20

vim.opt.linebreak = true

-- emoji is true by default but makes (n)vim treat all emoji as double width
-- which breaks rendering so we turn this off.
-- CREDIT: https://www.youtube.com/watch?v=F91VWOelFNE
vim.opt.emoji = false

-- folding config
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldlevelstart = 99
vim.opt.foldtext = "v:lua.require('config.utils').fold_text()"
-- vim.wo.foldcolumn = "1"
-- vim.wo.foldlevel = 99
-- vim.wo.foldenable = true

vim.opt.fillchars = { fold = " " }

-- Splitting a new window below the current one
vim.opt.splitbelow = true
-- Splitting a new window at the right of the current one
vim.opt.splitright = true

-- Disable continuation of comments to the next linebreak
vim.opt.formatoptions:remove({ "c" })
-- vim.o.formatoptions = "cql"

-- disable builtin plugins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1

local neovim_terminal = vim.api.nvim_create_augroup("neovim_terminal", {})
vim.api.nvim_create_autocmd("TermOpen", {
  group = neovim_terminal,
  pattern = "*",
  command = "startinsert | setlocal nonumber norelativenumber nocursorline signcolumn=no",
})

local vimrc_incsearch_highlight = vim.api.nvim_create_augroup("VimrcIncSearchHighlight", {})
local vimrc_incsearch_and_replace = vim.api.nvim_create_augroup("VimrcIncSearchAndReplace", {})
vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = vimrc_incsearch_highlight,
  pattern = "[/\\?]",
  command = "set hlsearch",
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vimrc_incsearch_highlight,
  pattern = "[/\\?]",
  command = "set nohlsearch",
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = vimrc_incsearch_and_replace,
  pattern = "[:s\\:%s]",
  command = "set hlsearch",
})
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vimrc_incsearch_and_replace,
  pattern = "[:s\\:%s]",
  command = "set nohlsearch",
})

vim.g.symbols_outline = {
  auto_preview = false,
  width = 35,
}
