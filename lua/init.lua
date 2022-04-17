
local ftmodule="ftplugin.%s"
local function loadftmodule(ft,action)
   local modname = ftmodule:format(ft)
   local ok, res = pcall(require,modname)
   if type(res)  == "table" then
      if type(res[action]) == "function" then
         res[action]()
      end
   elseif type(res) == "string"
      and not res:match("Module '"..modname.."' not found")
      and not res:match("	no file")
   then print(res) end
end

-- :To create ftplugin files in Lua format put your files into:
-- ~/.config/nvim/lua/ftplugin/FILETYPE/init.lua
vim.api.nvim_create_autocmd({"FileType"}, {
   pattern = {"*"},
   callback = function() loadftmodule(vim.bo.filetype,"ftplugin") end
})

vim.api.nvim_create_autocmd({"FileType"}, {
   pattern = {"*"},
   callback = function() loadftmodule(vim.bo.filetype,"newfile") end
})

vim.api.nvim_create_autocmd({"VimEnter","BufWinEnter","Colorscheme"}, {
   pattern = {"*"},
   callback = function() loadftmodule(vim.bo.filetype,"syntax") end
})
