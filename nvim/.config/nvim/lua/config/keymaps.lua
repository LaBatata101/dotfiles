local map = vim.keymap.set

-- save file
map("", "<leader>s", function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd.write()
  end)
end, { noremap = true, silent = true })

-- split navigations
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })
map("n", "<C-h>", "<C-w>h", { noremap = true })

-- Move lines
map("n", "<M-j>", "<cmd>m .+1<CR>==", { noremap = true })
map("n", "<M-k>", "<cmd>m .-2<CR>==", { noremap = true })
map("i", "<M-j>", "<ESC><cmd>m .+1<CR>==gi", { noremap = true })
map("i", "<M-k>", "<ESC><cmd>m .-2<CR>==gi", { noremap = true })
-- map("v", "<C-j>", "<cmd>m '>+1<CR>gv=gv", { noremap = true })
-- map("v", "<C-k>", "<cmd>m '<-2<CR>gv=gv", { noremap = true })

-- restore splits
map("", "<leader>o", ":only<CR>", { noremap = true, silent = true })

-- split
map("n", "<leader>h", ":<C-u>split<CR>", { noremap = true, silent = true })
map("n", "<leader>v", ":<C-u>vsplit<CR>", { noremap = true, silent = true })

-- change buffer
map("", "<leader>p", ":bp<CR>", { noremap = true, silent = true })
map("", "<leader>n", ":bn<CR>", { noremap = true, silent = true })

-- close buffer
map("", "<leader>k", function()
  return require("config.utils").ask_to_save_before_closing()
end, { noremap = true, silent = true })

-- split resizing
map("", "<left>", "<C-w>2>", { silent = true })
map("", "<up>", "<C-w>2-", { silent = true })
map("", "<down>", "<C-w>2+", { silent = true })
map("", "<right>", "<C-w>2<", { silent = true })

-- source it
map("", "<leader>r", function()
  require("plenary.reload").reload_module("config")
  vim.cmd([[source $MYVIMRC]])
end, { silent = true })

-- LSP
map("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { noremap = true, silent = true })
map("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
map("n", "ga", function()
  vim.lsp.buf.code_action()
end, { noremap = true, silent = true })
map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })
map("n", "<leader>dn", vim.diagnostic.goto_next, { noremap = true, silent = true })
map("n", "<leader>dp", vim.diagnostic.goto_prev, { noremap = true, silent = true })

map("n", "<leader>it", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end, { noremap = true, silent = true })

local diagnostics_active = true
map("n", "<leader>dd", function()
  diagnostics_active = not diagnostics_active

  if diagnostics_active then
    vim.diagnostic.show(nil, 0)
  else
    vim.diagnostic.hide(nil, 0)
  end
end)

-- Rename
map("", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })

-- Hop
map("n", "<leader><leader>", "<cmd>HopWord<CR>", { noremap = true })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true })

-- LUASnip
map("i", "<c-l>", function()
  return require("config.plugins.luasnip").change_choice()
end, { silent = true })

-- save all and quit
-- map("n", "ZZ", function()
--   require("config.utils").ask_to_save_before_exit()
-- end, { silent = true })
map("n", "ZZ", "<cmd>conf qa<CR>", { silent = true })
