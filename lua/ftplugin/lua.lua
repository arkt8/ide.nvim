local ft = {}


function ft.ftplugin()
  vim.bo.expandtab = true
  vim.bo.shiftwidth = 2
  vim.bo.softtabstop = 2
  vim.bo.tabstop = 2

  -- LSP Configuration
  -- Requires Lua Language Server]
  -- (https://github.com/sumneko/lua-language-server)
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  require("lsp-config").setup("sumneko_lua", {
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
    }
  })
end

function ft.syntax()
  vim.cmd[[syntax match luaDelimiter "[:{}()]" ]]
  vim.cmd[[hi! link luaFunction Functions]]
  vim.cmd[[hi! link luaDelimiter Delimiter]]
end

return ft
