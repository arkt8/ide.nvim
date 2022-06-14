return require( "packer" ).startup( function( use )
  use "wbthomason/packer.nvim"        -- | Plugin Manager

  -- Language Tools --------------------------------------------------
  use "neovim/nvim-lspconfig"         -- | Default config for NeoVim lsp

  use "hrsh7th/cmp-nvim-lsp"          -- | LSP source for nvim-cmp
  use "hrsh7th/cmp-buffer"            -- | In buffer completion
  use "hrsh7th/cmp-path"              -- | Path comp
  use "hrsh7th/cmp-cmdline"           -- | Command line comp
  use "hrsh7th/nvim-cmp"              -- | Autocompletion plugin

  use "L3MON4D3/LuaSnip"              -- | Snippets plugin
  use "saadparwaiz1/cmp_luasnip"      -- | Snippets source for nvim-cmp

  use "arkt8/nim.vim"                 -- | Syntax highlight for Nim
  use "jakwings/vim-terra"            -- | Support for terralang

  -- Interface & Colorschemes ----------------------------------------
  use "nvim-lualine/lualine.nvim"     -- | Status line
  use "morhetz/gruvbox"
  use "whatyouhide/vim-gotham"
  use "dracula/vim"
  use "jacoborus/tender"
  use "nanotech/jellybeans.vim"
  use "drewtempelmeyer/palenight.vim"
  use "catppuccin/nvim"
  use "kwsp/halcyon-neovim"
  use "lucastrvsn/kikwis"
  use "Shatur/neovim-ayu"


  -- Tools -----------------------------------------------------------
  use "nvim-telescope/telescope.nvim" -- | Fuzzy finder
  use "nvim-lua/plenary.nvim"         -- | Dependenty for telescope

end )


