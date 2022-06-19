(module config.lang.clojure
   {require {nvim aniseed.nvim
             u aniseed.nvim.util
             core aniseed.core}})

(nvim.echo "Clojure config loaded")

(def- run-lein-cmd "lein repl")
(def- run-deps-cmd "clojure -M:repl/rebel-nrepl:dev")

 ;; jack in with Lein or Deps based on root project file
(defn run-appropriate-clojure-repl []
  (let [root-files (nvim.fn.readdir (nvim.fn.getcwd))
        has-lein (core.some (fn [s] (= s "project.clj")) root-files)
        has-deps (core.some (fn [s] (= s "deps.edn")) root-files)]
    (if has-lein 
      (do (nvim.echo "found lein")
        (vim.cmd (.. "terminal " run-lein-cmd)))
      has-deps
      (do (nvim.echo "found deps")
        (vim.cmd "tabnew")
        (vim.cmd (.. "terminal " run-deps-cmd)))
      (nvim.echo "can't find neither deps.edn nor project.clj in the root"))))

 ;; make function available in vim cmd
(u.fn-bridge :RunAppropriateClojureRepl :config.lang.clojure :run-appropriate-clojure-repl)

(nvim.set_keymap :n :<leader>k ":call RunAppropriateClojureRepl()<cr> " {:noremap true})
