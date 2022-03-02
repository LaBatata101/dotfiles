local dap = require("dap")
local dapui = require("dapui")

dap.defaults.fallback.terminal_win_cmd = "belowright 9 new"

-- local dap_install = require("dap-install")
-- dap_install.config("codelldb", {})
-- dap.configurations.rust = {
--   {
--     type = "codelldb",
--     request = "launch",
--     name = "Launch file",
--     program = function()
--       local metadata_json = vim.fn.system("cargo metadata --format-version 1 --no-deps")
--       local metadata = vim.fn.json_decode(metadata_json)
--       local target_name = metadata.packages[1].targets[1].name
--       local target_dir = metadata.target_directory
--       return target_dir .. "/debug/" .. target_name
--     end,
--     cwd = "${workspaceFolder}",
--     stopOnEntry = true,
--   },
-- }

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open("sidebar")
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
