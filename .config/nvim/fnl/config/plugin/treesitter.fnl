(module config.plugin.treesitter
  {autoload {treesitter nvim-treesitter.configs}})

(treesitter.setup {:highlight {:enable true}
                   :indent {:enable true}
                   :ensure_installed [:bash
                                      :clojure
                                      :commonlisp
                                      :dockerfile
                                      :fennel
                                      :html
                                      :java
                                      :javascript
                                      :json
                                      :lua
                                      :markdown
                                      :yaml]})
