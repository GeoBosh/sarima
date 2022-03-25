# sarima 0.9.0.9000

- in `prepareSimSarima` (and hence `sim_sarima`) fixed a bug causing wrong
  results for some combination of parameters when initial values were
  supplied. Also removed some parts in the documentation of these functions
  which no longer applied. This needs further work before the next release of
  the package.



# sarima 0.9 (CRAN)

- new generic function `FisherInformation` giving the information matrix for
  fitted and theoretical models with methods for ARMA and seasonal ARMA models.

- new generic function `spectrum` with methods for(seasonal) ARMA models and
  default `stats::spectrum`.
  

# sarima 0.8.6 (CRAN)

- in `tsdiag.Sarima()`, if argument `plot` specifies only one or two plots, then
  the window is now split into 1 or 2 sub-windows, respectively, even if
  argument `layout` is not used.

- new convenience function, `se()` to compute standard errors.

- `confint` methods extended and documented.

- extensive changes in the documentation, including reorganisation of the
  pkgdown site.

- moved fkf and KFAS to Suggests and removed dplyr from the dependencies.


# sarima 0.8.5 (CRAN)

- new `tsdiag` method for class `Sarima` (the result of `sarima()`). The method
  can be called also directly on the output from base R's `arima()` with
  `tsdiag.Sarima()` or `sarima::tsdiag.Sarima()`. The method offers several
  portmanteau tests (including Ljung-Box, Li-McLeod and Box-Pierce), plots of
  autocorrelations and partial autocorrelations of the residuals, ability to
  control which graphs to be produced (including interactively), and their
  layout. The computed results are returned (invisibly).  The default layout of
  the graphs is similar to `stats::tsdiag()` (but with adjusted d.f.).

  The method always makes a correction of the degrees of freedom of the
  portmanteau tests.  

- github repository housekeeping - switched from TravisCI to Github actions.

- now the pkgdown website is automatically rebuild on push (via a github
  action).

- moved FitAR from Depends to Imports (after some changes in `.onLoad()` to make
  this possible).


# sarima 0.8.4 (CRAN)

- updated a reference to avoid redirect.


# sarima 0.8.2 (CRAN)

- import again FKF (support for it was removed when FKF was temporarily
  archived on CRAN).

- removed developers' comments that had been accidentally left in a vignette.

- removed an erroneous `rev()` from the garch tests vignette.

- added new tests and fixed several bugs in the process.

- the show method for class "ArmaModel" now returns NULL. The previous
  return value was spooking "pkgdown::build_site()" resulting in the error:
```
Error in UseMethod("replay_html", x) : 
  no applicable method for 'replay_html' applied to an object of class "c('double', 'numeric')"

```


# sarima 0.8.1 (CRAN)

- relaxed numerical comparisons in some tests, to account for additional
  platforms, such as Open-BLAS, recently activated for checks on CRAN.
  

# sarima 0.8.0 (CRAN)

* new test for GARCH-type noise based on Kokoszka and Politis result.

* more complete sets of methods for several functions. In particular, there was
  infinite recursion in some cases.

* bug fixes

* improved `show()` methods for autocovariance objects

* numerous changes in `sarima()`

* cater for changing function names in the forthcoming release 2.0.0 of package
  `PolynomF`. 

* Now require `lagged (>= 0.2.1)` (`lagged 0.2.0` is not sufficient since
  `nSeasons()` and `nSeasons<-()` accidentally were not exported by it).

* Vignette `garch_tests_example` now imports the data using `system.file()`,
  so that the examples can be run easily by the user.

* new function `makeArimaGnb()` for setting up the state space form of ARIMA
  models. It is a modification of `stats::makeARIMA()` with Georgi's method for
  computation of the stationary part of the initial state covariance matrix.
  The methods implemented in `stats::makeARIMA()`are commented out since they
  are not exported from package `stats`.
  
* `sarima()` gets an argument to specify the method to use for the stationary
  part of P0 (see above). The available options are the ones in `makeARIMA()` 
  ("Rossignol2011" and "Gardner1980") plus Georgi's method ("gnb"). The default
  is "Rossignol2011".


# sarima 0.7.6 (CRAN)

* updated Makevars and Makevars.win to deal with a NOTE from recent tightening
  of checks on CRAN (see
  https://stat.ethz.ch/pipermail/r-package-devel/2018q3/003030.html). 


# sarima 0.7.5

* `NEWS` becomes `NEWS.md` and uses markdown syntax. The style is loosely based
  on http://style.tidyverse.org/news.html).

* manually incorporated or noted changes from Jamie's 0.7.4.9001/2018-08-17.
  Namely:

  * Import package *numDeriv* (for `hessian()`).


# sarima 0.7.4

* dealt with 'valgrind' warnings (had missed one uninitialised warning).

* fixed a bug in prepareSimSarima() - when initial values were not supplied
     in the stationary case, the initialisation was not correct (thanks to
     Cameron Doyle for reporting this).


# sarima 0.7.3 (CRAN)

* dealt with 'valgrind' warnings.


# sarima 0.7.2 (CRAN)

* this is an emergency release to avoid the package being archived on CRAN
     due to the archival of a dependency.

* the main new feature since the previous release, 0.5-2, of the package is
     the versatile function `sarima()`, which provides formula syntax for
     fitting encompassing SARIMA, ARUMA, XSARIMA, Reg-SARIMA, ARMAX
     models. Parsimonious multiplicative specifications are supported for the
     stationary and non-stationary parts of the model, as well as arbitrary unit
     roots on the unit circle, which can be fixed or estimated.  'sarima()' 
     is documented but is still under development.

* removed 'portes' from Imports - it was not used for some time in 'sarima'
     (it was scheduled from removal from CRAN on 2018-07-30).

* removed package 'FKF' from Imports, since it has been archived on CRAN.
     
   
# sarima 0.7-0 - 0.7-1

* merged branch models with master.

* numerous consolidations.


Changes in branch 'models'

* in DESCRIPTION, moved 'methods' from DEPENDS to Imports.

* various bug fixes and cosolidations.

* improvements to the documentation.

* returned the stuff the test package 'testts' (and removed the latter).
     `testts` was not helpful and complicated the workflow.
     Now the tests for `armaQ0` etc are in `sarima. 
     

# sarima 0.6-6

* now can request estimation of components with roots on the unit circle.

* in xreg and regx specifications, renamed cs(), B(), p() to .cs(), .B(),
     .p(), respectively.

* further to the above, in xreg and regx specifications `t' stays as is for
     now, since it needs more care, but its use is discouraged.

* removed sincos() and L() from sarima specifications, use the equivalents
     .cs() and .B(), respectively.


# sarima 0.6-4 - 0.6-5

* intermediate versions, not useful for back reference (the zip file given is
     a better place to look for code before 0.6-6).

* now on bitbucket as part of sarima_project. The original upload
     is in sarima_project/Archive/sarima_project_Orig.zip.

* wrapping up 0.6-5 before making the changes needed for estimation of unit
     roots.


# sarima 0.6-3

* support for tanh transformation.

* factorisation of MA

* Packing up this version before moving stuff that needs ':::' calls
     elsewhere (e.g. to myRcpp, but haven't decided on the structure)


# sarima 0.6-1 - 0.6-2

* Several bug fixes.

* Some trouble with Rcpp, further trouble with Rtools after installing the
     latest version of R. Packing up this version for a working reference. 


# sarima 0.6-0

* included some C++ code (using Rcpp/RcppArmadilo) previously tested
     in my (private) package myRcpp.

* removed the internal arima() functions introduced in 0.5-11.

* added ss.method = "sarima" to sarima() which uses the new C++
     functions to compute the likelihood. Limited testing confirms that
     this method gives the same results as arima() for models that can
     be fitted with arima().

* bumping the version number to have a working version in case
     further improvements mess things up.


# sarima 0.5-11

* temporarily created a number of functions to call functions used
     internally by arima(), see arima.R. 


# sarima 0.5-9

* moved temporarilly FitAR from Imports to Depends, since FitARMA can't find
     some functions from FitAR if FitARMA is not attached. (move
     back to Imports when Ian imports FitAR in FitARMA's namespace)

* further work on sarima(), saving before more meddling with the environments
     of the formulas

# sarima 0.5-8

* added support for KFAS.

* fixed parameters and initial values are supported for ARMA specifications
     (but not for regression parameters yet).

* sarima() is still incomplete but is usable.

* archiving before a full scale consolidation and clean up, in case that
     messes things up.

# sarima 0.5-7

* sarima() now fits XARIMAX models, in the case of the second X, using
     FKF::fkf().

* archiving before starting work on completing the handling of fixed
     parameters. 


# sarima 0.5-6

* some consolidation of sarima(), now supports lagged variables and calls
     only sarimat(). sarima0() has been removed. the data argument of sarima()
     is processed properly (incomplete maybe).

# sarima 0.5-5

* sarima() now uses the facilities of package Formula to process the model
     formulas.

# sarima 0.5-4

* sarima() can now fit time regression. It currently calls sarimat() if there
     is treg argument and sarima0() otherwise.


# sarima 0.5-3

* model formulas for SARIMA models using package Formula.

* usable version of sarima() function but not for publication yet.

* packing this version before further work on sarima().


# sarima 0.5-2 (CRAN)

* plot of acf tests now uses different 'lty' so that the confidence limits
     under iid and garch nulls are visually distinguishable in black and white
     printouts.

* plot of acf tests now accepts argument 'interval' to produce rejection
     limits for levels other than the default 95%.

* started to add references to the documentation.

* for armaacf() and armaccf_xe() the innovation variance in argument 'model'
     is now called 'sigma2' (the old 'sigmasq' still works but is deprecated).

* a number of corrections and additions to the documentation.

* additional examples.


# sarima 0.5-1

* SarimaModel now inherits from VirtualSarimaModel (it was inheriting from
     VirtualFilterModel. On its own, this is invisible to the user. It didn't
     invalidate existing objects either.

* new class "VirtualIntegratedModel".

* new functions nUnitRoots() and isStationaryModel.

* further streamlining.


# sarima 0.5-0

* exported functions related to Bartlett's formula (they were there in
     version 0.4-5, under different names).

* substantial work on SARIMA models and their documentation.

* increasing the version number before some streamlining of class SarimaModel.


# sarima 0.4-5 (CRAN)

* moved "Lagged" to a separate package, "lagged".

* streamlined acfIidTest() and documented it properly.

* new vignette based on example in Chapter 7 of James Proberts' MMath
     project.


# sarima 0.4-3 (CRAN)

* first CRAN version.


# sarima 0.3-6

* white noise tests based on acf and pacf and  corresponding plots.
* vignette.


# sarima 0.3-5

* revamped "Lagged": introduced Lagged2d, etc.; mixed Ops, e.g. "Lagged" +
     "vector", now work only if "vector" is of length one or multiple of the
     length of e1@data has the same length as the vector.


# sarima 0.3-4

* removed some old commented out code from sarima.org to reduce clutter.
* extensive changes and consolidation.


# sarima 0.3-3

* streamlined SARIMA models and the functions based on old code.
     Keeping the old code (commented out) for reference.


# sarima 0.3-2

* defined the classes for autocorrelations and similar.
* autocorrelations() and similar now have a number of methods.
* passes 'R CMD check'. Most classes have only fake documentation
     in VirtualMonicFilter-class.Rd.


# sarima 0.3-0

* switched to package PolynomF (from polynom).
* new classes for models, including ARMA and SARIMA.
* R CMD check passes 9only a WARNING for undocumented objects and S$ methods.


# sarima 0.2-x

* added new classes, substantial extension.
* renamed sarima.sim() to sim_sarima()


# sarima 0.1-0

* updated and cleaned a bit the old code.

# sarima 0.0-5

* removed argument "eps" from fun.forecast since it is ignored.

# sarima 0.0-3

* sarima.mod now sets class "sarima" for its result.
* print method for "sarima" class.

# sarima 0.0-2

* inserted examples from lectures and handouts from past years.

# sarima 0.0-1

* created documentation using the comments in the source code.

# sarima 0.0-0

* turned atssarima.r (written in 2006-2007 for course "Applied time series")
  into a package.
