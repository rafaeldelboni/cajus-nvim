(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(defn lsp_connection []
  (if (vim.tbl_isempty (vim.lsp.buf_get_clients 0)) "" ""))

(def github-lua-theme
  (core.assoc
    (require :lualine.themes.auto)
    :inactive {:a {:bg "#19181e" :fg "#a4a3a6"}
               :b {:bg "#19181e" :fg "#a4a3a6"}
               :c {:bg "#19181e" :fg "#a4a3a6"}}
    :normal {:a {:bg "#131217" :fg "#24292e"}
             :b {:bg "#131217" :fg "#3b8eea"}
             :c {:bg "#19181e" :fg "#d1d5da"}}
    :command {:a {:bg "#131217" :fg "#24292e"}
              :b {:bg "#131217" :fg "#ccbed8"}
              :c {:bg "#19181e" :fg "#d1d5da"}}
    :visual {:a {:bg "#131217" :fg "#24292e"}
             :b {:bg "#131217" :fg "#ced4b1"}
             :c {:bg "#19181e" :fg "#d1d5da"}}
    :replace {:a {:bg "#131217" :fg "#24292e"}
              :b {:bg "#131217" :fg "#d1b6bd"}
              :c {:bg "#19181e" :fg "#d1d5da"}}
    :insert {:a {:bg "#131217" :fg "#24292e"}
             :b {:bg "#131217" :fg "#a8d1c9"}
             :c {:bg "#19181e" :fg "#d1d5da"}}))

(lualine.setup
  {:options {:theme github-lua-theme
             :icons_enabled true
             :section_separators ["" ""]
             :component_separators ["" ""]}
   :sections {:lualine_a []
              :lualine_b [[:mode {:upper true}]]
              :lualine_c [["FugitiveHead"]
                          {1 :filename
                           :file_status true
                           :path 1
                           :shorting_target 40}]
              :lualine_x [{1 :diagnostics
                           :sections [:error :warn :info :hint]
                           :sources [:nvim_lsp]}
                          [lsp_connection]
                          :location
                          :filetype]
              :lualine_y [:encoding]
              :lualine_z []}
   :inactive_sections {:lualine_a []
                       :lualine_b []
                       :lualine_c [{1 :filename
                                    :file_status true
                                    :path 1}]
                       :lualine_x []
                       :lualine_y []
                       :lualine_z []}})
