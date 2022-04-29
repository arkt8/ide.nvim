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
   local bufkey = vim.api.nvim_buf_set_keymap
   -- Enable completion triggered by <c-x><c-o>
   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


   -- Mappings.
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   bufkey( bufnr, 'n', 'gD',        '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   bufkey( bufnr, 'n', 'gd',        '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   bufkey( bufnr, 'n', 'gt',        '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   bufkey( bufnr, 'n', 'gr',        '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   bufkey( bufnr, 'n', 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   bufkey( bufnr, 'n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   bufkey( bufnr, 'n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   bufkey( bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   bufkey( bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   bufkey( bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   bufkey( bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   bufkey( bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   bufkey( bufnr, 'nv', '\\F',      '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   bufkey( bufnr, 'nv', '\\a',      '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
end

-- luasnip setup
local luasnip = require 'luasnip'

-- Diagnostic popup configuration
vim.o.updatetime=250
vim.cmd[[autocmd CursorHold * lua vim.diagnostic.open_float(nim, {focus=false})]]
vim.diagnostic.config({
   virtual_text=true,
   float = { source = "always" } -- "always" / "if_many"
})

--
-- nvim-cmp setup
--
local cmp = require 'cmp'

local fn = {
   complete = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true -- As shown on ghost_text
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
   -- Only execute default if menu isnt visible, or close it
   closeOrThrough = function(fallback)
      if cmp.visible() then cmp.close() else fallback() end
   end,
   -- If menu visible closes it and go through
   closeAndThrough = function(fallback)
      if cmp.visible() then cmp.close() end
      fallback()
   end
}

cmp.setup({
   enabled = true,
   -- experimental = { ghost_text = false },
   snippet = { expand = function(args)
         require('luasnip').lsp_expand(args.body)
   end},
   completion = {
      keyword_length = 2,
      -- keyword_pattern = " %w+",
      -- autocomplete = cmp.TriggerEvent.InsertEnter,
      autocomplete = {
         cmp.TriggerEvent.TextChanged,
         cmp.TriggerEvent.InsertEnter,
      },
      completeopt = "menuone,preview",
   },

   matching = {
      disallow_fuzzy_matching = false
   },
   mapping = cmp.mapping.preset.insert({
      -- Confirm Completion
      ['<Insert>']  = fn.complete,
      ['<Tab>']     = fn.complete,
      ['<CR>']      = fn.complete,

      -- Suggestion Menu Navigation
      ['<C-j>']     = fn.nextItem,
      ['<C-k>']     = fn.prevItem,

      -- Suggestion Documentation Navigation
      ['<S-Up>']    = cmp.mapping.scroll_docs(-4),
      ['<C-Up>']    = cmp.mapping.scroll_docs(-4),
      ['<S-Down>']  = cmp.mapping.scroll_docs(4),
      ['<C-Down>']  = cmp.mapping.scroll_docs(4),

      -- Cancel completion
      ['<Esc>']     = fn.closeOrThrough,
      -- ['<Right>']   = fn.closeAndThrough,
      ['<Left>']    = fn.closeAndThrough,
   }),
   sources = {
      { name = 'luasnip' , priority = 1 }, -- L3MON4D3/LuaSnip
      { name = 'nvim_lsp', priority = 2 }, -- hrsh7th/cmp-nvim-lsp
      { name = 'path'    , priority = 3 }, -- hrsh7th/cmp-path
      { name = 'buffer'  , priority = 4 }, -- hrsh7th/cmp-buffer
      { name = 'cmdline' , priority = 5 }, -- hrsh7th/cmp-cmdline
   },
   -- cmp-nvim says to use this way, but works as above as well
   -- one call less
   -- sources = cmp.config.sources({
   --    { name = 'nvim_lsp' }, -- hrsh7th/cmp-nvim-lsp
   --    { name = 'luasnip' },  -- L3MON4D3/LuaSnip
   --    { name = 'buffer' },   -- hrsh7th/cmp-buffer
   --    { name = 'path' },     -- hrsh7th/cmp-path
   --    { name = 'cmdline'},   -- hrsh7th/cmp-cmdline
   -- }),
   --preselect = "none",
   view = {
      entries = {
         name = "custom",
         selection_order = "near_cursor"
      },
   },
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

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
   -- Observe that Lsp will be configured a single time.
   singleSet[server] = true


   vim.cmd[[LspStop]]
   vim.cmd[[LspStart]]
end

return M
