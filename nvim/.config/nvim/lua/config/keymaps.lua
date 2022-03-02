local map = vim.api.nvim_set_keymap

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
map("", "<leader>k", ":bd<CR>", { noremap = true, silent = true })

-- split resizing
map("", "<left>", "<C-w>2>", {})
map("", "<up>", "<C-w>2-", {})
map("", "<down>", "<C-w>2+", {})
map("", "<right>", "<C-w>2<", {})

-- source it
map("", "<leader>r", '<cmd>lua require("config.utils").reload_config()<CR>', {})

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { noremap = true })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true })
map("n", "ga", "<cmd>Telescope lsp_code_actions<CR>", { noremap = true, silent = true })

-- LSP
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { noremap = true, silent = true })
map("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", { noremap = true, silent = true })
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

-- Rename
map("", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { noremap = true, silent = true })

-- Trouble
map("n", "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", { noremap = true })
map("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", { noremap = true })

-- Hop
map("n", "<leader><leader>", "<cmd>HopWord<CR>", { noremap = true })

-- Snippet
map("i", "<Tab>", 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true })
map("s", "<Tab>", 'vsnip#jumpable(1) ? "<Plug>(vsnip-jump-next)" : "<Tab>"', { expr = true })
map("i", "<S-Tab>", 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true })
map("s", "<S-Tab>", 'vsnip#jumpable(-1) ? "<Plug>(vsnip-jump-prev)" : "<S-Tab>"', { expr = true })

-- DAP
map("n", "<F5>", '<cmd>lua require("dap").continue()<CR>', { noremap = true, silent = true })
map("n", "<F10>", '<cmd>lua require("dap").step_over()<CR>', { noremap = true, silent = true })
map("n", "<F11>", '<cmd>lua require("dap").step_into()<CR>', { noremap = true, silent = true })
map("n", "<F12>", '<cmd>lua require("dap").step_out()<CR>', { noremap = true, silent = true })
map("n", "<leader>b", '<cmd>lua require("dap").toggle_breakpoint()<CR>', { noremap = true, silent = true })
map(
  "n",
  "<leader>dc",
  '<cmd>lua require("dap").terminate();require("dapui").close()<CR>',
  { noremap = true, silent = true }
)

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { noremap = true })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { noremap = true })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { noremap = true })
map("t", "<C-h>", "<C-\\><C-n><C-w>h", { noremap = true })

map(
  "n",
  "<C-\\>",
  "<cmd>lua require('config.plugins.toggleterm').vertical_term_toggle()<CR>",
  { noremap = true, silent = true }
)
map(
  "t",
  "<C-\\>",
  "<cmd>lua require('config.plugins.toggleterm').vertical_term_toggle()<CR>",
  { noremap = true, silent = true }
)
map(
  "n",
  "<leader>g",
  "<cmd>lua require('config.plugins.toggleterm').lazygit_toggle()<CR>",
  { noremap = true, silent = true }
)

-- File explorer
map("n", "<leader>fe", "<cmd>NvimTreeToggle<CR>", { noremap = true })

-- Cheatsheet
map("n", "<leader>c", "<cmd>Cheatsheet<CR>", { noremap = true })
