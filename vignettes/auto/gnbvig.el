(TeX-add-style-hook
 "gnbvig"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("jss" "article" "nojss")))
   (TeX-run-style-hooks
    "latex2e"
    "jss"
    "jss10"
    "amsmath"
    "amsfonts")
   (LaTeX-add-labels
    "sec:autocorrelations"
    "sec:white-noise-tests"
    "sec:fit garch")))

