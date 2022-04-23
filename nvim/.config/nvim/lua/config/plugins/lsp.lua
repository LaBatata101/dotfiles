local function custom_on_attach(client, _)
  if client.name == "sumneko_lua" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end

  if client.resolved_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end

  require("lsp_signature").on_attach()
end

local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
}

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = custom_on_attach,
    handlers = handlers,
  }

  if server.name == "rust_analyzer" then
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
      server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
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
    server:attach_buffers()
    return
  end

  if server.name == "pyright" then
    opts.on_init = function(client)
      local utils = require("config.utils")
      client.config.settings.python.pythonPath = utils.get_python_path(client.config.root_dir)
    end
  end

  if server.name == "pylsp" then
    opts.settings = {
      ["pylsp"] = {
        plugins = {
          flake8 = {
            enabled = true,
          },
          pylint = {
            enabled = true,
          },
          mypy = {
            overrides = { "--python-executable", require("config.utils").get_python_path(vim.fn.getcwd()) },
          },
        },
      },
    }
  end

  if server.name == "sumneko_lua" then
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
    opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
  server:setup(opts)
end)

vim.diagnostic.config({ severiy_sort = true, update_in_insert = true })

vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint" })

-- Show diagnostic popup on cursor hold
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false, source='if_many', border='rounded'})]])

-- Format on save
-- vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)]])
vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]])
