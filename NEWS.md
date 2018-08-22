# sarima 0.7-6

* updated Makefiles and Makefiles.win to deal with a NOTE from recent tightening
  of checks on CRAN (see
  https://stat.ethz.ch/pipermail/r-package-devel/2018q3/003030.html). 

# sarima 0.7-5

* `NEWS` becomes `NEWS.md` and uses markdown syntax. The style is loosely based
  on http://style.tidyverse.org/news.html).

* manually incorporated or noted changes from Jamie's 0.7.4.9001/2018-08-17.
  Namely:

  * Import package *numDeriv* (for `hessian()`).

# sarima 0.7-4

* dealt with 'valgrind' warnings (had missed one uninitialised warning).

* fixed a bug in prepareSimSarima() - when initial values were not supplied
     in the stationary case, the initialisation was not correct (thanks to
     Cameron Doyle for reporting this).


# sarima 0.7-3 (CRAN)

* dealt with 'valgrind' warnings.



# sarima 0.7-2 (CRAN)

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

* first submission to CRAN.


# sarima 0.4-0

* first version for CRAN.

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
