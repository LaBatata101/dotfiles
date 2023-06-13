require("config.globals")
require("config.settings")
require("config.keymaps")

if vim.g.neovide then
  require("config.neovide")
end

local bootstrap = require("config.bootstrap")

bootstrap.install_lazy_nvim()

require("config.plugins.lazy")

bootstrap.install_language_servers()
