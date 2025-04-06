local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

local dapui_extension = {
  sections = {
    lualine_a = {
      {
        "filename",
        file_status = false,
        color = { gui = "bold" },
      },
    },
  },
  inactive_sections = {
    lualine_a = { { "filename", file_status = false } },
  },
  filetypes = {
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "dapui_breakpoints",
  },
}

-- local terminal_extension = {
--   sections = {},
--   inactive_sections = {},
--   filetypes = {
--     "terminal-hide-lualine",
--   },
-- }

lualine.setup({
  options = {
    theme = "kanagawa",
    globalstatus = true,
  },
  extensions = { dapui_extension },
  sections = {
    lualine_a = {
      {
        "mode",
        color = {
          gui = "bold",
        },
      },
    },
    lualine_b = {
      {
        "diagnostics",
        symbols = { error = " ", warn = " ", info = " ", hint = "" },
      },
      {
        "branch",
      },
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
      },
    },
    lualine_c = {
      {
        "%=", -- set the next to be in the middle
        separator = "",
      },
      {
        function()
          local msg = "No Active Lsp"
          local buf_ft = vim.api.nvim_get_option_value("filetype", {})
          local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 and client.name ~= "null-ls" then
              return client.name
            end
          end
          return msg
        end,
        icon = " LSP:",
      },
    },
    lualine_x = {
      {
        "encoding",
        fmt = string.upper,
      },
      "fileformat",
      "filetype",
      "filesize",
    },
    lualine_z = {
      {
        "location",
        fmt = function(str)
          return str .. "|%L"
        end,
      },
    },
  },
})
