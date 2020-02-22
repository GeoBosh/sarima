[![CRANStatusBadge](http://www.r-pkg.org/badges/version/sarima)](https://cran.r-project.org/package=sarima)
[![Build Status](https://travis-ci.com/GeoBosh/sarima.svg?branch=master)](https://travis-ci.com/GeoBosh/sarima)
[![Coverage Status](https://coveralls.io/repos/github/GeoBosh/sarima/badge.svg?branch=master)](https://coveralls.io/github/GeoBosh/sarima?branch=master)


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

