local function filter_by(expected)
  return function(bufnr)
    if #expected == 0 then
      return true
    end

    local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    local found = false
    for i = 1, #expected do
      if filetype == expected[i] then
        found = true
        break
      end
    end

    return found
  end
end

local lsp_server_id = nil
local filter = filter_by({})
local config = nil
local M = {}

local function attach_lsp(args)
  if lsp_server_id == nil then
    return
  end

  local bufnr = args.buffer or args.buf
  if not bufnr or not filter(bufnr) then
    return
  end

  if not vim.lsp.buf_is_attached(args.buffer, lsp_server_id) then
    vim.lsp.buf_attach_client(args.buffer, lsp_server_id)
  end
end

function M.restart(updated_config)
  config = vim.tbl_deep_extend("force", {}, config or {}, updated_config or {})
  M.stop()
  M.start(config)
end

function M.stop()
  if lsp_server_id == nil then
    return
  end

  vim.lsp.stop_client(lsp_server_id)
  lsp_server_id = nil
end

--- @param opts {cmd: string[]}
function M.start(opts)
  if lsp_server_id ~= nil then
    vim.lsp.stop_client(lsp_server_id)
  end

  lsp_server_id = vim.lsp.start_client({
    name = "sith-language-server",
    cmd = opts.cmd,
    root_dir = vim.loop.cwd(),
    trace = "verbose",
    init_options = {
      settings = {
        interpreter = "/usr/bin/python",
      },
    },
  })

  filter = filter_by({ "python" })

  local bufnr = vim.api.nvim_get_current_buf()

  attach_lsp({ buffer = bufnr })
end

local function filterList(list, condition)
  local filteredList = {}
  for _, item in ipairs(list) do
    if condition(item) then
      table.insert(filteredList, item)
    end
  end
  return filteredList
end

--- @param target string
--- @param list string[]
local function isInList(target, list)
  for _, item in ipairs(list) do
    if item == target then
      return true
    end
  end
  return false
end

--- @param opts {names: string[]}
local function stopLsps(opts)
  -- Get the current buffer number
  local current_bufnr = vim.fn.bufnr("%")

  -- Get a list of LSP clients attached to the current buffer
  local clients = vim.lsp.get_clients({ bufnr = current_bufnr })
  filterList(clients, function(client)
    return isInList(client.name, opts.names)
  end)

  for _, client in pairs(clients) do
    vim.lsp.stop_client(client.id)
  end
end

function M.PrintLSPClientInfo()
  -- Get the current buffer number
  local current_bufnr = vim.fn.bufnr("%")

  -- Get a list of LSP clients attached to the current buffer
  local clients = vim.lsp.get_clients({ bufnr = current_bufnr })

  -- Check if there are clients
  if not next(clients) then
    print("No LSP clients attached to the current buffer.")
  else
    for _, client in pairs(clients) do
      print("Client ID: " .. client.id)
      print("Client Name: " .. client.name)
      print("Server Name: " .. client.config.name)
      print("Root directory: " .. client.config.root_dir)
    end
  end
end

function M.LspDevStart(opts)
  stopLsps({ names = { "pyright" } })
  M.start({ cmd = { vim.fn.expand(opts.fargs[1]) } })
end

-- Helper function to unescape special characters
local function unescape_str(s)
  return s:gsub("\\(.)", function(x)
    local replacements = {
      n = "\n",
      t = "\t",
      r = "\r",
      ["\\"] = "\\",
      ['"'] = '"',
    }
    return replacements[x] or ("\\" .. x)
  end)
end

function M.ShowLspLogs()
  -- Create a new horizontally split buffer
  vim.cmd("split")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_name(buf, "LSP LOGS")
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = true

  -- Define highlight groups
  vim.cmd([[
        highlight default link LspLogError Error
        highlight default link LspLogWarn WarningMsg
        highlight default link LspLogInfo Identifier
        highlight default link LspLogDebug Debug
        highlight LspLogDateTime cterm=bold gui=bold
        highlight LspLogServer cterm=italic gui=italic
    ]])

  -- Get log file path
  local log_path = vim.lsp.get_log_path()
  local log_file = io.open(log_path, "r")
  if not log_file then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "No LSP log file found: " .. log_path })
    vim.bo[buf].modifiable = false
    return
  end

  local today = os.date("%Y-%m-%d")
  local lines = {}
  local highlights = {}

  -- Process each log line
  for line in log_file:lines() do
    local parts = vim.split(line, "\t", { trimempty = true })
    if #parts >= 5 then
      local header = parts[1]
      local level, datetime = header:match("%[([^%]]*)%]%[([^%]]*)%]")
      if level and datetime then
        -- Check if log is from today
        local log_date = datetime:sub(1, 10)
        if log_date == today then
          -- Extract components
          local server = parts[3]:gsub('^"(.*)"$', "%1")
          local fd = parts[4]:gsub('^"(.*)"$', "%1")
          local message = parts[5]:gsub('^"(.*)"$', "%1")

          -- Split message and remove trailing newline
          local message_lines = vim.split(unescape_str(message), "\n", { plain = true })
          if #message_lines > 0 and message_lines[#message_lines] == "" then
            table.remove(message_lines)
          end

          -- Set highlight
          local formatted_level = level:sub(1, 1):upper() .. level:sub(2):lower()
          local hl_group = "LspLog" .. formatted_level

          -- Add metadata line
          local metadata_line = string.format("[%s] %s %s (%s):", level, datetime, server, fd)
          local line_num = #lines
          table.insert(lines, metadata_line)

          -- Level highlight
          local level_prefix = string.format("[%s]", level)
          table.insert(highlights, {
            hl_group,
            line_num,
            0,
            #level_prefix + 1,
          })

          -- DateTime highlight (bold)
          local datetime_start = #level_prefix + 2
          local datetime_end = datetime_start + 19 -- Length of 'YYYY-MM-DD HH:MM:SS'
          table.insert(highlights, {
            "LspLogDateTime",
            line_num,
            datetime_start,
            datetime_end,
          })

          -- Server highlight (italic)
          local server_start = datetime_end + 1
          local server_end = server_start + #server
          table.insert(highlights, {
            "LspLogServer",
            line_num,
            server_start,
            server_end,
          })

          -- Add message lines indented under metadata
          for _, msg_line in ipairs(message_lines) do
            table.insert(lines, "  " .. msg_line)
          end
        end
      end
    end
  end

  log_file:close()

  -- Insert lines and apply highlights
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  for _, hl in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, hl[1], hl[2], hl[3], hl[4])
  end

  -- Move cursor to last line (most recent entry)
  if #lines > 0 then
    vim.api.nvim_win_set_cursor(0, { #lines, 0 })
  end

  -- Final buffer settings
  vim.bo[buf].modifiable = false
  vim.bo[buf].readonly = true
end

return M
