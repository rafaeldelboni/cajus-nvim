(module config.plugin.blankline
  {autoload {b indent_blankline}})

(b.setup {:show_current_context true
          :context_patterns ["lit$"]})
