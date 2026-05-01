-- vim.lsp.set_log_level("debug")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

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
      require("nvim-navic").attach(client, args.buf)
    end
  end,
})

vim.g.rustaceanvim = function()
  return {
    settings = {
      ["rust-analyzer"] = {
        -- checkOnSave = {
        --   command = "clippy",
        -- },
        cargo = {
          allFeatures = true,
        },
        rustfmt = {
          extraArgs = {
            "--config",
            "max_width=120",
          },
        },
      },
    },
    dap = {
      adapter = "",
    },
  }
end

-- local utils = require("config.utils")

-- local pwd = vim.loop.cwd()
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "python",
--   callback = function()
--     vim.lsp.start({
--       name = "SithLSP",
--       filetypes = { "python" },
--       root_dir = pwd,
--       cmd = { vim.fn.expand("~/Code/Rust/python-lsp/target/debug/sith-lsp") },
--       init_options = {
--         settings = {
--           interpreter = utils.get_python_bin_path(pwd),
--         },
--       },
--     })
--   end,
-- })

-- local lspconfig = require("lspconfig")
-- local configs = require("lspconfig.configs")
--
-- if not configs.sith_lsp then
--   local root_files = {
--     "pyproject.toml",
--     "setup.py",
--     "requirements.txt",
--     "Pipfile",
--     "pyrightconfig.json",
--     ".git",
--   }
--   configs.sith_lsp = {
--     default_config = {
--       cmd = { "sith-lsp" },
--       root_dir = function(fname)
--         return lspconfig.util.root_pattern(unpack(root_files))(fname)
--       end,
--       filetypes = { "python" },
--     },
--   }
-- end

vim.lsp.config("ts_ls", {
  init_options = {
    settings = {
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
    },
  },
})

vim.lsp.config("zls", {
  init_options = {
    settings = {
      enable_build_on_save = true,
      build_on_save_args = { "check" },
    },
  },
})

vim.diagnostic.config({
  severiy_sort = true,
  update_in_insert = true,
  virtual_text = { current_line = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "󰋼 ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

-- Show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = "*",
  callback = function()
    vim.diagnostic.open_float({ focus = false, source = true, border = "rounded" })
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
