# NeoVim + LSP ready for Nim

This repository is intended as a minimal usable configuration with
these resources enabled:

* NeoVim LSP, autocomplete and snippets
* Nim language + LSP
* Fuzzy finder to speedup large project findings
* Some visual eyecandies
* 100% Lua configuration (including ftplugin)
* UX on colors

Use it to understand how to configure LSP or structure Lua files or
even explore Neovim as your Nim IDE.


## UX on colors

Framework over colorschemes handpicked to avoid eyestrain:

- Semaphoric colors for warnings/errors/hints that prevails over all
  colorschemes to a consistent behavior.

- Italicized reserved words for languages independent on colorscheme
  used

- Soften UI element backgrounds to shades between background and
  foreground colors, this way you will not be sad using a nice
  colorscheme that hurts by the color of every popup suggestion


## Quickstart

* Install a plugin manager. The examples in this repo
  [Packer](https://github.com/wbthomason/packer.nvim)
  so if you prefer other package manager, adapt this configuration.

* If you already have a configuration, BACK IT UP! By default,
  Packer will use the same install directory.

* Move your `~/.config/nvim` folder to other place... and clone this
  repo as `~/.config/nvim`

* Enter Neovim, issue `:PackerCompile` and `:PackerUpdate` (if you
  already use it, it will ask for removing directories, you simply
  can ignore if you want.

* Exit Neovim and open a nim file to play around. Snippets,
  autocompletion and hints/errors in virtual text should be running.
  Tweak keybindings inside the `lua/lsp-config.lua` as you want.

* If you want to proceed reconfiguring all your NeoVim from this point,
  you can add plugins editing `lua/plugins.lua` file, reloading it with
  `:luafile %`, then `:PackerCompile` and finally `:PackerUpdate`.


## Steps to work with Nim

* choosenim: Follow official directions to install choosenim, and pick
  the Nim compiler
* nimble: install the default package manager for Nim
* nimlsp: using nimble, run `nimble install nimlsp`

After that you should be ready to have a lot of fun with the
best editor and the best multiparadigm language.


## LSP for other Languages

See `:help lspconfig-server-configurations.md` to know more about
configuring other language servers.


> The best revenge
> is not to be like your enemy.
> — Marcus Aurelius 👑

