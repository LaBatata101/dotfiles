require("config.globals")
require("config.settings")
require("config.keymaps")

pcall(require, "impatient")

-- Load plugins and their configurations
require("config.plugins.packer")

-- Improve startup speed
-- require("impatient")

require("packer_compiled")
-- load plugins configurations
require("config.plugins.lualine")
require("config.plugins.bufferline")
require("config.plugins.tokyonight")
