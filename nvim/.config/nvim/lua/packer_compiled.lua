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
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["DAPInstall.nvim"] = {
    config = { "\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30config.plugins.DAPInstall\frequire\0" },
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/DAPInstall.nvim",
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
      ["nvim-cmp"] = true,
      ["nvim-lspconfig"] = true
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
  ["hop.nvim"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/hop.nvim",
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
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    config = { "\27LJ\1\2<\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0!config.plugins.lsp_signature\frequire\0" },
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    load_after = {
      ["nvim-lspconfig"] = true
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
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\1\2<\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\19nvim-autopairs\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp-vsnip", "cmp-nvim-lsp", "nvim-autopairs", "cmp-buffer", "cmp-path" },
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
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "lsp_signature.nvim", "lsp-colors.nvim", "cmp-nvim-lsp", "lspkind-nvim", "renamer.nvim", "nvim-lightbulb" },
    config = { "\27LJ\1\0022\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\23config.plugins.lsp\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
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
    load_after = {
      ["nvim-lspconfig"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/opt/renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim"
  },
  ["rust-tools.nvim"] = {
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
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/labatata/.local/share/nvim/site/pack/packer/start/vim-surround",
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

-- Config for: DAPInstall.nvim
time([[Config for DAPInstall.nvim]], true)
try_loadstring("\27LJ\1\0029\0\0\2\0\2\0\0044\0\0\0%\1\1\0>\0\2\1G\0\1\0\30config.plugins.DAPInstall\frequire\0", "config", "DAPInstall.nvim")
time([[Config for DAPInstall.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file RustDebuggables lua require("packer.load")({'telescope.nvim'}, { cmd = "RustDebuggables", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Telescope lua require("packer.load")({'telescope.nvim'}, { cmd = "Telescope", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file TroubleToggle lua require("packer.load")({'trouble.nvim'}, { cmd = "TroubleToggle", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Trouble lua require("packer.load")({'trouble.nvim'}, { cmd = "Trouble", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-treesitter', 'indent-blankline.nvim', 'nvim-lspconfig', 'fidget.nvim', 'nvim-dap', 'vim-vsnip'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-treesitter', 'indent-blankline.nvim', 'nvim-lspconfig', 'fidget.nvim', 'nvim-dap', 'vim-vsnip'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType vim ++once lua require("packer.load")({'nvim-treesitter', 'indent-blankline.nvim', 'nvim-lspconfig', 'fidget.nvim', 'nvim-dap', 'vim-vsnip'}, { ft = "vim" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'nvim-treesitter', 'indent-blankline.nvim', 'nvim-lspconfig', 'fidget.nvim', 'nvim-dap', 'vim-vsnip'}, { ft = "c" }, _G.packer_plugins)]]
vim.cmd [[au FileType rust ++once lua require("packer.load")({'nvim-treesitter', 'indent-blankline.nvim', 'nvim-lspconfig', 'fidget.nvim', 'nvim-dap', 'vim-vsnip', 'rust-tools.nvim'}, { ft = "rust" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-cmp', 'vim-vsnip'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufReadPost * ++once lua require("packer.load")({'FixCursorHold.nvim'}, { event = "BufReadPost *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fusion.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fusion.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/fusion.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdresource.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gdscript.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glimmer.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glimmer.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glimmer.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glsl.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glsl.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/glsl.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gowork.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gowork.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/gowork.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/graphql.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hack.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hack.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hack.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hcl.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/heex.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hjson.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hjson.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/hjson.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/json5.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ledger.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/nix.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/prisma.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/prisma.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/prisma.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/pug.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/pug.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/pug.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/ql.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/query.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/surface.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/teal.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/tlaplus.vim]], false)
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]], true)
vim.cmd [[source /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]]
time([[Sourcing ftdetect script at: /home/labatata/.local/share/nvim/site/pack/packer/opt/nvim-treesitter/ftdetect/yang.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
