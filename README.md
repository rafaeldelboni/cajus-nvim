# What is this?
Basic config to transform your NVIM in a powerful Clojure IDE using fennel, clojure-lsp and conjure.  
This is simplified version on my personal [dotfiles](https://github.com/rafaeldelboni/dotfiles) setup, I highly recommend you to check it out for more advanced and updated configurations.

## Prerequisites
Things you need installed in your OS to use this setup
- [git](https://git-scm.com/downloads)
- [nvim](https://neovim.io/)
- [rg](https://github.com/BurntSushi/ripgrep)
- [clojure-lsp](https://github.com/clojure-lsp/clojure-lsp)

## How to use

**Make sure you backup your current configuration files in `$HOME/.config/nvim` BEFORE running this.**  

Run these commands in the root of this repo:
```bash
# Delete the current nvim config
rm -rf $HOME/.config/nvim

# Makes a symbolic link to the files in this repo
ln -sf $PWD/.config/*/ $HOME/.config/
```
When you start nvim for the first time it will download packer and aniseed and show some errors, thats normal press enter to ignore and go to the nvim console pressing `:` and type `PackerInstall`.
This will install all plugins declared in `fnl/config/plugin.fnl`, after packer's panel showing all the plugins where installed, close nvim and open it again, no errors should show up this time.

## Plugins
 - [packer](https://github.com/wbthomason/packer.nvim) *Plugin/package management*
 - [aniseed](https://github.com/Olical/aniseed) *Bridges between fennel and nvim*
 - [conjure](https://github.com/Olical/conjure) *Interactive repl based evaluation for nvim*
 - [telescope](https://github.com/nvim-telescope/telescope.nvim) *Find, Filter, Preview, Pick*
 - [treesitter](https://github.com/nvim-treesitter/nvim-treesitter) *Incremental parsing system for highlighting, indentation, or folding*
 - [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) *Quickstart configurations for the Nvim LSP client*
 - [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) *Autocompletion plugin*
 - [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme) *Github theme for Neovim*

## Files

### [init.lua](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/init.lua)
Wrapper responsible for two things:
  - Download and setup our package manager ([packer.nvim](https://github.com/wbthomason/packer.nvim)) and our fennel helper/interface ([aniseed](https://github.com/Olical/aniseed))
  - Set the entrypoint for NVIM read our config files, in our case `fnl/config/init.fnl`.

### [fnl/config/init.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/init.fnl)
- Set basic global vim configurations and general keymaps.
- Load plugin configuration namespace.

> In this file among other settings I do set the leader key as `space` and local-leader as `,` for the sake of the examples of how use this configuration I will use this as basis for the commands.


### [fnl/config/plugin.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin.fnl)
Here we define the plugins we want packer to download and load for us, we define here a private function called `use`
which will search in the plugin map for the keyword `:mod` and load the namespace defined in its value.

For example in the line we define that we need telescope we have this map:
```clojure
  :nvim-telescope/telescope.nvim {:requires [:nvim-lua/popup.nvim
                                             :nvim-lua/plenary.nvim]
                                  :mod :telescope}
```
This will state to packer download `nvim-telescope/telescope.nvim` and all the required plugins in `:requires` and search for the namespace `telescope`
in file located in the following path `fnl/config/plugin/telescope`, where I usually add plugin specific configuration like keymaps and settings.

### [fnl/config/plugin/conjure.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin/conjure.fnl)
Conjure specifics settings, I like to remap the doc work keymap to be `<localleader>K` instead the only `K`, to not conflict with the LSP docs `K`.

### [fnl/config/plugin/telescope.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin/telescope.fnl)
Settings like ignore `node_modules` and everything in `.gitignore` to be listed in the file finder.  
Keymaps:
 - `<leader>ff` open the find files
 - `<leader>fg` open the fuzzy finder
 - `<leader>fb` open the find open buffer
 - `<leader>fg` open the nvim help fuzzy finder

### [fnl/config/plugin/treesitter.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin/treesitter.fnl)
Settings to select which treesitter's features we want enabled and which language extension we want to ensure they will be always installed.

### [fnl/config/plugin/lspconfig.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin/lspconfig.fnl)
All about nvim's lsp settings and keymaps.  

#### Settings:

- In the first session, we define which symbols to show for lsp diagnostics.
- Later we describe which features and server settings we want to enable/customize.
  - Handler defines features and how we want to render the server outputs.
  - Capabilities we link with our autocompletion plugin (nvim-cmp), to say to the lsp servers that we have this feature enabled.
  - On_Attach we customize our interaction with the LSP server, here we define the following keymaps:
    - `gd` Go to definition
    - `K` Show documentations
    - `<leader>ld` Function declarations
    - `<leader>lt` Type Definitions
    - `<leader>lh` Signature Help
    - `<leader>ln` Rename
    - `<leader>le` Show line diagnostics
    - `<leader>lq` Show all diagnostics information
    - `<leader>lf` Auto format
    - `<leader>lj` Go to next diagnostic
    - `<leader>lk` Go to previous diagnostic
    - `<leader>la` Open code actions menu (Using telescope plugin interface)
    - `<leader>la` Open code actions menu for the selected text in **VISUAL mode** (Using telescope plugin interface) 
    - `<leader>lw` Open workspace diagnostics list (Using telescope plugin interface) 
    - `<leader>lr` Show all references list for item under the cursor (Using telescope plugin interface) 
    - `<leader>lr` Show all implementations list for item under the cursor (Using telescope plugin interface) 
- Lastly we configure to use all settings above in clojure-lsp server instance.

### [fnl/config/plugin/cmp.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin/cmp.fnl)
Here settings of which sources we want to show up in the autocomple menu like (conjure, lsp, buffer) and some mapping to navigate in the menu.

### [fnl/config/plugin/theme.fnl](https://github.com/rafaeldelboni/nvim-fennel-lsp-conjure-as-clojure-ide/blob/main/.config/nvim/fnl/config/plugin/theme.fnl)
Theme settings like style and comment style.

## Features
Some gifs showing how it works.

### Telescope - Find Files
https://user-images.githubusercontent.com/1683898/132078536-003c188e-d585-4409-856e-a68045b671d9.mp4

**`<leader>ff`**

### Lsp - Syntax check
https://user-images.githubusercontent.com/1683898/132074468-6603792b-3131-488d-adb4-3d9d104ab4ee.mp4

**`<leader>le`**

### Lsp - Go to definition
https://user-images.githubusercontent.com/1683898/132074437-ef8113f4-7c3c-453d-92c5-893dbab99932.mp4

**`gd`**

### Lsp - Document/Signature Help
https://user-images.githubusercontent.com/1683898/132074455-71f79b14-398e-4d2d-977b-6513d496db00.mp4

**`K`/`<leader>lh`**

### Lsp - Find definition/references
https://user-images.githubusercontent.com/1683898/132074445-73a29655-6b97-4376-b172-37f85bce3357.mp4

**`<leader>lr`**

### Lsp - Formatting
https://user-images.githubusercontent.com/1683898/132074425-bc31e472-c3d1-473a-ba0a-1ce1edf3ef98.mp4

**`<leader>lf`**

### Lsp - Code actions
https://user-images.githubusercontent.com/1683898/132074375-17a51df6-e7b1-472f-bb26-3d2bdc4d8acd.mp4

**`<leader>la`**

### Lsp - Refactorings
https://user-images.githubusercontent.com/1683898/132075009-6d07e281-294d-4010-b6a9-ecd85868807a.mp4

**`<leader>la`**

### Lsp - Rename
https://user-images.githubusercontent.com/1683898/132075017-0b3d4b71-0565-4d75-a352-4f6200195c89.mp4

**`<leader>ln`**

### Conjure - Eval
https://user-images.githubusercontent.com/1683898/132075026-c4c1c447-6c2c-48a9-87f6-787f87dde149.mp4

**`<localleader>er`**

### Conjure - Repl
https://user-images.githubusercontent.com/1683898/132075035-f57a7e5d-71a2-46f2-9270-68b98d057b05.mp4

**`<localleader>lv`**

### Conjure - Document
https://user-images.githubusercontent.com/1683898/132075041-010a84bd-923f-4680-8a72-764c65b9a63d.mp4

**`<localleader>K`**

### Completion
https://user-images.githubusercontent.com/1683898/132075048-f3322b6b-e14c-40d5-ba88-aee079f544f1.mp4

## Contributing
If you find any dead links, misinformation or any improvements in this documents at all [Emails](https://github.com/rafaeldelboni), [PRs](https://github.com/rafaeldelboni/buildlogs/pulls) and [Issues](https://github.com/rafaeldelboni/buildlogs/issues) are highly encouraged.

## License

Permits almost any use subject to providing credit and license notice.  
For more information, please refer to https://creativecommons.org/licenses/by/4.0/
