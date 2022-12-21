(module config.plugin.telescope
  {autoload {nvim aniseed.nvim
             telescope telescope
             themes telescope.themes}})

(telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]
                             :vimgrep_arguments ["rg"
                                                 "--color=never"
                                                 "--no-heading"
                                                 "--with-filename"
                                                 "--line-number"
                                                 "--column"
                                                 "--smart-case"
                                                 "--iglob"
                                                 "!.git"
                                                 "--hidden"]}
                  :extensions {:ui-select {1 (themes.get_dropdown {})}}
                  :pickers {:find_files {:find_command ["rg"
                                                        "--files"
                                                        "--iglob"
                                                        "!.git"
                                                        "--hidden"]}}})

(telescope.load_extension "ui-select")

(nvim.set_keymap :n :<leader>ff ":lua require('telescope.builtin').find_files()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fg ":lua require('telescope.builtin').live_grep()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fb ":lua require('telescope.builtin').buffers()<CR>" {:noremap true})
(nvim.set_keymap :n :<leader>fh ":lua require('telescope.builtin').help_tags()<CR>" {:noremap true})
