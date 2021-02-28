<!-- badges: start -->
[![CRANStatusBadge](http://www.r-pkg.org/badges/version/sarima)](https://cran.r-project.org/package=sarima)
[![Build Status](https://travis-ci.com/GeoBosh/sarima.svg?branch=master)](https://travis-ci.com/GeoBosh/sarima)
[![Coverage Status](https://coveralls.io/repos/github/GeoBosh/sarima/badge.svg?branch=master)](https://coveralls.io/github/GeoBosh/sarima?branch=master)
  [![R-CMD-check](https://github.com/GeoBosh/sarima/workflows/R-CMD-check/badge.svg)](https://github.com/GeoBosh/sarima/actions)
[![R-CMD-check](https://github.com/GeoBosh/sarima/workflows/R-CMD-check/badge.svg)](https://github.com/GeoBosh/sarima/actions)
[![Codecov test coverage](https://codecov.io/gh/GeoBosh/sarima/branch/master/graph/badge.svg)](https://codecov.io/gh/GeoBosh/sarima?branch=master)
<!-- badges: end -->




'sarima' is an R package for time series modelling.

# Installing sarima

Install the [latest stable version](https://cran.r-project.org/package=sarima) of
`sarima` from CRAN:

    install.packages("sarima")


You can install the [development version](https://github.com/GeoBosh/sarima) of
`sarima` from Github:

    library(devtools)
    install_github("GeoBosh/sarima")


# Overview

Functions, classes and methods for time series modelling with ARIMA and related
models. The aim of the package is to provide consistent interface for the
user. For example, a single function autocorrelations() computes various kinds
of theoretical and sample autocorrelations. This is work in progress, see the
documentation and vignettes for the current functionality.  Function sarima()
fits extended multiplicative seasonal ARIMA models with trends, exogenous
variables and arbitrary roots on the unit circle, which can be fixed or
estimated.

Reference manuals and vignettes are available as usual from running R
sessions. For example,

    vignette(package = "sarima") # which vignettes are available?
    
    vignette("white_noise_tests", package = "sarima")
    vignette("garch_tests_example", package = "sarima")


Alternatively, here are some links to online versions of the documentation:

- [sarima online reference manual](https://geobosh.github.io/sarima/)

- [sarima pdf reference manual on CRAN](https://CRAN.R-project.org/package=sarima/sarima.pdf)

- [vignette _Garch and white noise tests_ on CRAN](https://cran.r-project.org/package=sarima/vignettes/garch_tests_example.pdf)

- [vignette _Autocorrelations and white noise tests_ on CRAN](https://cran.r-project.org/package=sarima/vignettes/white_noise_tests.pdf)
