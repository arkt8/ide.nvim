local ft = {}


function ft.ftplugin()
  vim.bo.expandtab = true
  vim.bo.shiftwidth = 2
  vim.bo.softtabstop = 2
  vim.bo.tabstop = 2

  -- LSP Configuration
  -- Requires Clangd installed
  require("lsp-config").setup("clangd", {
    --[[
    settings = {
      rootPatterns = {".git/"},
      Lua = {
        runtime = {
          version = 'Lua 5.4',
          path = {
            '?.lua',
            '?/init.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.4/?.lua',
            vim.fn.expand'~/.luarocks/share/lua/5.4/?/init.lua',
            '/usr/share/5.4/?.lua',
            '/usr/share/lua/5.4/?/init.lua'
          }
        },
        diagnostics = {
            enable  = true,
            globals = {"vim"},
            disable = {"lowercase-global"}
        },
        workspace = {
          library = {
            vim.fn.expand'~/.luarocks/share/lua/5.4',
            '/usr/share/lua/5.4'
          }
        },
        telemetry = {
          enable = false
        }
      }
    }--]]
  })
end

function ft.syntax()

end

return ft
