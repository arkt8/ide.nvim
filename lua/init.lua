-- :To create ftplugin files in Lua format put your files into:
-- ~/.config/nvim/lua/ftplugin/FILETYPE/init.lua
vim.api.nvim_create_autocmd({"VimEnter,FileType","BufReadPost","FileType","BufCreate","BufNewFile"}, {
   pattern = {"*"},
   callback = function()
      local ftplugin = ("ftplugin.%s"):format(vim.bo.filetype)
      local ok,res = pcall(require,ftplugin)
      if not ok
      and not res:match("Module '"..ftplugin.."' not found")
      and not res:match("	no file") then print(res) end
   end
})

