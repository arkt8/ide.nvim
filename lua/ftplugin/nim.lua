local ft = {}

local function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

-- As separated function in an attempt of also call it
-- with \r when nimsuggest hangs
local function nim_lsprestart()
   for _,v in pairs( vim.lsp.get_active_clients() ) do
      if v.name == "nimls" then return end
   end
   local cfg = require "lspconfig.configs"
   print("Restarting Nim Language Server")
   cfg.nimls.launch()
end


-- Options for the filetype
function ft.ftplugin()
   local opt = vim.opt_local
   local map = vim.api.nvim_buf_set_keymap
   local bindopt = {noremap=true,silent=true}
   local filename = vim.api.nvim_buf_get_name(0)

   opt.expandtab = true
   opt.shiftwidth = 2
   opt.softtabstop = 2

   opt.autoindent = true
   opt.smartindent = true
   if filename:match(".*%.nim$") then
      _G.nim_lsprestart = nim_lsprestart
      map(0, "n", "\\x", "<cmd>!nim r --spellSuggest --showAllMismatches %<Enter>", bindopt)
      map(0, "n", "\\c", "<cmd>!nim compile --spellSuggest --showAllMismatches %<Enter>", bindopt)
      map(0, "n", "\\r", "<cmd>lua _G.nim_lsprestart()<Enter>", bindopt)
      -- Graceful restart, if nimlsp hangs out
      vim.api.nvim_create_autocmd(
         {"BufWritePost", "BufWinEnter"},
         { pattern = {"*.nim$"}, callback = nim_lsprestart }
      )

      -- Using Neovim's Language Server Api with nimlsp
      require("lsp-config").setup("nimls",{
         cmd                 = {"nimlsp"},
         filetypes           = {"nim"},
         single_file_support = true
      })
   end
end

--
-- syntax tweaks, to make more consistent thru langs
--
function ft.syntax()
   vim.cmd[[set syntax=nim]]
   vim.cmd[[syntax match nimoperator "[=+*/<>@$~&%|!?^.:\\-]" ]]
end

-- nimlsp doesn't works without a filesystem file. So when opening
-- an existent file we need to write it or nimlsp with stop working
function ft.newfile()
   vim.cmd[[:w]]
end

return ft
