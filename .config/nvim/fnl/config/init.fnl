(module config.init
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util config.util
             str aniseed.string}})

;generic mapping leaders configuration
(nvim.set_keymap :n :<space> :<nop> {:noremap true})
(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")

;; Spacemacs style leader mappings.
(nvim.set_keymap :n :<leader>wm ":tab sp<cr>" {:noremap true})
;; new buffer
(nvim.set_keymap :n :<leader>bn ":bn" {:noremap true})
(nvim.set_keymap :n :<leader>ba ":saveas" {:noremap true})

;; Insert mode: :fd as Escape short cut
(nvim.set_keymap :i :fd "<ESC>" {:noremap true})

;don't wrap lines
(nvim.ex.set :nowrap)

;sets a nvim global options
(let [options
      {;settings needed for compe autocompletion
       :completeopt "menuone,noselect"
       ;case insensitive search
       :ignorecase true
       ;smart search case
       :smartcase true
       ;shared clipboard with linux
       :clipboard "unnamedplus"}]
  (each [option value (pairs options)]
    (core.assoc nvim.o option value)))

;import plugin.fnl
(require :config.plugin)
