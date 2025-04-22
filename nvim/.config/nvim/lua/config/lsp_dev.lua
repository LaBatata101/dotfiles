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
    name = "SithLSP",
    filetypes = { "python" },
    cmd = opts.cmd,
    root_dir = vim.loop.cwd(),
    trace = "verbose",
    init_options = {
      settings = {
        ruff = {
          path = "/usr/bin/ruff",
        },
        -- interpreter = "/usr/bin/python",
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
  vim.diagnostic.reset()
  stopLsps({ names = { "pyright" } })
  -- M.start({ cmd = { "heaptrack", vim.fn.expand(opts.args) } })
  M.start({ cmd = { vim.fn.expand(opts.args) } })
end

end

local log_buffers = {}

local level_datetime_pattern = "%[([^%]]*)%]%[([^%]]*)%]"
local rpc_pattern = vim.regex('"rpc"')
local server_fd_pattern = '^"(.*)"$'
local rpc_receive_send_pattern = vim.regex("rpc.\\(receive\\|send\\)")
local exit_handler_pattern = vim.regex('"exit_handler"')
local receive_pattern = vim.regex("receive$")
local send_pattern = vim.regex("send$")
local lsp_server_pattern = '^"LSP%[(.+)%]"'
local client_request_pattern = vim.regex("client.request")
local initialize_params_pattern = vim.regex('\\("initialize_params"\\|"server_capabilities"\\)')
local default_handler_pattern = vim.regex('"default_handler"')
local server_request_pattern = vim.regex('"server_request"')
local server_request_method_pattern = vim.regex('"server_request: [^"]*"')

-- Cache highlight groups
local highlight_groups = {
  error = "LspLogError",
  warn = "LspLogWarn",
  info = "LspLogInfo",
  debug = "LspLogDebug",
  trace = "LspLogTrace",
}

-- Helper function to unescape special characters - precompile pattern
local unescape_pattern = "\\(.)"
local replacements = {
  n = "\n",
  t = "\t",
  r = "\r",
  ["\\"] = "\\",
  ['"'] = '"',
}

local function unescape_str(s)
  return s:gsub(unescape_pattern, function(x)
    return replacements[x] or ("\\" .. x)
  end)
end

-- Precompute dateformat for today's filter
local function get_today_date()
  return os.date("%Y-%m-%d")
end

local function process_line(line, lines, highlights, filter_date)
  local initial_line_count = #lines
  local parts = vim.split(line, "\t", { trimempty = true })
  if #parts < 2 then
    return
  end

  local header = parts[1]
  local level, datetime = header:match(level_datetime_pattern)
  if not level or not datetime then
    return
  end

  -- Apply today filter if needed
  if filter_date then
    local log_date = datetime:sub(1, 10)
    if log_date ~= filter_date then
      return
    end
  end

  -- Format level once
  local hl_group = highlight_groups[level:lower()] or highlight_groups.info

  -- Build metadata line
  local metadata_line = "[" .. level .. "] " .. datetime
  local line_num_relative = #lines

  -- Prepare highlights in batches
  local level_prefix_len = #level + 2 -- [level]

  -- DateTime highlight position
  local datetime_start = level_prefix_len + 2
  local datetime_end = datetime_start + #datetime

  -- Process specific log types more efficiently
  if rpc_pattern:match_str(parts[2]) then
    local server = parts[3]:gsub(server_fd_pattern, "%1")
    local fd = parts[4]:gsub(server_fd_pattern, "%1")
    local message = parts[5] and parts[5]:gsub(server_fd_pattern, "%1") or ""

    metadata_line = metadata_line .. "  " .. server .. " (" .. fd .. "):"
    table.insert(lines, metadata_line)

    -- Server highlight
    local server_start = datetime_end + 2
    table.insert(highlights, {
      "LspLogServer",
      line_num_relative,
      server_start,
      server_start + #server,
    })

    -- Add level highlight
    table.insert(highlights, {
      hl_group,
      line_num_relative,
      0,
      level_prefix_len,
    })

    -- Add datetime highlight
    table.insert(highlights, {
      "LspLogDateTime",
      line_num_relative,
      datetime_start,
      datetime_end,
    })

    -- Process message in one go if possible
    if message and message ~= "" then
      local msg_lines = {}
      for msg in unescape_str(message):gmatch("([^\n]+)") do
        table.insert(msg_lines, "  " .. msg)
      end

      for _, msg in ipairs(msg_lines) do
        table.insert(lines, msg)
      end
    end
  elseif rpc_receive_send_pattern:match_str(parts[2]) or exit_handler_pattern:match_str(parts[2]) then
    local data = parts[3] or ""
    local receive_or_send = parts[2]:gsub(server_fd_pattern, "%1")

    if receive_pattern:match_str(receive_or_send) then
      metadata_line = string.format("%s Received response:", metadata_line)
    elseif send_pattern:match_str(receive_or_send) then
      metadata_line = string.format("%s Sending request:", metadata_line)
    else
      metadata_line = string.format("%s (%s):", metadata_line, receive_or_send)
    end

    table.insert(lines, metadata_line)

    -- Add level highlight
    table.insert(highlights, {
      hl_group,
      line_num_relative,
      0,
      level_prefix_len,
    })

    -- Process data in chunks
    if data and data ~= "" then
      for l in data:gmatch("([^\n]+)") do
        table.insert(lines, "  " .. l)
      end
    end
  else
    -- Handle other cases with fewer string operations
    local modified = false
    local server_match = parts[2]:match(lsp_server_pattern)

    if server_match then
      metadata_line = metadata_line .. " " .. server_match
      modified = true

      if parts[3] and client_request_pattern:match_str(parts[3]) then
        local lsp_method = parts[5] and parts[5]:gsub(server_fd_pattern, "%1") or ""
        metadata_line = metadata_line .. "  " .. lsp_method

        table.insert(lines, metadata_line)
        if parts[6] then
          for l in parts[6]:gmatch("([^\n]+)") do
            table.insert(lines, "  " .. l)
          end
        end
      elseif parts[3] and initialize_params_pattern:match_str(parts[3]) then
        local lsp_method = parts[3]:gsub(server_fd_pattern, "%1")
        metadata_line = metadata_line .. "  " .. lsp_method

        table.insert(lines, metadata_line)
        if parts[4] then
          for l in parts[4]:gmatch("([^\n]+)") do
            table.insert(lines, "  " .. l)
          end
        end
      end
    elseif default_handler_pattern:match_str(parts[2]) then
      local lsp_method = parts[3] and parts[3]:gsub(server_fd_pattern, "%1") or ""
      metadata_line = metadata_line .. "  (" .. parts[2]:gsub(server_fd_pattern, "%1") .. ") " .. lsp_method

      table.insert(lines, metadata_line)
      if parts[4] then
        for l in parts[4]:gmatch("([^\n]+)") do
          table.insert(lines, "  " .. l)
        end
      end
      modified = true
    elseif server_request_pattern:match_str(parts[2]) then
      if server_request_method_pattern:match_str(parts[2]) then
        metadata_line = metadata_line
          .. "  "
          .. parts[2]:gsub(server_fd_pattern, "%1")
          .. ' "'
          .. (parts[3] and parts[3]:gsub(server_fd_pattern, "%1") or "")
          .. '"'
      else
        local lsp_method = parts[3] and parts[3]:gsub(server_fd_pattern, "%1") or ""
        metadata_line = metadata_line .. "  " .. parts[2]:gsub(server_fd_pattern, "%1") .. " " .. lsp_method

        table.insert(lines, metadata_line)
        if parts[4] then
          table.insert(lines, parts[4])
        end
        modified = true
      end
    end

    if not modified then
      local message = parts[2]:gsub(server_fd_pattern, "%1")
      metadata_line = metadata_line .. "  " .. message
    end

    if not modified or server_request_method_pattern:match_str(parts[2]) then
      table.insert(lines, metadata_line)
    end

    -- Add level highlight
    table.insert(highlights, {
      hl_group,
      line_num_relative,
      0,
      level_prefix_len,
    })
  end

  if #lines > initial_line_count then
    table.insert(lines, "") -- Add the empty line for spacing
  end
end

-- Batch update buffer
local function update_log_buffer(buf, arg, log_content, logger_win, ns)
  local lines = {}
  local highlights = {}
  local filter_date = arg == "today" and get_today_date() or nil
  local start_line_num = vim.api.nvim_buf_line_count(buf)

  -- Process content in chunks
  for line in log_content:gmatch("([^\n]+)") do
    process_line(line, lines, highlights, filter_date)
  end

  if #lines == 0 then
    return
  end

  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, start_line_num, start_line_num, false, lines)

  for _, hl in ipairs(highlights) do
    local line = hl[2] + start_line_num
    vim.hl.range(buf, ns, hl[1], { line, hl[3] }, { line, hl[4] })
  end

  vim.bo[buf].modifiable = false

  -- if the log window is focused don't scroll it as it will block the user from perusing
  if vim.api.nvim_get_current_win() == logger_win then
    return
  end
  -- Move cursor to bottom of the window
  local new_buf_len = vim.api.nvim_buf_line_count(buf)
  if new_buf_len > 0 then
    vim.api.nvim_win_set_cursor(logger_win, { new_buf_len, 0 })
  end
end

function M.ShowLspLogs(opts)
  local arg = opts.args and opts.args:gsub("%s+", "") or ""
  if arg:len() > 0 and arg ~= "today" then
    print(string.format("Invalid argument `%s`", opts.args))
  end

  local log_path = vim.lsp.get_log_path()
  local log_file = vim.uv.fs_open(log_path, "r", 438) -- 438 is 0666 in octal
  local log_file_size = vim.uv.fs_stat(log_path).size
  local read_offset = 0

  local buf = vim.fn.bufnr("LSP LOGS", true)
  if log_buffers[buf] then
    vim.notify("Log buffer already open!", vim.log.levels.INFO)
    return
  end

  -- Create a new horizontally split buffer
  vim.cmd("split")
  local logger_win = vim.api.nvim_get_current_win()
  vim.api.nvim_set_current_buf(buf)

  vim.api.nvim_buf_set_name(buf, "LSP LOGS")
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "log"
  vim.bo[buf].swapfile = false

  if not log_file then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "No LSP log file found: " .. log_path })
    vim.bo[buf].modifiable = false
    return
  end

  local ns = vim.api.nvim_create_namespace("LspLogs")

  -- Define highlight groups
  vim.api.nvim_set_hl(0, "LspLogError", { link = "Error" })
  vim.api.nvim_set_hl(0, "LspLogWarn", { link = "WarningMsg" })
  vim.api.nvim_set_hl(0, "LspLogDebug", { link = "Debug" })
  vim.api.nvim_set_hl(0, "LspLogInfo", { fg = "#2ECC71" })
  vim.api.nvim_set_hl(0, "LspLogTrace", { fg = "#9B59B6" })
  vim.api.nvim_set_hl(0, "LspLogDateTime", { bold = true })
  vim.api.nvim_set_hl(0, "LspLogServer", { italic = true })

  -- Setup buffer if not already initialized
  if not log_buffers[buf] then
    log_buffers[buf] = {
      timer = vim.uv.new_timer(),
      last_mtime = 0,
    }

    log_buffers[buf].timer:start(
      0,
      2000,
      vim.schedule_wrap(function()
        if not vim.api.nvim_buf_is_valid(buf) then
          log_buffers[buf].timer:close()
          log_buffers[buf] = nil
          return
        end

        local stat = vim.uv.fs_stat(log_path)
        local current_mtime = stat and stat.mtime.sec or 0

        -- check if the file changed
        if current_mtime > log_buffers[buf].last_mtime then
          log_buffers[buf].last_mtime = current_mtime
          local updated_log_file_size = vim.uv.fs_stat(log_path).size
          local read_size = log_file_size

          -- only read the new log content
          if updated_log_file_size - log_file_size > 0 then
            read_size = updated_log_file_size - log_file_size
            read_offset = log_file_size
          end
          local log_content = vim.uv.fs_read(log_file, read_size, read_offset)
          log_file_size = updated_log_file_size
          update_log_buffer(buf, arg, log_content, logger_win, ns)
        end
      end)
    )

    -- Clean up when buffer is closed
    vim.api.nvim_create_autocmd("BufDelete", {
      buffer = buf,
      callback = function()
        if log_buffers[buf] then
          vim.uv.fs_close(log_file)
          log_buffers[buf].timer:close()
          log_buffers[buf] = nil
        end
      end,
    })
  end

  vim.cmd("wincmd p")
end

return M
