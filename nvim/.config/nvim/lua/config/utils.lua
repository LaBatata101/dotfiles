local M = {}

local util = require("lspconfig.util")
local path = util.path

function M.get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, ".python-version"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local RELOAD = function(name, all_submodules)
  return require("plenary.reload").reload_module(name, all_submodules)
end

-- helper function for quick reloading a lua module and optionally its subpackages
local R = function(name, all_submodules)
  RELOAD(name, all_submodules)
  return require(name)
end

function M.reload_config()
  R("config.globals")
  R("config.settings")
  R("config.keymaps")
  -- R("config.plugins", true)
  R("config.plugins.autopairs")
  R("config.plugins.bufferline")
  R("config.plugins.cheatsheet")
  R("config.plugins.cmp")
  R("config.plugins.comment")
  R("config.plugins.dap")
  R("config.plugins.DAPInstall")
  R("config.plugins.fidget")
  R("config.plugins.gitsigns")
  R("config.plugins.hop")
  R("config.plugins.illuminate")
  R("config.plugins.indent_blankline")
  R("config.plugins.lightbulb")
  R("config.plugins.lsp")
  R("config.plugins.lsp_signature")
  R("config.plugins.lualine")
  R("config.plugins.neoscroll")
  R("config.plugins.null_ls")
  R("config.plugins.packer")
  R("config.plugins.symbols_outline")
  R("config.plugins.telescope")
  R("config.plugins.toggleterm")
  R("config.plugins.tokyonight")
  R("config.plugins.treesitter")
  R("config.plugins.trouble")
  vim.cmd("PackerCompile")
  vim.notify("Config reloaded!")
end

return M
