-- vim.cmd([[ autocmd BufWritePost packer.lua source <afile> | PackerCompile ]])
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "packer.lua",
  command = "source <afile> | PackerCompile",
})

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

packer.startup({
  function(use)
    use("wbthomason/packer.nvim")

    -- Nice UI for vim.ui.select and vim.ui.input
    use({
      "stevearc/dressing.nvim",
      event = "BufRead",
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
    })

    -- LSP
    use({
      "neovim/nvim-lspconfig",
      -- event = "BufRead",
      config = function()
        require("config.plugins.lsp")
      end,
    })

    use({
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
    })

    use({
      "williamboman/mason-lspconfig.nvim",
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {"sumneko_lua", "rust_analyzer", "pyright"}
        })
      end,
    })

    -- Show signature help
    use({
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
        require("config.plugins.lsp_signature")
      end,
    })
    -- Creates missing LSP diagnostics highlight groups for color schemes that don't yet support the
    -- Neovim 0.5 builtin lsp client
    use({ "folke/lsp-colors.nvim", after = "nvim-lspconfig" })

    -- Adds extra functionality over rust analyzer
    use({ "simrat39/rust-tools.nvim", ft = "rust", after = "nvim-lspconfig" })

    -- Formatting
    use({
      "jose-elias-alvarez/null-ls.nvim",
      ft = "lua",
      event = "BufRead",
      config = function()
        require("config.plugins.null_ls")
      end,
    })

    use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
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
      requires = {
        {
          "nvim-treesitter/playground",
          after = "nvim-treesitter",
          cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor", "TSNodeUnderCursor" },
        },
        {
          "nvim-treesitter/nvim-treesitter-textobjects",
          after = "nvim-treesitter",
        },
      },
      -- ft = vim.g.supported_languages,
      config = function()
        require("config.plugins.treesitter")
      end,
    })

    -- A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
    use({
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      -- keys = {'<leader>td', 'gr'},
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.plugins.trouble")
      end,
    })

    -- Show LSP load progress
    use({
      "j-hui/fidget.nvim",
      ft = vim.g.supported_languages,
      config = function()
        require("config.plugins.fidget")
      end,
    })

    -- Show a 💡 when a code action is available
    use({
      "kosayoda/nvim-lightbulb",
      ft = vim.g.supported_languages,
      config = function()
        require("config.plugins.lightbulb")
      end,
    })

    -- Completion
    use({
      "hrsh7th/nvim-cmp",
      module = "cmp",
      event = "BufRead",
      requires = {
        { "hrsh7th/cmp-path", after = "nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp", after = { "nvim-cmp", "nvim-lspconfig" } },
        { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
        { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp" } },
        -- Show pictograms for completion items
        { "onsails/lspkind-nvim", after = "nvim-cmp", module = "lspkind" },
      },
      config = function()
        require("config.plugins.cmp")
      end,
    })

    -- Snippet
    use({
      "L3MON4D3/LuaSnip",
      ft = vim.g.supported_languages,
      event = "InsertEnter",
      config = function()
        require("config.plugins.luasnip")
      end,
    })

    -- Themes
    use({
      "rebelot/kanagawa.nvim",
      config = function()
        local default_colors = require("kanagawa.colors").setup()
        require("kanagawa").setup({
          overrides = {
            WinSeparator = { bg = "NONE", fg = default_colors.bg_dark },
            WinBar = { bold = false },
          },
        })
        vim.cmd([[colorscheme kanagawa]])
      end,
    })

    -- Show Identation Level Lines
    use({
      "lukas-reineke/indent-blankline.nvim",
      ft = vim.g.supported_languages,
      config = function()
        require("config.plugins.indent_blankline")
      end,
    })

    -- Autoclose parentesis etc
    use({
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup()
      end,
    })

    -- Comment Code
    use({
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
        require("Comment").setup()
      end,
    })

    -- Telescope
    use({
      "nvim-telescope/telescope.nvim",
      cmd = { "Telescope" },
      ft = "rust",
      -- keys = {'<leader>ff', '<leader>fg', '<leader>fb', 'ga'},
      module = "telescope",
      requires = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-ui-select.nvim", module = "telescope._extensions.ui-select" },
      },
      config = function()
        require("config.plugins.telescope")
      end,
    })

    -- status line
    use({
      "nvim-lualine/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = function()
        require("config.plugins.lualine")
      end,
    })

    -- Show tabs for open files
    use({
      "akinsho/bufferline.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("config.plugins.bufferline")
      end,
    })

    -- Surround text with (), [], "", '' etc
    use({ "tpope/vim-surround", event = "BufRead" })

    -- Easily jump to far text
    use({
      "phaazon/hop.nvim",
      event = "BufRead",
      branch = "v1",
      config = function()
        require("hop").setup()
      end,
    })

    -- Smooth scrolling
    use({
      "karb94/neoscroll.nvim",
      event = "BufRead",
      config = function()
        require("neoscroll").setup()
      end,
    })

    -- Git
    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      requires = {
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
    })

    -- A tree like view for LSP symbols
    use({
      "simrat39/symbols-outline.nvim",
      cmd = "SymbolsOutline",
    })

    -- File explorer
    use({
      "kyazdani42/nvim-tree.lua",
      -- cmd = "NvimTreeToggle",
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
    })

    -- Cheatsheet
    use({
      "sudormrfbin/cheatsheet.nvim",
      cmd = "Cheatsheet",
      requires = {
        { "nvim-telescope/telescope.nvim" },
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" },
      },
      config = function()
        require("config.plugins.cheatsheet")
      end,
    })

    -- Better terminal
    use({
      "akinsho/toggleterm.nvim",
      config = function()
        require("config.plugins.toggleterm")
      end,
    })

    -- Fix/Perfomance improvements
    use({ "antoinemadec/FixCursorHold.nvim", event = "BufReadPost" })
    use("nathom/filetype.nvim")
    use("lewis6991/impatient.nvim")

    -- Profile neovim startup time
    use("tweekmonster/startuptime.vim")

    -- Debug
    use({ "mfussenegger/nvim-dap", ft = vim.g.supported_languages })
    use({
      "rcarriga/nvim-dap-ui",
      requires = { "mfussenegger/nvim-dap" },
      after = "nvim-dap",
      config = function()
        require("config.plugins.dap")
      end,
    })
    -- use({
    --   "Pocco81/DAPInstall.nvim",
    --   cmd = { "DIInstall", "DIList", "DIUninstall" },
    --   after = "nvim-dap",
    --   config = function()
    --     require("config.plugins.DAPInstall")
    --   end,
    -- })

    use({
      "tjdevries/colorbuddy.nvim",
    })

    -- Better Python Indentation
    use({ "Vimjas/vim-python-pep8-indent", ft = "python" })

    -- Lua configuration
    use({ "folke/lua-dev.nvim", ft = "lua" })

    -- Show which funtion I'm currently at in status line
    use({
      "SmiteshP/nvim-navic",
      -- module = "SmiteshP/nvim-navic",
      config = function()
        require("nvim-navic").setup({ highlight = false, separator = "  " })
        vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      end,
    })

    use({ "editorconfig/editorconfig-vim" })

    -- Session management
    use({
      "rmagatti/auto-session",
      config = function()
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
        require("auto-session").setup()
      end,
    })

    -- Wait for https://github.com/neovim/neovim/pull/17446
    use({
      "kevinhwang91/nvim-ufo",
      requires = "kevinhwang91/promise-async",
      config = function()
        require("ufo").setup({
          fold_virt_text_handler = require("config.utils").text_handler,
          provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
          end,
        })
      end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if Packer_bootstrap then
      vim.notify("Installing plugins...")
      require("packer").sync()
    end
  end,
  config = {
    compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    clone_timeout = 180,
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "rounded" })
      end,
    },
  },
})

return packer
