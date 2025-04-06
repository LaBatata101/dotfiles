local M = {}

local glob = vim.fn.glob
local system = vim.fn.system
local trim = vim.fn.trim
local path = require("lspconfig.util").path

local function create_input_dialog(prompt, opts)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local input = Input({
    position = "50%",
    size = {
      width = #prompt + 4,
    },
    border = {
      style = "single",
      text = {
        top = prompt,
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "> ",
    default_value = "N",
    on_close = opts.on_close,
    on_submit = opts.on_submit,
  })

  -- mount/open the component
  input:mount()

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

function M.ask_to_save_before_closing()
  local bufnr = vim.api.nvim_get_current_buf()

  if vim.api.nvim_buf_get_option(bufnr, "modified") then
    local prompt_msg = string.format('Save "%s" before closing (y/N)?', vim.fn.expand("%:t"))

    create_input_dialog(prompt_msg, {
      on_close = nil,
      on_submit = function(value)
        local value_lower = string.lower(value)
        if value_lower == "y" then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd.write()
          end)

          vim.api.nvim_buf_delete(bufnr, {})
        elseif value_lower == "n" then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        else
          print("Invalid Option! Aborting...")
        end
      end,
    })
  else
    vim.api.nvim_buf_delete(bufnr, {})
  end
end

local function get_modified_buffers_id()
  local buffers = vim.api.nvim_list_bufs()
  local modified_buffers = {}

  for _, bufnr in ipairs(buffers) do
    if vim.api.nvim_buf_get_option(bufnr, "modified") then
      table.insert(modified_buffers, bufnr)
    end
  end

  return modified_buffers
end

function M.ask_to_save_before_exit()
  print("ENTER - ask_to_save_before_exit")
  local buffers_id = get_modified_buffers_id()
  print(vim.print(buffers_id))
  --
  for _, bufnr in ipairs(buffers_id) do
    print(bufnr)
    local prompt_msg = string.format('Save "%s" before closing (Y/n)?', vim.api.nvim_buf_get_name(bufnr))

    create_input_dialog(prompt_msg, {
      on_close = nil,
      on_submit = function(value)
        print("ENTER - on_submit")
        local input = value:lower()
        if input == "y" then
          vim.api.nvim_buf_call(bufnr, function()
            vim.cmd.write()
          end)
        elseif input == "n" then
          vim.api.nvim_buf_set_option(bufnr, "modified", false)
        end
        print("EXIT - on_submit")
      end,
    })
  end

  print("EXIT - ask_to_save_before_exit")
  vim.cmd.quit()
end

local function get_python_path(workspace)
  -- 1. Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV
  end

  -- 2. Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if not vim.fn.empty(match) then
      return vim.fs.dirname(match)
    end
  end

  -- 3. Find and use virtualenv managed by Poetry.
  if vim.fn.executable("poetry") and path.is_file(path.join(workspace, "poetry.lock")) then
    local output = trim(system("poetry env info -p"))
    if vim.fn.isdirectory(output) == 1 then
      return output
    end
  end

  -- 4. Find and use virtualenv managed by Pipenv.
  if vim.fn.executable("pipenv") and path.is_file(path.join(workspace, "Pipfile")) then
    local output = trim(system("cd " .. workspace .. "; pipenv --py"))
    if vim.fn.isdirectory(output) == 1 then
      return output
    end
  end

  -- 5. Find and use virtualenv managed by Pyenv.
  if vim.fn.executable("pyenv") and path.is_file(path.join(workspace, ".python-version")) then
    local venv_name = trim(system("cat " .. path.join(workspace, ".python-version")))
    local pyenv_dir = path.join(vim.env.HOME, ".pyenv")
    local virtualenv_dir = path.join(pyenv_dir, "versions", venv_name)

    if vim.fn.isdirectory(output) == 1 then
      return virtualenv_dir
    end
  end
end

function M.get_python_bin_path(workspace)
  local python_dir = get_python_path(workspace)

  if python_dir then
    return path.join(python_dir, "bin", "python")
  end
  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

function M.get_python_lib_path(workspace)
  local python_dir = get_python_path(workspace)
  return glob(path.join(python_dir, "lib", "*", "site-packages"))
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
  local suffix = ("  %d lines "):format(endLnum - lnum)
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
  local total_preffix_spaces = vim.opt.textwidth:get() - sufWidth - curWidth - vim.fn.strdisplaywidth(ellipsis_suffix)
  suffix = ellipsis_suffix .. (" "):rep(total_preffix_spaces) .. suffix

  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

return M
