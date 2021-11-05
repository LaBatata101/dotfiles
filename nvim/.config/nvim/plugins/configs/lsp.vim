lua << EOF
local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
        on_attach = require "lsp_signature".on_attach(),
    }

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end
    if server.name == "rust_analyzer" then 
        opts.settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            },
        }
    end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
    server:setup(opts)
end)

--require'lspconfig'.pyright.setup{}
--local lsp_installer_servers = require'nvim-lsp-installer.servers'
--
--local ok, pyright = lsp_installer_servers.get_server("pyright")
--if ok then
--    local opts = {
--        on_attach = require "lsp_signature".on_attach(),
--    }
--
--    pyright:setup(opts)
--end

--require'lspconfig'.rust_analyzer.setup{
--    settings = {
--            ["rust-analyzer"] = {
--                checkOnSave = {
--                    command = "clippy"
--                }
--            },
--    },
--
--    on_attach = require "lsp_signature".on_attach()
--}

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
EOF

" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Format on save
autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
