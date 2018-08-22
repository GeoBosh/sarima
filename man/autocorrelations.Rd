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

  These functions return objects from suitable classes. A value for lag
  zero is included (and is accessed by \code{r[0]}). Functions computing
  autocorrelations and partial autocorrelations have argument
  \code{lag_0} --- if it is set to \code{FALSE}, the value for lag zero
  is dropped from the result and the returned object is an ordinary
  vector or array, as appropriate.

  See the individual methods for the format of the result and further
  details.

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
  \code{\link{armaccf_xe}},
  \code{\link{armaacf}}
}
\examples{
v1 <- rnorm(100)
autocorrelations(v1)
v1.acf <- autocorrelations(v1, maxlag = 10)

v1.acf[1:10] # drop lag zero value (and the class)
autocorrelations(v1, maxlag = 10, lag_0 = FALSE) # same

partialAutocorrelations(v1)
partialAutocorrelations(v1, maxlag = 10)

autocovariances(v1)
autocovariances(v1, maxlag = 10)
partialAutocovariances(v1, maxlag = 6)
partialAutocovariances(v1)
partialVariances(v1, maxlag = 6)
pv1 <- partialVariances(v1)

autocovariances(AirPassengers, maxlag = 6)
autocorrelations(AirPassengers, maxlag = 6)
partialAutocorrelations(AirPassengers, maxlag = 6)
partialAutocovariances(AirPassengers, maxlag = 6)
partialVariances(AirPassengers, maxlag = 6)
}
\keyword{ts}
