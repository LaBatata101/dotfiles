require("config.globals")
require("config.settings")
require("config.keymaps")

local bootstrap = require("config.bootstrap")

bootstrap.install_packer()
-- Improve startup speed
local ok, _ = pcall(require, "impatient")
if ok then
  require("impatient").enable_profile()
end

-- Load plugins and their configurations
require("config.plugins.packer")
-- require("config.colors")

bootstrap.install_language_servers()

local compiled_ok, _ = pcall(require, "packer_compiled")
if compiled_ok then
  require("packer_compiled")
end

-- COLORS
vim.api.nvim_set_hl(0, "Folded", {  italic = false  })
vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {fg = require("gruvbox.colors").bright_yellow, bg = nil})
