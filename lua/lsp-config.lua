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

function lala () print( "oi") end
-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
   experimental = { ghost_text = true },
   snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end, },
   mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         -- select = true, -- No complete on Enter if not explicitly selected
      },
      ['<Tab>'] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
         else
            fallback()
         end
      end,
      ['<S-Tab>'] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
         else
            fallback()
         end
      end,
   },
   sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
   },
}

-- Avoid restart on filetype
local singleSet = {}
function M.setup(server, config)
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
