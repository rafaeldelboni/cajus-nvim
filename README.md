# WIP!

# What is this?
Basic config to transform your NVIM in a powerfull clojure IDE using fennel, clojure-lsp and conjure.
This is simplified version on my personal [.dotfiles](https://github.com/rafaeldelboni/dotfiles) setup, I recommend you to check it out for more advanced and updated configurations.

## How to use

## Plugins
 - [packer](https://github.com/wbthomason/packer.nvim)
   > Plugin/package management
 - [aniseed](https://github.com/Olical/aniseed)
   > Bridges between fennel and nvim
 - [conjure](https://github.com/Olical/conjure)
   > Interactive repl based evaluation for nvim
 - [telescope](https://github.com/nvim-telescope/telescope.nvim)
   > Find, Filter, Preview, Pick
 - [treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
   > Incremental parsing system for highlighting, indentation, or folding
 - [luasnip](https://github.com/L3MON4D3/LuaSnip)
   > Snippet Engine, works well with nvim-cmp
 - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
   > Quickstart configurations for the Nvim LSP client
 - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
   > Autocompletion plugin

## Files

### init.lua
Wrapper responsible for two things:
  - Download and setup our package manager ([packer.nvim](https://github.com/wbthomason/packer.nvim)) and our fennel helper/interface ([aniseed](https://github.com/Olical/aniseed))
  - Set the entrypoint for NVIM read our config files, in our case `fnl/config/init.fnl`.

### fnl/config/init.fnl
- Set basic global vim configurations and general keymaps.
- Load plugin configuration namespace.

> In this file among other settings I do set the leader key as `space` and local-leader as `,` for the sake of the examples of how use this configuration I will use this as basis for the commands.


### fnl/config/plugin.fnl
Here we define the plugins we want packer to download and load for us, we define here a private function called `use`
which will search in the plugin map for the keyword `:mod` and load the namespace defined in its value.

For example in the line we define that we need telescope we have this map:
```clojure
  :nvim-telescope/telescope.nvim {:requires [:nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim]
                                  :mod :telescope}
```
This will state to packer download `nvim-telescope/telescope.nvim` and all the required plugins in `:requires` and search for the namespace `telescope`
in file located in the following path `fnl/config/plugin/telescope`.

I usually add plugin specific configuration like keymaps and settings.
