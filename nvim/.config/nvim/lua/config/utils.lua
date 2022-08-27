local M = {}

local glob = vim.fn.glob
local system = vim.fn.system
local trim = vim.fn.trim

function M.ask_to_save_before_closing()
  local buf = vim.fn.getbufinfo("%")[1]

  if buf.changed == 1 then
    vim.ui.input(
      { prompt = string.format('Save "%s" before closing (Y/n)?', vim.fn.expand("%:t")), default = "Y" },
      function(input)
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
      end
    )
  else
    vim.api.nvim_buf_delete(buf.bufnr, {})
  end
end

function M.ask_to_save_before_quitting()
  local modified_buffers = vim.fn.getbufinfo({ bufmodified = true })
  local force_quit = false
  local cancel_quit = false

  -- if #modified_buffers == 1 then
  --   print(modified_buffers[1].bufnr)
  --   vim.api.nvim_buf_call(modified_buffers[1].bufnr, function()
  --     vim.api.nvim_command("w")
  --   end)
  --   return
  -- end

  for _, buf in pairs(modified_buffers) do
    vim.ui.input(
      { prompt = string.format('Save "%s" before closing (Y/n)?', vim.fn.expand("%:t")), default = "Y" },
      function(input)
        if input == nil then
          cancel_quit = true
          return
        end

        local input_lower = string.lower(input)
        if input_lower == "y" then
          vim.api.nvim_buf_call(buf.bufnr, function()
            vim.api.nvim_command("write")
          end)
        elseif input_lower == "n" then
          force_quit = true
        else
          cancel_quit = true
          print("Invalid Option! Aborting...")
          return
        end
      end
    )
  end

  if cancel_quit then
    return
  elseif force_quit then
    vim.api.nvim_command("q!")
  else
    vim.api.nvim_command("q")
    print("HEREEE")
  end
end

function M.get_python_path(workspace)
  local path = require("lspconfig.util").path
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
  if vim.fn.executable("poetry") and path.is_file(path.join(workspace, "poetry.lock")) then
    local output = trim(system("poetry env info -p"))
    if path.is_dir(output) then
      return path.join(output, "bin", "python")
    end
  end

  -- 4. Find and use virtualenv managed by Pipenv.
  if vim.fn.executable("pipenv") and path.is_file(path.join(workspace, "Pipfile")) then
    local output = trim(system("cd " .. workspace .. "; pipenv --py"))
    if path.is_dir(output) then
      return output
    end
  end

  -- 5. Find and use virtualenv managed by Pyenv.
  if vim.fn.executable("pyenv") and path.is_file(path.join(workspace, ".python-version")) then
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
  local last_fold_line = vim.fn.trim(vim.fn.getline(vim.v.foldend))

  if last_fold_line ~= "}" then
    last_fold_line = ""
  else
    total_spaces = total_spaces - 1
  end

  local spaces = string.rep(" ", total_spaces)

  return string.format(" %s ··· %s%s%s", line_text, last_fold_line, spaces, total_lines)
end

function M.text_handler(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = ("(%d lines)"):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end

  local ellipsis_suffix = " ···"
  local total_preffix_spaces = vim.opt.textwidth:get() - (sufWidth + curWidth + vim.fn.strdisplaywidth(ellipsis_suffix))
  suffix = ellipsis_suffix .. (" "):rep(total_preffix_spaces) .. suffix

  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
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
