(module config.plugin.lualine
  {autoload {core aniseed.core
             lualine lualine
             lsp config.plugin.lspconfig}})

(defn lsp_connection []
  (if (vim.tbl_isempty (vim.lsp.buf_get_clients 0)) "" ""))

(lualine.setup {:options {:theme (core.assoc
                                   (require :lualine.themes.github)
                                   :inactive {:a {:bg "#19181e" :fg "#a4a3a6"}
                                              :b {:bg "#19181e" :fg "#a4a3a6" :gui "bold"}
                                              :c {:bg "#19181e" :fg "#a4a3a6"}}
                                   :normal {:a {:bg "#131217" :fg "#24292e"}
                                            :b {:bg "#131217" :fg "#3b8eea"}
                                            :c {:bg "#19181e" :fg "#32cd32"}
                                            :x {:bg "#131217" :fg "#9932cc"}
                                            :y {:bg "#131217" :fg "#a4a3a6"}
                                            :z {:bg "#131217" :fg "#3b8eea"}
                                             })
                          :icons_enabled true
                          :section_separators [">" "<"]
                          :component_separators ["" ""]}

                :sections {:lualine_a []
                           :lualine_b [[:mode {:upper true}]]
                           :lualine_c [["FugitiveHead"]
                                       [:filename {:filestatus true
                                                   :path 1}]
                                       [:branch {}]]
                           :lualine_x [[:diagnostics {:sections [:error
                                                                 :warn
                                                                 :info
                                                                 :hint]
                                                      :sources [:nvim_lsp]}]
                                       [lsp_connection]
                                       :location
                                       :filetype]
                           :lualine_y [:encoding]
                           :lualine_z []}
                :inactive_sections {:lualine_a []
                                    :lualine_b []
                                    :lualine_c [[:filename {:filestatus true
                                                            :path 1}]]
                                    :lualine_x []
                                    :lualine_y []
                                    :lualine_z []}})
