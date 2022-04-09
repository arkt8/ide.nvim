local opt = vim.opt_local
local map = vim.api.nvim_buf_set_keymap
local bindopt = {noremap=true,silent=true}

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4

opt.autoindent = true
opt.smartindent = true

map(0, "n", "\\x", "<cmd>!nim r --spellSuggest --showAllMismatches %<Enter>", bindopt)

require("lsp-config").setup("nimls", {
  --[[ Using defaults! ]]
  -- cmd = { "nimlsp" },
  -- filetypes = { "nim" },
  -- single_file_support = true,
})

