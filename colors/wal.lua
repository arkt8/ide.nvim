-----------------------------------------------------------------
-- Neovim adaptive colorscheme for wal
-- © 2022 - Thadeu de Paula
--
-- Depends on:
-- * thadeudepaula/ide.nvim  lua/colors.lua module
-- * github.com/dylanraps/pywal
-- * lua json module
-----------------------------------------------------------------
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "wal"
vim.cmd[[ hi clear ]]

if vim.fn.exists[[ syntax on ]] then vim.cmd[[ syntax reset ]] end

------ Dependencies ------
local json   = require "json"
local colors = require "colors"

------ Shortcuts ---------
local sum, mix, hi = colors.sum, colors.mix, colors.hi

local wal = {}
do
   local cfile = io.open(os.getenv("HOME").."/.cache/wal/colors.json","r" )
   local waldata = json.decode(cfile:read("*a"))
   cfile:close()
   for i,v in pairs(waldata.colors) do wal[i] = v end
   waldata.special = waldata.special or {}
   wal.bg = waldata.special.background or wal.color0  or "#000000"
   wal.fg = waldata.special.foreground or wal.color15 or "#ffffff"
   wal.cursor = waldata.special.cursor or wal.color15 or "#ffffff"
   wal.comment = mix(wal.color8, wal.fg, 0.24)
   wal.dim0 = sum( wal.bg, "#040404")
   wal.dim1 = sum( wal.bg, "#080808")
   wal.dim2 = sum( wal.bg, "#1f1f1f")
   wal.bgsel = mix( wal.bg, wal.fg, 0.03)
   -- Semaphoric
end

hi( "NormalNC",     wal.bg,     wal.fg,      "None" )
hi( "Normal",       wal.bgsel,  wal.fg,      "None" )
hi( "Comment",      "None",     wal.comment, "italic" )
hi( "NonText",      wal.color0, wal.color8,  "None" )
hi( "Whitespace",   "None",     wal.color8,  "None" )
hi( "EndOfBuffer",  "None",     wal.color0,  "None" )
hi( "VertSplit",    "None",     wal.dim2,    "None" )
hi( "LineNr",       "None",     wal.dim2,    "None" )
hi( "CursorLineNr", "None",     wal.color0,  "None" )
hi( "StatusLineNC", "None",     wal.dim1,    "None" )
hi( "StatusLine",   "None",     wal.dim2,    "None" )
hi( "ColorColumn",  wal.dim0 )
hi( "SpecialKey",   "None",     wal.color7,  "None" )
hi( "Conceal",      "None",     wal.color0,  "None" )
hi( "Directory",    "None",     wal.color11, "None" )

hi("WarningMsg",   "None", wal.color3, "None" )
hi("Folded",       "None", wal.color6, "italic" )
hi("SignColumn",   "None", wal.color3, "None" )
hi("MoreMsg",      "None", wal.color7, "None" )

hi("NormalFloat",  "None", wal.color7, "None" )
hi("Visual",       "None", wal.color13, "reverse" )
hi("VisualNOS",    "None", wal.color13, "reverse" )

-- Managed by ide.nvim colors module
-- hi( "CursorColumn", wal.color0, "None",      "None" )
-- hi( "CursorLine",   wal.color0, "None",      "None" )
-- hi("Cursor", "None", wal.color7 )
-- hi("lCursor", "None", wal.color7 )
-- hi("CursorIM", "None", wal.color7 )
-- hi("Pmenu",        "None", wal.color7, "None" )
-- hi("PmenuSel",     wal.color8,   wal.color7, "None" )
-- hi("PmenuSbar",    wal.color8,   "bg", "None" )
-- hi("PmenuThumb",   wal.color7,   "bg", "None" )
-- hi("StatusLine", "None",    wal.color7, "" )
-- hi("StatusLineNC", "None",  wal.color7, "" )
-- hi("FoldColumn",   "None", wal.color6, "None" )
-- hi("Error",mix(colors.bg,guicolors.error,0.2),mix(guicolors.error,colors.fg,0.2),"italic")
-- hi("ErrorInline",guicolors.error,mix(guicolors.error,colors.fg,0.7),"italic")
-- hi("TermCursor", "None", wal.color7, "" )
-- hi("TermCursorNC", "None", wal.color7, "" )
-- hi("ModeMsg", "None", wal.color7, "" )
-- hi("MsgArea", "None", wal.color7, "" )
-- hi("MsgSeparator", "None", wal.color7, "" )
-- hi("NormalNC", "None", wal.color7, "" )

hi( "Question",     "None", wal.color7, "None" )
hi( "Search",       "None", wal.color3, "reverse" )
hi( "IncSearch",    "None", wal.color3, "reverse" )
hi( "Substitute",   "None", wal.color4, "reverse" )
hi( "MatchParen",   "None", wal.color3, "bold,italic" )
-- hi("QuickFixLine", "None", wal.color7, "" )
-- hi("SpellBad", "None", wal.color7, "" )
-- hi("SpellCap", "None", wal.color7, "" )
-- hi("SpellLocal", "None", wal.color7, "" )
-- hi("SpellRare", "None",  wal.color7, "" )
hi("TabLineSel",  wal.color2, wal.color0, "None" )
hi("TabLine",     wal.color8, wal.color7, "None" )
hi("TabLineFill", wal.color0, wal.color7, "None" )
hi("Title",       "None", "wal.color12", "bold" )
hi("Todo",  "None", wal.color15, "bold" )
hi("WildMenu",    "None", wal.color7, "None" )

--
-- These groups are not listed as default vim groups,
-- but they are defacto standard group names for syntax highlighting.
-- Note that they are grouped by family, being the first of each
-- the default in case other are disabled.

hi("Constant",    "None",  wal.color10, "None" )
hi("String",      "None",  wal.color10, "None" )
hi("Character",   "None",  wal.color10, "None" )
hi("Number",      "None",  wal.color10, "None" )
hi("Float",       "None",  wal.color10, "None" )
hi("Boolean",     "None",  wal.color10, "bold" )

hi("Functions",   "None", wal.color9, "Italic" ) -- Language native
hi("Function",    "None", wal.color15, "None" ) -- Declaration
hi("Identifier",  "None", wal.color15, "None" )
hi("FunctionCall","None", wal.color15, "None" ) -- On call only

hi("Delimiter",   "None", wal.color3, "None" )

hi("Repeat",         "None", wal.color1, "italic" )
hi("RepeatOperator", "None", wal.color1, "italic")
hi("Statement",      "None", wal.color1, "italic" )

hi("Conditional", "None", wal.color1, "Italic" )
hi("Operator",    "None", wal.color1, "Bold,Italic" )

hi("Label",       "None", wal.color9, "None" )
hi("Keyword",     "None", wal.color9, "italic,bold" )
hi("Exception",   "None", wal.color7 )

hi("PreProc",     "None", wal.color9, "italic" )
hi("Include",     "None", wal.color9, "italic" )
hi("Define",      "None", wal.color9, "italic" )
hi("Macro",       "None", wal.color9, "italic" )
hi("PreCondit",   "None", wal.color9, "italic" )

hi("Type",        "None", wal.color13, "bold" )
hi("StorageClass","None", wal.color13, "None" )
hi("Structure",   "None", wal.color13, "italic" )
hi("Typedef",     "None", wal.color13, "bold" )

hi("Special",        "None", wal.color9, "italic" )
hi("SpecialChar",    "None", wal.color7 )
hi("Tag",            "None", wal.color7 )
hi("SpecialComment", "None", wal.color8, "bold,italic" )
hi("Debug",          "None", wal.color3, "italic" )

hi("htmlStrike"     , "None", wal.color4, "strikethrough")
hi("htmlItalic"     , "None", wal.color12, "italic")
hi("htmlBold"       , "None", wal.color13, "bold")
hi("htmlBoldItalic" , "None", wal.color14, "bold,italic")

collectgarbage()
