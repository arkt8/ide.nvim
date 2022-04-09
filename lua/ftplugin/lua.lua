vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 3
vim.opt_local.softtabstop = 3

-- LSP Configuration
-- Requires Lua Language Server]
-- (https://github.com/sumneko/lua-language-server)
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lsp-config").setup("sumneko_lua", {
   settings = {
      Lua = {
         runtime = {
            version = "5.4",
            path = runtime_path
         },
         diagnostics = { globals = { "vim" } },
         telemetry = { enable = false }
      }
   },
   -- cmd = { os.getenv("HOME").."/.local/lib/sumneko_lua/bin/lua-language-server" }
})
