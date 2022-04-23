local map = vim.keymap.set

-- save file
map("", "<leader>s", ":w<CR>", { noremap = true, silent = true })

-- split navigations
map("n", "<C-j>", "<C-w>j", { noremap = true })
map("n", "<C-k>", "<C-w>k", { noremap = true })
map("n", "<C-l>", "<C-w>l", { noremap = true })
map("n", "<C-h>", "<C-w>h", { noremap = true })

-- restore splits
map("", "<leader>o", ":only<CR>", { noremap = true })

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
map("", "<left>", "<C-w>2>")
map("", "<up>", "<C-w>2-")
map("", "<down>", "<C-w>2+")
map("", "<right>", "<C-w>2<")

-- source it
map("", "<leader>r", function()
  return require("config.utils").reload_config()
end)

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true })
map("n", "ga", "<cmd>Telescope lsp_code_actions<CR>", { noremap = true, silent = true })

-- LSP
map("n", "K", vim.lsp.buf.hover, { noremap = true, silent = true })
map("n", "gi", vim.lsp.buf.implementation, { noremap = true, silent = true })
map("n", "gW", vim.lsp.buf.workspace_symbol, { noremap = true, silent = true })
map("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true })

-- Rename
map("", "<leader>rn", vim.lsp.buf.rename, { noremap = true, silent = true })

-- Trouble
map("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", { noremap = true })
map("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", { noremap = true })

-- Hop
map("n", "<leader><leader>", "<cmd>HopWord<CR>", { noremap = true })

-- DAP
map("n", "<F5>", function()
  return require("dap").continue()
end, { noremap = true, silent = true })

map("n", "<F10>", function()
  return require("dap").step_over()
end, { noremap = true, silent = true })

map("n", "<F11>", function()
  return require("dap").step_into()
end, { noremap = true, silent = true })

map("n", "<F12>", function()
  return require("dap").step_out()
end, { noremap = true, silent = true })

map("n", "<leader>b", function()
  return require("dap").toggle_breakpoint()
end, { noremap = true, silent = true })

map("n", "<leader>dc", function()
  require("dap").terminate()
  return require("dapui").close()
end, { noremap = true, silent = true })

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true })

map({ "n", "t" }, "<C-\\>", function()
  return require("config.plugins.toggleterm").vertical_term_toggle()
end, { noremap = true, silent = true })

map("n", "<leader>g", function()
  return require("config.plugins.toggleterm").lazygit_toggle()
end, { noremap = true, silent = true })

-- File explorer
map("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", { noremap = true })

-- Cheatsheet
map("n", "<leader>c", "<cmd>Cheatsheet<CR>", { noremap = true })

-- LUASnip
map("i", "<c-l>", function()
  return require("config.plugins.luasnip").change_choice()
end, { silent = true })
