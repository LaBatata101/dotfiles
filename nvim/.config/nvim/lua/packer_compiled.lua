-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/labatata/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?.lua;/home/labatata/.cache/nvim/packer_hererocks/2.0.5/share/lua/5.1/?/init.lua;/home/labatata/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?.lua;/home/labatata/.cache/nvim/packer_hererocks/2.0.5/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/labatata/.cache/nvim/packer_hererocks/2.0.5/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\fComment\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["DAPInstall.nvim"] = {
    commands = { "DInstall", "DIList", "DIUninstall" },
    config = { "\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30config.plugins.DAPInstall\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/DAPInstall.nvim",
    url = "https://github.com/Pocco81/DAPInstall.nvim"
  },
  ["FixCursorHold.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/FixCursorHold.nvim",
    url = "https://github.com/antoinemadec/FixCursorHold.nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-vsnip"] = {
    after_files = { "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-vsnip/after/plugin/cmp_vsnip.vim" },
    load_after = {
      ["nvim-cmp"] = true,
      ["vim-vsnip"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/cmp-vsnip",
    url = "https://github.com/hrsh7th/cmp-vsnip"
  },
  ["fidget.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\26config.plugins.fidget\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["gitsigns.nvim"] = {
    cond = { "\27LJ\1\2z\0\0\2\0\6\0\0154\0\0\0%\1\1\0>\0\2\0027\0\2\0004\1\3\0007\1\4\0017\1\5\1>\1\1\0=\0\0\2\v\0\0\0T\0\2€)\0\1\0T\1\1€)\0\2\0H\0\2\0\vgetcwd\afn\bvim\22find_git_ancestor\19lspconfig.util\frequire\0" },
    config = { "\27LJ\1\0027\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\28config.plugins.gitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\1\0021\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\bhop\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\1\2?\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0$config.plugins.indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-colors.nvim"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\1\2<\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0!config.plugins.lsp_signature\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["neoscroll.nvim"] = {
    config = { "\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14neoscroll\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\1\0026\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\27config.plugins.null_ls\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2<\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-vsnip", "lspkind-nvim", "cmp-buffer", "cmp-path", "cmp-nvim-lsp" },
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23config.plugins.cmp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    after = { "nvim-dap-ui" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23config.plugins.dap\frequire\0" },
    load_after = {
      ["nvim-dap"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\1\0028\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\29config.plugins.lightbulb\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lsp-installer"] = {
    commands = { "LspInstall", "LspInstallInfo", "LspPrintInstalled", "LspRestart", "LspStart", "LspStop", "LspUninstall", "LspUninstallAll" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp_signature.nvim", "lsp-colors.nvim", "cmp-nvim-lsp", "rust-tools.nvim" },
    loaded = true,
    only_config = true
  },
  ["nvim-treesitter"] = {
    commands = { "TSInstall", "TSInstallInfo", "TSInstallSync", "TSUninstall", "TSUpdate", "TSUpdateSync", "TSDisableAll", "TSEnableAll" },
    config = { "\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30config.plugins.treesitter\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["renamer.nvim"] = {
    config = { "\27LJ\1\0025\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\frenamer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim"
  },
  ["rust-tools.nvim"] = {
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["startuptime.vim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/startuptime.vim",
    url = "https://github.com/tweekmonster/startuptime.vim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope", "RustDebuggables" },
    config = { "\27LJ\1\0028\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\29config.plugins.telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    commands = { "TroubleToggle", "Trouble" },
    config = { "\27LJ\1\0026\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\27config.plugins.trouble\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-vsnip"] = {
    after = { "cmp-vsnip", "vim-vsnip-integ" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/vim-vsnip",
    url = "https://github.com/hrsh7th/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    after_files = { "/home/labatata/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ/after/plugin/vsnip_integ.vim" },
    load_after = {
      ["vim-vsnip"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ",
    url = "https://github.com/hrsh7th/vim-vsnip-integ"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^cmp"] = "nvim-cmp",
  ["^telescope%._extensions%.ui%-select"] = "telescope-ui-select.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23config.plugins.lsp\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Conditional loads
time([[Conditional loading of gitsigns.nvim]], true)
  require("packer.load")({"gitsigns.nvim"}, {}, _G.packer_plugins)
time([[Conditional loading of gitsigns.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd lsp-colors.nvim ]]
vim.cmd [[ packadd lsp_signature.nvim ]]

-- Config for: lsp_signature.nvim
try_loadstring("\27LJ\1\2<\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0!config.plugins.lsp_signature\frequire\0", "config", "lsp_signature.nvim")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspInstall lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspStop lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspStop", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file RustDebuggables lua require("packer.load")({'telescope.nvim'}, { cmd = "RustDebuggables", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUninstall lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspStart lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspStart", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspUninstallAll lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspUninstallAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSInstallSync lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSInstallSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSInstallInfo lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSInstallInfo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspUninstall lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSInstall lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspRestart lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspRestart", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspPrintInstalled lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspPrintInstalled", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file LspInstallInfo lua require("packer.load")({'nvim-lsp-installer'}, { cmd = "LspInstallInfo", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIList lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DInstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSDisableAll lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSDisableAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUpdateSync lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUpdateSync", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSUpdate lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSUpdate", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TSEnableAll lua require("packer.load")({'nvim-treesitter'}, { cmd = "TSEnableAll", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIUninstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'indent-blankline.nvim', 'nvim-dap', 'fidget.nvim', 'renamer.nvim', 'vim-vsnip', 'nvim-lightbulb'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'indent-blankline.nvim', 'nvim-dap', 'fidget.nvim', 'renamer.nvim', 'vim-vsnip', 'nvim-lightbulb'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'indent-blankline.nvim', 'nvim-dap', 'fidget.nvim', 'renamer.nvim', 'vim-vsnip', 'nvim-lightbulb'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'indent-blankline.nvim', 'nvim-dap', 'fidget.nvim', 'renamer.nvim', 'vim-vsnip', 'nvim-lightbulb'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'indent-blankline.nvim', 'nvim-dap', 'fidget.nvim', 'renamer.nvim', 'vim-vsnip', 'nvim-lightbulb', 'rust-tools.nvim'}, { ft = "rust" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'FixCursorHold.nvim'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs', 'vim-vsnip'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'nvim-treesitter', 'vim-surround', 'hop.nvim', 'nvim-cmp', 'Comment.nvim', 'neoscroll.nvim', 'nvim-lsp-installer', 'null-ls.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
