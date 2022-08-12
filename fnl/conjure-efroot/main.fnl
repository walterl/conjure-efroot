(module conjure-efroot.main
  {autoload {a conjure.aniseed.core
             bridge conjure.bridge
             config conjure.config
             mapping conjure.mapping
             nvim conjure.aniseed.nvim
             str conjure.aniseed.string}})

(defn on-filetype []
  (mapping.buf :n :EvalEffectiveRootForm "er" :conjure-efroot.eval :effective-root-form)
  (mapping.buf :n :EvalCommentEffectiveRootForm "ecr" :conjure-efroot :comment-effective-root-form))

(defn init []
  ;; Remap original "eval root" commands
  (config.assoc-in [:mapping :eval_root_form] "eR")
  (config.assoc-in [:mapping :eval_comment_root_form] "ecR")

  (nvim.ex.autocmd
    :FileType (str.join "," (config.filetypes))
    (bridge.viml->lua :conjure-efroot.main :on-filetype {})))
