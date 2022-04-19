local ft = {}
local colors = require "colors"

function ft.ftplugin()
   -- Wrap lines to act like a text processor
   vim.o.wrap = 1
   vim.o.linebreak = 1
end


function ft.syntax()

   colors.hiLink("Constant", {
      "markdownCode",
      "markdownCodeBlock"
   })

   colors.hiLink("Comment", {
      "markdownCodeDelimiter",
      "markdownBoldDelimiter",
      "markdownBoldItalicDelimiter",
      "markdownItalicDelimiter",
      "markdownH1Delimiter",
      "markdownH2Delimiter",
      "markdownH3Delimiter",
      "markdownH4Delimiter",
      "markdownH5Delimiter",
      "markdownH6Delimiter",
      "markdownHeadingDelimiter",
      "markdownIdDelimiter",
      "markdownLinkDelimiter",
      "markdownLinkTextDelimiter",
      "markdownUrlDelimiter",
      "markdownUrlTitleDelimiter"
   })

   colors.hiLink("Special",{
      "markdownBold",
      "markdownBoldItalic",
      "markdownItalic"
   })
end

return ft
