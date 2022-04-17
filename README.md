# NeoVim + LSP ready IDE setup

Started as a minimal usable conf... but become my fully standard one!

## Features

* Fully Lua configurated (even ftplugins)
* UI tunned defaults like menus, splits etc to work comfortably with all
  colorschemes install, no disruptive experience
* Consistent semaphoric colors for errors, diff's and git status on LuaLine
* Less system resources on LSP: Uses NeoVim's own LSP system, no need on Coc/Node
* Out of the box enabled Nim (nimlsp) and Lua (sumneko_lua) language-servers
* Out of the box enabled autocomplete and snippets
* Wal colorscheme support as default


## Development

The purpose is to have the basic productivity things easily.
So a basic set fo colorschemes and plugins are predefined to be used
along Packer plugin manager. See `lua/plugins.lua`.

Also no much tweaking things once is set, so not wait it to become
a bloated configuration setup... may be new tweaks are in direction
to add more predefinitions of LSP file types or syntax.


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

* If you will go coding in one of these languages you are encouraged
  to have the binary of its language server in your system's path:

    - For Lua, sumneko's `lua-language-server`
    - For Nim, `nimlsp` that can be installed via `nimble`


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


## Keymaps

### Searching code
* `\f` Find files _(with Telescope)_
* `\g` Live Grep  _(with Telescope)_
* `\m` List Marks _(with Telescope)_
* `\Space` List opened buffers _(with Telescope)_

### Splits
* `\h` Horizontal split
* `\v` Vertical split

### Tab management
* `tn` New tab with current opened file
* `tq` Close tab

### AutoCompletion

Default keymap blocks the natural navigation through the file,
putting the navigation on menus with highest priority. If you have a
suggestion opens during your writting, some keys have completely
different behaviors (like Tab, Enter and Arrows) and the completion that
should help you write words that you have to spend time removing.

Thinking on these I set some keymaps to work only with suggestion.
If you want to change it, they are on `lua/lsp-config.lua` file.

Autocomplete Menu Navigation
* `Shift ↓` or `Ctrl j` Select next menu item
* `Shift ↑` or `Ctrl k` Select previous menu item

Autocomplete selection
* `Shift →` or `Insert` Complete with suggested text
* `Enter` Complete only if you select something from menu,
   otherwise act in the standard behavior

Close autocomplete menu
* `Shift ←` or `Ctrl E` Close suggestion menu

Navigation on menu item documentation
* `Shift PageUp` or `Ctrl ↑` Show upper text
* `Shift PageDown` or `Ctrl ↓` Show lower text


### LSP

* `\r` Reload lsp issuing :LspStop followed by :LspStart.
Some language servers have its peculiarities, and using it may
break the session needing to restart Vim. Try it only if the the LS dies.


----

> The best revenge
> is not to be like your enemy.
> — Marcus Aurelius 👑

