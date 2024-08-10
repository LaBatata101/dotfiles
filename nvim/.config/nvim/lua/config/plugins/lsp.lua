-- vim.lsp.set_log_level("debug")

local function custom_on_attach(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", {})
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = lsp_document_highlight,
      pattern = "<buffer>",
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = lsp_document_highlight,
      pattern = "<buffer>",
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.server_capabilities.inlayHintProvider then
    vim.lsp.inlay_hint.enable(true)
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  require("lsp_signature").on_attach()
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

local opts = {
  on_attach = custom_on_attach,
  handlers = handlers,
}

require("neodev").setup({ setup_jsonls = false })

vim.g.rustaceanvim = function()
  local codelldb = require("mason-registry").get_package("codelldb")
  local extension_path = codelldb:get_install_path()
  local codelldb_path = extension_path .. "/codelldb"
  local liblldb_path = extension_path .. "/extension/lldb/lib/liblldb.so"

  local cfg = require("rustaceanvim.config")
  return {
    server = {
      on_attach = custom_on_attach,
    },
    settings = {
      ["rust-analyzer"] = {
        -- checkOnSave = {
        --   command = "clippy",
        -- },
        rustfmt = {
          extraArgs = {
            "--config",
            "max_width=120",
          },
        },
      },
    },
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
  function(server_name)
    if server_name ~= "rust_analyzer" then
      lspconfig[server_name].setup({})
    end
  end,
  ["pyright"] = function()
    opts.on_init = function(client)
      local utils = require("config.utils")
      client.config.settings.pythonPath = utils.get_python_bin_path(client.config.root_dir)
    end
    lspconfig.pyright.setup(opts)
  end,
  ["lua_ls"] = function()
    opts.settings = {
      ["Lua"] = {
        workspace = {
          checkThirdParty = false,
          completion = { callSnippet = "Disable" },
          workspace = { maxPreload = 5000 },
        },
        format = {
          enable = false,
        },
      },
    }
    lspconfig.lua_ls.setup(opts)
  end,
  ["tsserver"] = function()
    opts.settings = {
      ["javascript"] = {
        format = {
          enable = false,
        },
      },
      ["typescript"] = {
        format = {
          enable = false,
        },
      },
    }

    lspconfig.tsserver.setup(opts)
  end,
})

vim.diagnostic.config({ severiy_sort = true, update_in_insert = true })

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float({ focus = false, source = "always", border = "rounded" })
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "clangd"
      end,
    })
  end,
})

-- Issue: https://github.com/neovim/neovim/issues/23291
local watch_type = require("vim._watch").FileChangeType

local function handler(res, callback)
  if not res.files or res.is_fresh_instance then
    return
  end

  for _, file in ipairs(res.files) do
    local path = res.root .. "/" .. file.name
    local change = watch_type.Changed
    if file.new then
      change = watch_type.Created
    end
    if not file.exists then
      change = watch_type.Deleted
    end
    callback(path, change)
  end
end

function watchman(path, opts, callback)
  vim.system({ "watchman", "watch", path }):wait()

  local buf = {}
  local sub = vim.system({
    "watchman",
    "-j",
    "--server-encoding=json",
    "-p",
  }, {
    stdin = vim.json.encode({
      "subscribe",
      path,
      "nvim:" .. path,
      {
        expression = { "anyof", { "type", "f" }, { "type", "d" } },
        fields = { "name", "exists", "new" },
      },
    }),
    stdout = function(_, data)
      if not data then
        return
      end
      for line in vim.gsplit(data, "\n", { plain = true, trimempty = true }) do
        table.insert(buf, line)
        if line == "}" then
          local res = vim.json.decode(table.concat(buf))
          handler(res, callback)
          buf = {}
        end
      end
    end,
    text = true,
  })

  return function()
    sub:kill("sigint")
  end
end

if vim.fn.executable("watchman") == 1 then
  require("vim.lsp._watchfiles")._watchfunc = watchman
end
