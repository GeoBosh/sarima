(TeX-add-style-hook
 "white_noise_tests"
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
    "sec:autoc-relat-prop"
    "sec:white-noise-tests")))

