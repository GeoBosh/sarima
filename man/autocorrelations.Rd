\name{autocorrelations}
\alias{autocorrelations}
\alias{autocovariances}
\alias{partialAutocorrelations}
\alias{partialAutocovariances}
\alias{partialCoefficients}
\alias{partialVariances}
\alias{backwardPartialCoefficients}
\alias{backwardPartialVariances}
\title{Compute autocorrelations and related quantities}
\description{

  Generic functions for computation of autocorrelations,
  autocovariances and related quantities. The idea is to free the user
  from the need to look for specific functions that compute the desired
  property for their object.

}
\usage{
autocovariances(x, maxlag, \dots)

autocorrelations(x, maxlag, lag_0, \dots)

partialAutocorrelations(x, maxlag, lag_0 = TRUE, \dots)

partialAutocovariances(x, maxlag, \dots)

partialVariances(x, \dots)
}
\arguments{
  \item{x}{
    an object for which the requested property makes sense.
  }
  \item{maxlag}{the maximal lag to include in the result.}
  \item{lag_0}{if TRUE include lag zero.}
  \item{\dots}{further arguments for methods.}
}
\details{

  \code{autocorrelations} is a generic function for computation of
  autocorrelations.  It deduces the appropriate type of autocorrelation
  from the class of the object.  For example, for models it computes
  theoretical autocorrelations, while for time series it computes sample
  autocorrelations.

  The other functions described are similar for other second order
  properties of \code{x}.

  These functions return objects from suitable classes, all inheriting
  from \code{"Lagged"}. The latter means that indexing starts from zero,
  so the value for lag zero is accessed by \code{r[0]}). Subscripting
  always returns the underlying data unclassed (i.e. ordinary vectors or
  arrays). In particular, \code{"[]"} extracts the underlying data.

  Functions computing autocorrelations and partial autocorrelations have
  argument \code{lag_0} --- if it is set to \code{FALSE}, the value for
  lag zero is dropped from the result and the returned object is an
  ordinary vector or array, as appropriate.

  See the individual methods for the format of the result and further
  details.

  There are plot methods for sample autocorrelations and sample partial
  autocorrelations with overlaid significance limits under null
  hypotheses for independence or weak white noise, see
  \code{\link{plot-methods}} and the examples there. More details can be
  found in the vignettes, see section \sQuote{See also} below. 

}
\value{
  an object from a class suitable for the requested property and \code{x}
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}
\seealso{
  \code{\link{plot-methods}} for plotting with significance limits
  computed under strong white noise and weak white noise hypotheses;

  \code{\link{autocorrelations-methods}},
  \code{\link{partialAutocorrelations-methods}}
  for details on individual methods;

  \code{vignette("white_noise_tests", package = "sarima")} and \cr
  \code{vignette("garch_tests_example", package = "sarima")} for
  extensive worked examples.
  
  \code{\link{armaccf_xe}},
  \code{\link{armaacf}}
}
\examples{
set.seed(1234)
v1 <- rnorm(100)
autocorrelations(v1)
v1.acf <- autocorrelations(v1, maxlag = 10)

v1.acf[1:10] # drop lag zero value (and the class)
autocorrelations(v1, maxlag = 10, lag_0 = FALSE) # same

partialAutocorrelations(v1)
partialAutocorrelations(v1, maxlag = 10)

## compute 2nd order properties from raw data
autocovariances(v1)
autocovariances(v1, maxlag = 10)
partialAutocovariances(v1, maxlag = 6)
partialAutocovariances(v1)
partialVariances(v1, maxlag = 6)
pv1 <- partialVariances(v1)

## compute 2nd order properties from raw data
autocovariances(AirPassengers, maxlag = 6)
autocorrelations(AirPassengers, maxlag = 6)
partialAutocorrelations(AirPassengers, maxlag = 6)
partialAutocovariances(AirPassengers, maxlag = 6)
partialVariances(AirPassengers, maxlag = 6)

acv <- autocovariances(AirPassengers, maxlag = 6)
autocovariances(acv) # no-op
autocovariances(acv, maxlag = 4) # trim the available lags

## compute 2nd order properties from sample autocovariances
acr <- autocorrelations(acv)
acr
partialAutocorrelations(acv)
partialAutocovariances(acv)
partialVariances(acv)

## compute 2nd order properties from sample autocorrelations
acr
partialAutocorrelations(acr)

## These cannot be computed, since the variance is needed but unknown:
##     autocovariances(acr)
##     partialAutocovariances(acr)
##     partialVariances(acr)

## to treat autocorrelations as autocovariances, 
## convert them to autocovariances explicitly:
as(acr, "Autocovariances")
as(acr, "SampleAutocovariances")

partialVariances(as(acr, "Autocovariances"))
partialVariances(as(acr, "SampleAutocovariances"))
}
\keyword{ts}

