local colors = {}

local vimBG, vimFG = "None","None"
local rgbBG, rgbFG = "#111111", "#dddddd"
local strHi = "hi! %s guibg=%s guifg=%s gui=%s"
local strHiLink = "hi! link %s %s"
local semaphore = {
   red     = "#ff3388",
   yellow  = "#ff8800",
   neutral = "#3388ff",
   green   = "#33ff88"
}

local function decompose(rgb)
   local r,g,b = rgb:match('(..)(..)(..)$')
   return tonumber(r,16),tonumber(g,16),tonumber(b,16)
end

local function compose(r,g,b)
   return string.format('#%02x%02x%02x',r,g,b)
end

local function colorops(rgb1, rgb2, x, fn)
   local r1,g1,b1 = decompose(rgb1)
   local r2,g2,b2 = decompose(rgb2)
   return compose( fn(r1,r2,x), fn(g1,g2,x), fn(b1,b2,x) )
end

local function chsum(c1,c2) return math.max(0,math.min(255,c1+c2)) end
local function chsub(c1,c2) return math.max(0,math.min(255,c1-c2)) end
local function chmix(c1,c2,ratio)
   local min,max = math.min(c1,c2), math.max(c1,c2)
   return math.floor( min + ((max-min) * ratio) )
end

local function italicizeReservedKeywords()
   -- Some days we just want to use less contrast colorss. In this case,
   -- italics help us to know when we correctly typed a language reserved word
   for _,syn in ipairs {
      "Boolean",
      "Conditional",
      "Constant",
      "Debug",
      "Function",
      "Identifier",
      "Keyword",
      "Operator",
      "PreProc",
      "Repeat",
      "RepeatOperator",
      "Special",
      "Statement",
      "Structure",
      "Type"
   } do
      local color = colors.getHi(syn)
      colors.hi(syn, color.bg, color.fg, "italic")
   end
end

local function setErrorColor(dark,light)
   colors.hi( "Error","None",dark,"italic")
   colors.hiLink("Error", { "ALEError", "CocErrorHighlight", "DiagnosticVirtualTextError", "ErrorMsg" })

   colors.hi( "SignError",dark,light,"bold")
   colors.hiLink("SignError", {"ALEErrorSign","CocErrorSign","DiagnosticSignError",})

   colors.hi( "DiagnosticFloatingError","None",light,"None")
end

local function setWarnColor(dark,light)
   colors.hi( "Warn","None",dark,"italic")
   colors.hiLink("Warn", { "DiagnosticWarn", "DiagnosticVirtualTextWarn" } )

   colors.hi( "SignWarn",dark,light,"bold")
   colors.hiLink("SignWarn", {"ALEWarnSign", "CocWarnSign", "DiagnosticSignWarn",})

   colors.hi( "DiagnosticFloatingWarn","None",light,"None")
end

local function setHintColor(dark,light)
   colors.hi( "Hint", "None", dark, "italic")
   colors.hiLink("Hint", {"ALEHint", "CocHintHighlight", "DiagnosticVirtualTextHint" })

   colors.hi( "SignHint",dark,light,"bold")
   colors.hiLink("SignHint", {"ALEHintSign", "CocHintSign", "DiagnosticSignHint",})

   colors.hi( "DiagnosticFloatingHint","None",light,"None")

end

local function setInfoColor(dark,light)
   colors.hi( "Info","None",dark,"italic")
   colors.hiLink("Info", { "ALEInfo", "CocInfoHighlight", "DiagnosticVirtualTextInfo" })

   colors.hi( "SignInfo",dark,dark,"italic")
   colors.hiLink("SignInfo", {"ALEInfoSign","CocInfoSign","DiagnosticSignInfo",})

   colors.hi( "DiagnosticFloatingInfo", "None", light, "None")
end

local function setDiffColor()
   local bg = colors.getHi("Normal").bg or "#000000"
   local red = colors.mix( semaphore.red, bg, 0.2 )
   colors.hi( "DiffAdd",    colors.mix( semaphore.green,   bg, 0.1),   "None",           "None" )
   colors.hi( "DiffChange", colors.mix( semaphore.neutral, bg, 0.1),   "None",           "None" )
   colors.hi( "DiffText",   colors.mix( semaphore.neutral, bg, 0.3),   "None",           "None" )
   colors.hi( "DiffDelete", red, red, "None" )
end

local function setLualineModifications()
   local c = colors.getHi("Normal")
   local f = colors.getHi("Comment").fg or "#888888"
   c.bg, c.fg = c.bg or "#000000", c.fg or "#dddddd"
   local a1 = colors.mix(c.bg,c.fg,0.8)
   local a2 = colors.getHi("String").fg or colors.getHi("MoreMsg") or c.fg
   local a3 = colors.getHi("Number").fg or colors.getHi("Type") or c.fg
   local a4 = colors.getHi("Special").fg or colors.getHi("Boolean") or c.fg
   local bcolor = colors.mix(c.bg,c.fg,0.2)
   local ccolor = colors.mix(c.bg,c.fg,0.1)

   local custom = {
   normal  = { a = { bg = a1, fg = c.bg, gui="bold" }
             , b = { bg = bcolor, fg = c.fg }
             , c = { bg = ccolor, fg = c.fg } },
   insert  = { a = { bg = a2, fg = c.bg, gui="bold" }
             , b = { bg = bcolor, fg = c.fg }
             , c = { bg = ccolor, fg = c.fg } },
   replace = { a = { bg = a3, fg = c.bg, gui="bold" }
             , b = { bg = bcolor, fg = c.fg }
             , c = { bg = ccolor, fg = c.fg } },
   visual  = { a = { bg = a4, fg = c.bg, gui="bold" }
             , b = { bg = bcolor, fg = c.fg }
             , c = { bg = ccolor, fg = c.fg } }
   }

   custom.command = custom.normal
   custom.inactive = custom.normal
   colors.hi("LuaLineSemaphore1",bcolor,colors.mix(f, semaphore.red,    0.75))
   colors.hi("LuaLineSemaphore2",bcolor,colors.mix(f, semaphore.yellow, 0.75))
   colors.hi("LuaLineSemaphore3",bcolor,colors.mix(f, c.fg, 0.75))
   colors.hi("LuaLineSemaphore4",bcolor,colors.mix(f, semaphore.green,  0.75))
   require("lualine").setup {
      options = {
         theme = custom,
         diff_color = {
            added    = "LuaLineSemaphore4",
            modified = "LuaLineSemaphore2",
            removed  = "LuaLineSemaphore1"
         },
         diagnostics_color = {
            error = "LuaLineSemaphore1",
            warn = "LuaLineSemaphore2",
            info = "LuaLineSemaphore4",
            hint = "LuaLineSemaphore3"
         },
         -- Freedom for hard users
         section_separators = {},
         component_separators = {},
         icons_enabled = false,
      },
      sections = {
         lualine_a = {
            {"mode", fmt=function(s) return s:sub(1,1) end}
         },
         lualine_b = {
            {"diagnostics", fmt=function(s) return s:gsub(":","") end }
         },
         lualine_x = {
            {[[("%s'%s'%s"):format(vim.bo.filetype,vim.bo.fileencoding,vim.bo.fileformat)]]}
         }
      }
   }
end


--
-- Exported functions
--

function colors.sum(rgb1,rgb2) return colorops( rgb1,rgb2,nil,chsum ) end
function colors.sub(rgb1,rgb2) return colorops( rgb1,rgb2,nil,chsub ) end
function colors.mix(rgb1, rgb2, ratio) return colorops(rgb1,rgb2,ratio,chmix) end

function colors.getHi(name)
   local hex = "%06x"
   local _,c = pcall(vim.api.nvim_get_hl_by_name,name,true)
   if not _ then c = {} end
   return {
      bg = c.background and '#'..hex:format(c.background) or nil,
      fg = c.foreground and '#'..hex:format(c.foreground) or nil
   }
end

function colors.hi(syn, guibg, guifg, gui)
  vim.cmd( strHi:format(syn, (guibg or "None"), (guifg or "None"), (gui or "None") ) )
end

function colors.hiLink(to,from)
   for _,v in pairs(from) do vim.cmd(strHiLink:format(v, to)) end
end

-- Use colors passed as arguments, left as main, others are defaults
-- intended mainly for use on dotfiles shared across multiple systems
function colors.use(...)
   local cmd = "colorscheme %s"
   for _,v in ipairs({...}) do
      local ok = pcall(vim.cmd, cmd:format(v))
      if ok then return end
   end
end

function colors.update()
   local hi,getHi,hiLink,mix = colors.hi, colors.getHi, colors.hiLink, colors.mix
   local comment = getHi("Comment").fg or "#555555"
   local ui = getHi("Normal")
   ui.bg = ui.bg or "#111111"
   ui.fg = ui.fg or "#dddddd"

   -- Lsp unobstrusive colors
   -- Warn always yellowish and Error always reddish independent of scheme
   local semaphore = { "#ff0033", "#ff6600", "#888888", "#00ff66" }

   setErrorColor( mix(comment, semaphore[1], 0.5), mix(semaphore[1],ui.fg,0.5) )
   setWarnColor(  mix(comment, semaphore[2], 0.5), mix(semaphore[2],ui.fg,0.5) )
   setHintColor(  mix(comment, semaphore[3], 0.5), mix(semaphore[3],ui.fg,0.5) )
   setInfoColor(  mix(comment, semaphore[4], 0.5), mix(semaphore[4],ui.fg,0.5) )
   setLualineModifications(semaphore)
   setDiffColor()

   -- UI Elements
   local bghilight = mix(ui.bg, ui.fg, 0.1)
   hiLink("LineNr",{"SignColumn"})
   hi("PMenu",      bghilight,                ui.fg,  "None")
   hi("PmenuSel",   mix( ui.bg, ui.fg, 0.4),  ui.fg,  "bold")
   hi("PmenuSbar",  mix( ui.bg, ui.fg, 0.15), ui.fg,  "bold")
   hi("PmenuThumb", mix( ui.bg, ui.fg, 0.5),  ui.fg,  "bold")
   hi("NormalFloat",mix( ui.bg, ui.fg, 0.1),  "None", "None")
   hi("ColorColumn",mix( ui.bg, ui.fg, 0.05), "None", "None")
   hi("FoldColumn", "None", ui.fg,  "None")
   hi("VertSplit",  "None", mix( ui.bg, ui.fg, 0.5),  "bold")
   hi("NonText",    "None", ui.bg,  "None")

   hi("CursorLine",   bghilight, "None","None")
   hi("CursorLineNr", bghilight, ui.fg, "None")

   -- Avoid brain draining visuals on errors shown when using
   -- low-contrast or low-saturation colorschemes
   italicizeReservedKeywords()
end
vim.api.nvim_create_autocmd({"VimEnter","ColorScheme","FileType","BufReadPost" },{
   pattern = {"*"},
   callback = colors.update
})

return colors
