local M = {}

local glob = vim.fn.glob
local system = vim.fn.system
local trim = vim.fn.trim

function M.ask_to_save_before_closing()
  local buf = vim.fn.getbufinfo("%")[1]

  if buf.changed == 1 then
    vim.ui.input({ prompt = "Save buffer before closing (Y/n)?", default = "Y" }, function(input)
      if input == nil then
        return
      end

      local input_lower = string.lower(input)
      if input_lower == "y" then
        vim.api.nvim_command("write")
        vim.api.nvim_buf_delete(buf.bufnr, {})
      elseif input_lower == "n" then
        vim.api.nvim_buf_delete(buf.bufnr, { force = true })
      else
        print("Invalid Option! Aborting...")
        return
      end
    end)
  else
    vim.api.nvim_buf_delete(buf.bufnr, {})
  end
end

function M.get_python_path(workspace)
  local util = require("lspconfig.util")
  local path = util.path
  -- 1. Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end

  -- 2. Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if not vim.fn.empty(match) then
      return path.join(path.dirname(match), "bin", "python")
    end
  end

  -- 3. Find and use virtualenv managed by Poetry.
  if util.has_bins("poetry") and path.is_file(path.join(workspace, "poetry.lock")) then
    local output = trim(system("poetry env info -p"))
    if path.is_dir(output) then
      return path.join(output, "bin", "python")
    end
  end

  -- 4. Find and use virtualenv managed by Pipenv.
  if util.has_bins("pipenv") and path.is_file(path.join(workspace, "Pipfile")) then
    local output = trim(system("cd " .. workspace .. "; pipenv --py"))
    if path.is_dir(output) then
      return output
    end
  end

  -- 5. Find and use virtualenv managed by Pyenv.
  if util.has_bins("pyenv") and path.is_file(path.join(workspace, ".python-version")) then
    local venv_name = trim(system("cat " .. path.join(workspace, ".python-version")))
    local pyenv_dir = path.join(vim.env.HOME, ".pyenv")
    local virtualenv_dir = path.join(pyenv_dir, "versions", venv_name)

    if path.is_dir(virtualenv_dir) then
      return path.join(virtualenv_dir, "bin", "python")
    end
  end

  -- 6. Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

function M.fold_text()
  local total_lines = string.format("(%d lines)", vim.v.foldend - vim.v.foldstart + 1)
  local line_text = vim.fn.getline(vim.v.foldstart)
  local total_spaces = vim.fn.abs(vim.opt.textwidth:get() - (string.len(total_lines) + string.len(line_text))) - 7
  local spaces = string.rep(" ", total_spaces)

  return string.format(" %s ··· %s%s", line_text, spaces, total_lines)
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
  R("config.utils")
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
