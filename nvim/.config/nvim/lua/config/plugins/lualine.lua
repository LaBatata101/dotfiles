local dapui_extension = {
  sections = {
    lualine_a = {
      {
        'filename',
        file_status = false,
        color = {gui = 'bold'}
      }
    },
  },
  inactive_sections = {
    lualine_a = {{'filename', file_status = false}}
  },
  filetypes = {
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
    "dapui_breakpoints",
  }
}


require("lualine").setup {
  options = {
    theme = 'tokyonight',
  },
  extensions = { dapui_extension },
  sections = {
    lualine_a = {
      {
        'mode',
        color = {
          gui = 'bold'
        }
      }
    },
    lualine_b = {
      {
        'diagnostics',
        symbols = { error = " ", warn = " ", info = " ", hint = "" },
      },
    {
        'diff',
        symbols = { added = " ", modified = "柳", removed = " " },
      }
    },
    lualine_c = {
      {
        'filename',
        separator = '',
        color = {
          gui = 'italic'
        }
      },
      {
        '%=', -- set the next to be in the middle
        separator = ''
      },
      {
        function()
          local msg = 'No Active Lsp'
          local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
          local clients = vim.lsp.get_active_clients()
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
        icon = ' LSP:',
        -- color = { gui = 'bold' },
      },
    },
    lualine_x = {
      {
        'encoding',
        fmt = string.upper,
      },
      'fileformat', 'filetype', 'filesize'},
    lualine_z = {
      {
        'location',
        fmt = function(str)
          return str.."|%L"
        end
      }
    },
  }
}
