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

local id = nil
local filter = filter_by({})
local config = nil
local M = {}

local function attach_lsp(args)
  if id == nil then
    return
  end

  local bufnr = args.buffer or args.buf
  if not bufnr or not filter(bufnr) then
    return
  end

  if not vim.lsp.buf_is_attached(args.buffer, id) then
    vim.lsp.buf_attach_client(args.buffer, id)
  end
end

function M.restart(updated_config)
  config = vim.tbl_deep_extend("force", {}, config or {}, updated_config or {})
  M.stop()
  M.start(config)
end

function M.stop()
  if id == nil then
    return
  end

  vim.lsp.stop_client(id)
  id = nil
end

--- @param opts {cmd: string[]}
function M.start(opts)
  if id ~= nil then
    return
  end

  id = vim.lsp.start_client({
    name = "python-lsp-server",
    cmd = opts.cmd,
    root_dir = vim.loop.cwd(),
    trace = "verbose",
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
  print(opts.fargs[1])
  stopLsps({ names = { "pyright" } })
  M.start({ cmd = { vim.fn.expand(opts.fargs[1]) } })
end

return M
