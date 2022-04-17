--[[ Installed plugins to make it all work
local use = require('packer').use
require('packer').startup(function()
   use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
   use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
   use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
   use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
   use 'L3MON4D3/LuaSnip' -- Snippets plugin
end)

It is better add a call to the setup function of this module on specific
./nvim/lua/ftplugin/FILETYPE.lua

--]]
local M = {}

vim.api.nvim_set_keymap("n", "\\r",  "<cmd>LspStop<CR><cmd>LspStart<CR>", {noremap=true,silent=true})

local on_attach = function(client, bufnr)
   local opts = {noremap=true,silent=true}
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'nv', '\\F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'nv', '\\a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

-- luasnip setup
local luasnip = require 'luasnip'

-- Diagnostic popup configuration
vim.o.updatetime=250
vim.cmd[[autocmd CursorHold * lua vim.diagnostic.open_float(nim, {focus=false})]]
vim.diagnostic.config({
   virtual_text=true,
   float = { source = "always" } -- Or "if_many"
})

-- nvim-cmp setup
local cmp = require 'cmp'

local fn = {
   completeSuggested = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true -- As shown on ghost_text
   },
   completeSelected = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = false -- No complete if not explicitly selected
   },
   nextItem = function(fallback)
      if cmp.visible() then
         cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
         fallback()
      end
   end,
   prevItem = function(fallback)
      if cmp.visible() then
         cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
         vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
         fallback()
      end
   end,
   unobstrusive = function(fallback)
      if cmp.visible() then cmp.mapping.abort() end
      fallback()
   end
}


cmp.setup {
   experimental = { ghost_text = true },
   snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
   mapping = {
      -- Cancel completion
      ['<C-e>'] = cmp.mapping.close(),
      ['<S-Left>'] = function (fallback)
         if cmp.visible() then cmp.mapping.close() else fallback() end
      end,

      -- Confirm Completion
      ['<Insert>'] = fn.completeSuggested,
      ['<S-Right>'] = fn.completeSuggested,
      ['<CR>'] = fn.completeSelected,

      -- Suggestion Menu Navigation
      ['<S-Down>'] = fn.nextItem,
      ['<C-j>']    = fn.nextItem,
      ['<S-Up>']   = fn.prevItem,
      ['<C-k>']    = fn.prevItem,

      -- Suggestion Documentation Navigation
      ['<S-PageUp>'] = cmp.mapping.scroll_docs(-4),
      ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
      ['<S-PageDown>'] = cmp.mapping.scroll_docs(4),
      ['<C-Down>'] = cmp.mapping.scroll_docs(4),

      -- Unobstrusive behavior
      ['<Up>']   = fn.unobstrusive,
      ['<Down>'] = fn.unobstrusive,
      ['<Tab>']  = fn.unobstrusive,
      ['<S-Tab>'] = fn.unobstrusive,
   },
   sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
   },
}

-- Avoid restart on filetype
local singleSet = {}
function M.setup(server, config)

   -- Lsp's not work well with temporary files as
   -- the generated to compare in diff
   if vim.o.diff == true then return end

   vim.opt_local.signcolumn="yes"
   if singleSet[server] == true then return end
   local lsp = require("lspconfig")

   config.on_onattach = on_attach
   config.capabilities = capabilities
   config.provideFormatter = true
   config.flags = { debounce_text_changes = 150 }

   lsp[server].setup(config)

   -- Since we configure with ftplugin we need to restart Lsp
   -- Observe that Lsp will be configured and started a single
   -- time.
   vim.cmd[[LspStop]]
   vim.cmd[[LspStart]]
   singleSet[server] = true
end

return M
