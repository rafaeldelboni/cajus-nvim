(module config.plugin.theme
  {autoload {core aniseed.core
             nvim aniseed.nvim
             theme tokyonight
             util tokyonight.util}})

(theme.setup {:style :night
              :styles {:comments {:italic true}
                       :floats :dark
                       :functions {}
                       :keywords {:italic true}
                       :sidebars :dark
                       :variables {}}
              :on_colors (fn [colors]
                           (set colors.bg_statusline (util.darken colors.bg_dark 0.5)))
              :on_highlights (fn [highlight colors]
                               (set highlight.String {:fg colors.green2})
                               (set highlight.TelescopeNormal {:bg colors.bg_statusline
                                                               :fg colors.fg_dark})
                               (set highlight.TelescopeBorder {:bg colors.bg_statusline
                                                               :fg colors.fg_dark})
                               (set highlight.NvimTreeNormal {:bg colors.bg_statusline
                                                              :fg colors.fg_dark})
                               (set highlight.NvimTreeNormalNC {:bg colors.bg_statusline
                                                                :fg colors.fg_dark})
                               (set highlight.NvimTreeWinSeparator {:bg colors.bg_statusline
                                                                    :fg colors.bg_dark})
                               (set highlight.FloatBorder {:bg colors.bg_statusline
                                                           :fg colors.fg_dark})
                               (set highlight.ColorColumn {:bg colors.bg_statusline
                                                           :fg colors.fg_dark})
                               (set highlight.Pmenu {:bg colors.bg_statusline
                                                     :fg colors.fg_dark})
                               (set highlight.NonText {:fg (util.lighten colors.bg 0.9)}))
              :terminal_colors true})

(vim.cmd "colorscheme tokyonight")
