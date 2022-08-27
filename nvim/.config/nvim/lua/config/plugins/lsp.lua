local function custom_on_attach(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    -- if client.resolved_capabilities.document_highlight then
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

  require("lsp_signature").on_attach()
  require("nvim-navic").attach(client, bufnr)
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

local opts = {
  on_attach = custom_on_attach,
  handlers = handlers,
}

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers {

  ["rust_analyzer"] = function()
    opts.settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
        rustfmt = {
          extraArgs = {
            "--config",
            "max_width=120",
          },
        },
      },
    }

    local extension_path = vim.fn.stdpath("data") .. "/dapinstall/codelldb/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"
    local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
    require("rust-tools").setup({
      server = vim.tbl_deep_extend("force", {cmd = { vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer" }}, opts),
      tools = {
        runnables = { use_telescope = false },
        debuggables = { use_telescope = false },
        hover_with_actions = false,
        inlay_hints = {
          parameter_hints_prefix = "",
          other_hints_prefix = "-> ",
          show_variable_name = true,
        },
      },
      dap = {
        adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    })
  end,

  ["pyright"] = function()
    opts.on_init = function(client)
      local utils = require("config.utils")
      client.config.settings.python.pythonPath = utils.get_python_path(client.config.root_dir)
    end
    lspconfig.pyright.setup(opts)
  end,

  ["sumneko_lua"] = function()
    opts.settings = {
      ["Lua"] = {
        workspace = {
          checkThirdParty = false,
          completion = { callSnippet = "Disable" },
          workspace = { maxPreload = 5000 },
        },
        format = {
          enable = true,
        },
      },
    }
    lspconfig.sumneko_lua.setup(vim.tbl_deep_extend("force", require("lua-dev").setup(), opts))
  end
}

vim.diagnostic.config({ severiy_sort = true, update_in_insert = true })

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "<buffer>",
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false, source = "if_many", border = "rounded" })
  end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "<buffer>",
  callback = function()
    -- vim.schedule(function()
    vim.lsp.buf.format({
      timeout_ms = 2500,
      filter = function(client)
        return client.name ~= "clangd"
      end,
    })
    -- end)
  end,
})
