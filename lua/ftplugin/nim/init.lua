local opt = vim.opt_local
local map = vim.api.nvim_buf_set_keymap
local bindopt = {noremap=true,silent=true}
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

require("lsp-config").setup("nimls", {
   -- We use a wrapper, so it not keeps hanging :)
   cmd = { script_path().."/nimlswrapper" }
   -- Defaults...
   -- cmd = { "nimlsp" },
   -- filetypes = { "nim" },
   -- single_file_support = true,
})

