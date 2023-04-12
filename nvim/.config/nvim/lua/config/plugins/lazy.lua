require("lazy").setup({
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          insert_only = false,
          get_config = function(opts)
            if opts.prompt ~= nil and opts.prompt == "Save buffer before closing (Y/n)?" then
              return {
                prompt_align = "center",
                relative = "win",
              }
            end
          end,
        },
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    -- event = "BufRead",
    config = function()
      require("config.plugins.lsp")
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "sumneko_lua", "rust_analyzer", "pyright" },
      })
    end,
  },

  -- Show signature help
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("config.plugins.lsp_signature")
    end,
  },
  -- Creates missing LSP diagnostics highlight groups for color schemes that don't yet support the
  -- Neovim 0.5 builtin lsp client
  { "folke/lsp-colors.nvim" },

  -- Adds extra functionality over rust analyzer
  { "simrat39/rust-tools.nvim" },

  -- Formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "python",
    event = "BufRead",
    config = function()
      require("config.plugins.null_ls")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- run = ":TSUpdate",
    event = "BufRead",
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    -- ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.treesitter")
    end,
  },

  {
    "nvim-treesitter/playground",
    lazy = true,
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
  },

  -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>td", "<cmd>TroubleToggle document_diagnostics<CR>", noremap = true },
      { "gr", "<cmd>TroubleToggle lsp_references<CR>", noremap = true },
    },
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.plugins.trouble")
    end,
  },

  -- Show LSP load progress
  {
    "j-hui/fidget.nvim",
    ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.fidget")
    end,
  },

  -- Show a 💡 when a code action is available
  {
    "kosayoda/nvim-lightbulb",
    ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.lightbulb")
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
      -- Show pictograms for completion items
      "onsails/lspkind-nvim",
    },
    config = function()
      require("config.plugins.cmp")
    end,
  },

  -- Snippet
  {
    "L3MON4D3/LuaSnip",
    ft = vim.g.supported_languages,
    event = "InsertEnter",
    config = function()
      require("config.plugins.luasnip")
    end,
  },

  -- Themes
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      local colors = require("kanagawa.colors").setup()
      require("kanagawa").setup({
        globalStatus = true,
        overrides = {
          MoreMsg = { bg = colors.sumiInk2 },
          ["@type.qualifier"] = { link = "Keyword" },
        },
      })

      vim.cmd.colorscheme("kanagawa")
    end,
  },

  {
    "navarasu/onedark.nvim",
    lazy = true,
    config = function()
      require("onedark").setup({
        style = "deep",
        highlights = {
          ["@keyword.function"] = { fmt = "italic" },
          ["@conditional"] = { fmt = "bold" },
        },
      })
      -- require('onedark').load()
    end,
  },

  -- Show Identation Level Lines
  {
    "lukas-reineke/indent-blankline.nvim",
    ft = vim.g.supported_languages,
    config = function()
      require("config.plugins.indent_blankline")
    end,
  },

  -- Autoclose parentesis etc
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- Comment Code
  {
    "numToStr/Comment.nvim",
    keys = { "gcc", { "gc", mode = { "v", "n" } } },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", noremap = true },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", noremap = true },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", noremap = true },
      { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", noremap = true },
      { "<leader>ft", "<cmd>Telescope lsp_document_symbols<CR>", noremap = true },
      { "<leader>fw", "<cmd>Telescope lsp_workspace_symbols<CR>", noremap = true },
      { "<leader>fW", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", noremap = true },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("config.plugins.telescope")
    end,
  },

  -- status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.plugins.lualine")
    end,
  },

  -- Show tabs for open files
  {
    "akinsho/bufferline.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("config.plugins.bufferline")
    end,
  },

  -- Surround text with (), [], "", '' etc
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },

  -- Easily jump to far text
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    branch = "v1",
    config = function()
      require("hop").setup()
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "BufRead",
    config = function()
      require("neoscroll").setup()
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cond = function()
      local ok, util = pcall(require, "lspconfig.util")
      if ok then
        return util.find_git_ancestor(vim.fn.getcwd()) ~= nil
      else
        return false
      end
    end,
    config = function()
      require("config.plugins.gitsigns")
    end,
  },

  -- File explorer
  {
    "kyazdani42/nvim-tree.lua",
    keys = {
      { "<leader>fe", "<cmd>NvimTreeToggle<CR>", noremap = true },
    },
    config = function()
      require("nvim-tree").setup({
        diagnostics = {
          enable = true,
        },
        update_focused_file = {
          enable = true,
        },
        renderer = {
          highlight_git = true,
          highlight_opened_files = "2",
        },
      })
    end,
  },

  -- Cheatsheet
  {
    "sudormrfbin/cheatsheet.nvim",
    keys = { { "<leader>c", "<cmd>Cheatsheet<CR>", noremap = true } },
    cmd = "Cheatsheet",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("config.plugins.cheatsheet")
    end,
  },

  -- Better terminal
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<C-\\>",
        function()
          require("config.plugins.toggleterm").vertical_term_toggle()
        end,
        mode = { "n", "t" },
        noremap = true,
        silent = true,
      },
      "<C-t>",
    },
    config = function()
      require("config.plugins.toggleterm")
    end,
  },

  -- Session management
  {
    "rmagatti/auto-session",
    config = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
      require("auto-session").setup()
    end,
  },

  -- Wait for https://github.com/neovim/neovim/pull/17446
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      require("ufo").setup({
        fold_virt_text_handler = require("config.utils").text_handler,
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    ft = { "css", "javascript", "html", "typescript" },
    config = function()
      require("colorizer").setup({
        "css",
        "javascript",
        "typescript",
        html = {
          mode = "foreground",
        },
      })
    end,
  },

  -- Better Python Indentation
  { "Vimjas/vim-python-pep8-indent", ft = "python" },

  -- Lua configuration
  { "folke/neodev.nvim", ft = "lua" },

  -- Show which funtion I'm currently at in status line
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("nvim-navic").setup({ highlight = true, separator = "  " })
      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },

  {
    "editorconfig/editorconfig-vim",
    cond = function()
      return vim.fn.filereadable(".editorconfig") == 1
    end,
  },

  {
    "tweekmonster/startuptime.vim",
    cmd = "StartupTime",
  },

  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    config = function()
      require("flutter-tools").setup({
        flutter_lookup_cmd = "asdf where flutter",
      })
    end,
  },
})
