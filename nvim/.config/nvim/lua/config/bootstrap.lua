local M = {}

-- Automatically download packer
function M.install_packer()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    print("Downloading packer...")
    Packer_bootstrap = fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd([[packadd packer.nvim]])
    print("packer.nvim installed")
  end
end

function M.install_language_servers()
  local ok, lsp_installer = pcall(require, "nvim-lsp-installer")
  if not ok then
    return
  end

  for _, name in pairs(vim.g.language_servers) do
    local server_is_found, server = lsp_installer.get_server(name)
    if server_is_found then
      if not server:is_installed() then
        print("Installing " .. name .. "...")
        server:install()
      end
    end
  end
end

return M
