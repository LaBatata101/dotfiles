local ok, null_ls = pcall(require, "null-ls")

if not ok then
  return
end

local utils = require("config.utils")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.mypy.with({
      extra_args = { "--python-executable", utils.get_python_bin_path(vim.fn.getcwd()), "--ignore-missing-imports" },
      method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    }),
    -- null_ls.builtins.formatting.ruff,
    null_ls.builtins.formatting.black.with({
      extra_args = { "-l", "120", "--preview" },
    }),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.prettier.with({
      extra_args = { "--print-width", "100", "--tab-width", "4" },
    }),
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
  },
})
