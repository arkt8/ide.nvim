return require( "packer" ).startup( function( use )
  use "wbthomason/packer.nvim"        -- | Plugin Manager

  -- Language Tools --------------------------------------------------
  use "neovim/nvim-lspconfig"         -- | Default config for NeoVim lsp
  use "hrsh7th/nvim-cmp"              -- | Autocompletion plugin
  use "hrsh7th/cmp-nvim-lsp"          -- | LSP source for nvim-cmp
  use "saadparwaiz1/cmp_luasnip"      -- | Snippets source for nvim-cmp
  use "L3MON4D3/LuaSnip"              -- | Snippets plugin
  use "zah/nim.vim"                   -- | Syntax highlight for Nim

  -- Interface & Colorschemes ----------------------------------------
  use "nvim-lualine/lualine.nvim"     -- | Status line
  use "morhetz/gruvbox"
  use "whatyouhide/vim-gotham"
  use "dracula/vim"
  use "jacoborus/tender"
  use "arcticicestudio/nord-vim"
  use "nanotech/jellybeans.vim"
  use "drewtempelmeyer/palenight.vim"
  use "catppuccin/nvim"

  -- Tools -----------------------------------------------------------
  use "nvim-telescope/telescope.nvim" -- | Fuzzy finder
  use "nvim-lua/plenary.nvim"         -- | Dependenty for telescope

end )


