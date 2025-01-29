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

  vim.lsp.set_log_level("TRACE")
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

local log_buffers = {}
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

local function format_jsonlike_text(text)
  local ok, parsed = pcall(load("return " .. text))
  if not ok then
    print("Error parsing text: " .. parsed)
    return nil
  end

  return vim.inspect(parsed)
end

local function process_line(line, lines, highlights, args)
  local parts = vim.split(line, "\t", { trimempty = true })
  if #parts < 2 then
    return
  end

  local header = parts[1]
  local level, datetime = header:match("%[([^%]]*)%]%[([^%]]*)%]")
  if not level or not datetime then
    return
  end

  local log_date = datetime:sub(1, 10)
  local current_day = os.date("%Y-%m-%d")
  if args == "today" and log_date ~= current_day then
    return
  end

  local formatted_level = level:sub(1, 1):upper() .. level:sub(2):lower()
  local hl_group = "LspLog" .. formatted_level
  local metadata_line = string.format("[%s] %s", level, datetime)

  local line_num = #lines
  -- Log Level highlight
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

  if parts[2]:match('"rpc"') then
    local server = parts[3]:gsub('^"(.*)"$', "%1")
    local fd = parts[4]:gsub('^"(.*)"$', "%1")
    local message = parts[5]:gsub('^"(.*)"$', "%1")
    metadata_line = string.format("%s  %s (%s):", metadata_line, server, fd)

    table.insert(lines, metadata_line)
    -- Server highlight (italic)
    local server_start = datetime_end + 1
    local server_end = server_start + #server
    table.insert(highlights, {
      "LspLogServer",
      line_num,
      server_start,
      server_end,
    })

    local msg_lines = vim.split(unescape_str(message), "\n", { trimempty = true })
    for _, msg in ipairs(msg_lines) do
      table.insert(lines, "  " .. msg)
    end
  elseif parts[2]:match("rpc%.[receive|send]") or parts[2]:match('"exit_handler"') then
    local data = parts[3]
    local receive_or_send = parts[2]:gsub('^"(.+)"$', "%1")
    if receive_or_send:match("receive$") then
      metadata_line = string.format("%s Received response:", metadata_line, receive_or_send)
    elseif receive_or_send:match("send$") then
      metadata_line = string.format("%s Sending request:", metadata_line, receive_or_send)
    else
      metadata_line = string.format("%s (%s):", metadata_line, receive_or_send)
    end
    table.insert(lines, metadata_line)

    local data_lines = vim.split(data, "\n", { trimempty = true })
    for _, l in ipairs(data_lines) do
      table.insert(lines, "  " .. l)
    end
  elseif parts[2]:match('^"LSP%[') then
    local server = parts[2]:gsub('"LSP%[(.+)%]"', "%1")
    metadata_line = string.format("%s %s", metadata_line, server)

    if parts[3]:match("client%.request") then
      local lsp_method = parts[5]:gsub('^"(.+)"$', "%1")
      local data = parts[6]

      metadata_line = string.format("%s  %s", metadata_line, lsp_method)
      table.insert(lines, metadata_line)

      local data_lines = vim.split(data, "\n", { trimempty = true })
      for _, l in ipairs(data_lines) do
        table.insert(lines, "  " .. l)
      end
    elseif parts[3]:match('["initialize_params"|"server_capabilities"]') then
      local lsp_method = parts[3]:gsub('^"(.+)"$', "%1")
      local data = parts[4]

      metadata_line = string.format("%s  %s", metadata_line, lsp_method)
      table.insert(lines, metadata_line)

      local data_lines = vim.split(data, "\n", { trimempty = true })
      for _, l in ipairs(data_lines) do
        table.insert(lines, "  " .. l)
      end
    end
  elseif parts[2]:match('"default_handler"') then
    local lsp_method = parts[3]:gsub('^"(.+)"$', "%1")
    metadata_line = string.format("%s  (%s) %s", metadata_line, parts[2]:gsub('^"(.+)"$', "%1"), lsp_method)
    table.insert(lines, metadata_line)

    local data_lines = vim.split(parts[4], "\n", { trimempty = true })
    for _, l in ipairs(data_lines) do
      table.insert(lines, "  " .. l)
    end
  elseif parts[2]:match('"server_request"') then
    local lsp_method = parts[3]:gsub('^"(.+)"$', "%1")
    local data = parts[4]
    metadata_line = string.format("%s  %s %s", metadata_line, parts[2]:gsub('^"(.+)"$', "%1"), lsp_method)
    table.insert(lines, metadata_line)
    table.insert(lines, data)
  elseif parts[2]:match('"server_request: (.+)"') then
    metadata_line =
      string.format('%s  %s "%s"', metadata_line, parts[2]:gsub('^"(.+)"$', "%1"), parts[3]:gsub('^"(.+)"$', "%1"))
    table.insert(lines, metadata_line)
  else
    local message = parts[2]:gsub('^"(.+)"$', "%1")
    metadata_line = string.format("%s  %s", metadata_line, message)
    table.insert(lines, metadata_line)
  end
end

local function update_log_buffer(buf, args)
  -- Get log file path
  local log_path = vim.lsp.get_log_path()
  local log_file = io.open(log_path, "r")
  if not log_file then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "No LSP log file found: " .. log_path })
    vim.bo[buf].modifiable = false
    return
  end

  local lines = {}
  local highlights = {}

  -- Store current cursor position
  local current_win = vim.api.nvim_get_current_win()
  local was_at_bottom = false
  if vim.api.nvim_win_is_valid(current_win) then
    local cursor_pos = vim.api.nvim_win_get_cursor(current_win)
    local line_count = vim.api.nvim_buf_line_count(buf)
    was_at_bottom = cursor_pos[1] == line_count
  end

  -- Process each log line
  for line in log_file:lines() do
    process_line(line, lines, highlights, args)
  end

  log_file:close()

  -- Update buffer if needed
  vim.bo[buf].modifiable = true

  -- Insert lines and apply highlights
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_clear_namespace(buf, -1, 0, -1)
  for _, hl in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(buf, -1, hl[1], hl[2], hl[3], hl[4])
  end
  vim.bo[buf].modifiable = false

  -- Move cursor to bottom if it was there before update
  if was_at_bottom and #lines > 0 then
    vim.api.nvim_win_set_cursor(current_win, { #lines, 0 })
  end
end

function M.ShowLspLogs(opts)
  local arg = opts.args:gsub("%s+", "")
  if arg:len() > 0 and arg ~= "today" then
    print(string.format("Invalid argument `%s`", opts.args))
  end

  -- Create a new horizontally split buffer
  vim.cmd("split")
  local buf = vim.fn.bufnr("LSP LOGS", true)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_name(buf, "LSP LOGS")
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false

  -- Define highlight groups
  vim.api.nvim_set_hl(0, "LspLogError", { link = "Error" })
  vim.api.nvim_set_hl(0, "LspLogWarn", { link = "WarningMsg" })
  vim.api.nvim_set_hl(0, "LspLogDebug", { link = "Debug" })
  vim.api.nvim_set_hl(0, "LspLogInfo", { fg = "#2ECC71" })
  vim.api.nvim_set_hl(0, "LspLogTrace", { fg = "#9B59B6" })
  vim.api.nvim_set_hl(0, "LspLogTrace", { fg = "#9B59B6" })
  vim.api.nvim_set_hl(0, "LspLogDateTime", { bold = true })
  vim.api.nvim_set_hl(0, "LspLogServer", { italic = true })

  -- Setup buffer if not already initialized
  if not log_buffers[buf] then
    log_buffers[buf] = {
      timer = vim.loop.new_timer(),
      last_mtime = 0,
    }

    -- Set up auto-update timer
    log_buffers[buf].timer:start(
      0,
      2000,
      vim.schedule_wrap(function()
        if not vim.api.nvim_buf_is_valid(buf) then
          log_buffers[buf].timer:close()
          log_buffers[buf] = nil
          return
        end

        local log_path = vim.lsp.get_log_path()
        local stat = vim.loop.fs_stat(log_path)
        local current_mtime = stat and stat.mtime.sec or 0

        if current_mtime > log_buffers[buf].last_mtime then
          log_buffers[buf].last_mtime = current_mtime
          update_log_buffer(buf, arg)
        end
      end)
    )

    -- Clean up when buffer is closed
    vim.api.nvim_create_autocmd("BufDelete", {
      buffer = buf,
      callback = function()
        if log_buffers[buf] then
          log_buffers[buf].timer:close()
          log_buffers[buf] = nil
        end
      end,
    })
  end

  -- Initial update
  update_log_buffer(buf)
end

return M
