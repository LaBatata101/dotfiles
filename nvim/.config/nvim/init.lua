require("config.globals")
require("config.settings")
require("config.keymaps")

local bootstrap = require("config.bootstrap")

bootstrap.install_lazy_nvim()

require("config.plugins.lazy")

bootstrap.install_language_servers()
