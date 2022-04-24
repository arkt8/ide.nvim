local ft = {}

function ft.ftplugin()
    local opt = vim.opt_local
    local map = vim.api.nvim_buf_set_keymap
    local bindopt = {noremap=true,silent=true}
    local filename = vim.api.nvim_buf_get_name(0)
    local function script_path()
        local str = debug.getinfo(2, "S").source:sub(2)
        return str:match("(.*/)")
    end
    opt.expandtab = true
    opt.shiftwidth = 2
    opt.softtabstop = 2

    opt.autoindent = true
    opt.smartindent = true


    map(0, "n", "\\x", "<cmd>!nim r --spellSuggest --showAllMismatches %<Enter>", bindopt)
    map(0, "n", "\\c", "<cmd>!nim compile --spellSuggest --showAllMismatches %<Enter>", bindopt)

    -- Nimble files get broken
    if filename:match(".nims?$") then
       require("lsp-config").setup("nimls", {
          -- We use a wrapper, so it not keeps hanging :)
          cmd = { script_path().."/nimlswrapper" }
          -- Defaults...
          -- cmd = { "nimlsp" },
          -- filetypes = { "nim" },
          -- single_file_support = true,
       })
    end

end

function ft.syntax()
   vim.cmd[[set syntax=nim]]
   vim.cmd[[syntax match nimDelimiter "[\[\]\(\)\{\},]"]]
   vim.cmd[[hi! link nimDelimiter Delimiter]]

   vim.cmd[[syntax match nimOperator "[=+*/<>@$~&%|!?^.:\\-]" ]]
   vim.cmd[[hi! link nimOperator Operator]]

   vim.cmd[[hi! link nimStatement Statement]]
   vim.cmd[[hi! link nimFunction Identifier]]
   vim.cmd[[hi! link nimBuiltin  Type]]
end

-- nimlsp doesn't works without a filesystem file. So when opening
-- an existent file we need to write it or nimlsp with stop working
function ft.newfile()
   vim.cmd[[:w]]
end

return ft
