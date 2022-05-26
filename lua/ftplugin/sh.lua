local ft = {}


function ft.ftplugin()
  vim.bo.expandtab = true
  vim.bo.shiftwidth = 2
  vim.bo.softtabstop = 2
  vim.bo.tabstop = 2

  -- LSP Configuration Requires:
  -- * bash-lsp (https://github.com/bash-lsp/bash-language-server)
  -- * shellcheck
  local runtime_path = vim.split(package.path, ';')
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  require("lsp-config").setup("bashls", {
    settings = {}
  })
end

function ft.syntax()

end

return ft
