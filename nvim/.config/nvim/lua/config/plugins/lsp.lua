local lsp_installer = require("nvim-lsp-installer")
local util = require('lspconfig.util')

local path = util.path

local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, '.python-version'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end


-- Include the servers you want to have installed by default below
local servers = {
  "pyright",
  "rust-analyzer",
  "sumneko_lua",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name .. "...")
      server:install()
    end
  end
end

local function custom_on_attach(client, bufnr)
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
  require "lsp_signature".on_attach()
  -- require "illuminate".on_attach(client)
end

local handlers =  {
  ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = 'rounded'}),
}

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = custom_on_attach,
    handlers = handlers,
  }

  if server.name == "rust_analyzer" then
    opts.settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      },
    }

    local extension_path = '/home/labatata/.vscode/extensions/vadimcn.vscode-lldb-1.6.10/'
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
    require("rust-tools").setup({
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
      tools = {
        hover_with_actions = false,
        inlay_hints = {
          other_hints_prefix = ":: ",
        }
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
      }
    })
    server:attach_buffers()
    return
  end

  if server.name == "pyright" then
    opts.on_init = function(client)
      client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    end
  end

  if server.name == "sumneko_lua" then
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    opts.settings = {
      ["Lua"] = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
  server:setup(opts)
end)

vim.diagnostic.config({severiy_sort = true})

vim.fn.sign_define("DiagnosticSignError", {text = "", texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn", {text = "", texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInformation", {text = "", texthl = "DiagnosticSignInformation"})
vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})

-- Show diagnostic popup on cursor hold
vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, source='if_many', border='rounded'})]]

-- Format on save
vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)]]
