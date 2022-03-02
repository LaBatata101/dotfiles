require("toggleterm").setup({
  open_mapping = [[<C-t>]],
  insert_mappings = false,
  direction = "float",
  float_opts = {
    border = "curved",
    winblend = 5,
  },
})

local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local vertical_term = Terminal:new({ hidden = true, direction = "vertical" })
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function M.vertical_term_toggle()
  vertical_term:toggle(55, "vertical")
end

function M.lazygit_toggle()
  lazygit:toggle()
end

return M
