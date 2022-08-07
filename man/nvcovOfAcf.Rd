\name{nvcovOfAcf}
\alias{nvcovOfAcf}
\alias{nvcovOfAcfBD}
\alias{acfOfSquaredArmaModel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Covariances of sample autocorrelations}
\description{Compute covariances of autocorrelations.}
\usage{
nvcovOfAcf(model, maxlag)

nvcovOfAcfBD(acf, ma, maxlag)

acfOfSquaredArmaModel(model, maxlag)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{a model, see Details.}
  \item{maxlag}{a positive integer number, the maximal lag.}
  \item{acf}{autocorrelations.}
  \item{ma}{
    a positive integer number, the order of the MA(q) model. The default
    is the maximal lag available in \code{acf}.
  }
}
\details{

  \code{nvcovOfAcf} computes the unscaled asymptotic autocovariances of
  sample autocorrelations of ARMA models, under the classical
  assumptions when the Bartlett's formulas are valid.  It works directly
  with the parameters of the model and uses Boshnakov (1996).  Argument
  \code{model} can be any specification of ARMA models for which
  \code{autocorrelations()} will work, e.g. a list with components "ar",
  "ma", and "sigma2".

  \code{nvcovOfAcfBD} computes the same quantities but uses the formula
  given by Brockwell & Davis (1991) (eq. (7.2.6.), p. 222), which is
  based on the autocorrelations of the model. Argument
  \code{acf} contains the autocorrelations.
  
  For \code{nvcovOfAcfBD}, argument \code{ma} asks to treat the provided
  acf as that of MA(\code{ma}). Only the values for lags up to
  \code{ma} are used and the rest are set to zero, since the
  autocorrelations of MA(\code{ma}) models are zero for lags greater
  than \code{ma}.
  To force the use of all autocorrelations provided in \code{acf}, set
  \code{ma} to the maximal lag available in \code{acf} or omit
  \code{ma}, since this is its default.

  
  \code{acfOfSquaredArmaModel(model, maxlag)} is a convenience function
  which computes the autocovariances of the "squared" model, see
  Boshnakov (1996).

}
\value{
  an \code{(maxlag,maxlag)}-matrix
}
\references{
  \insertRef{boshnakov1996aism}{sarima}

  \insertRef{BrockwellDavis1991}{sarima}
}
\author{Georgi N. Boshnakov}
\note{

  The name of \code{nvcovOfAcf} stands for \dQuote{\code{n} times the
  variance-covariance matrix}, so it needs to be divided by \code{n} to
  get the asymptotic variances and covariances. 

}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{whiteNoiseTest}}
}
\examples{
## MA(2)
ma2 <- list(ma = c(0.8, 0.1), sigma2 = 1)
nv <- nvcovOfAcf(ma2, maxlag = 4)
d <- diag(nvcovOfAcf(ma2, maxlag = 7))
cbind(ma2 = 1.96 * sqrt(d) / sqrt(200), iid = 1.96/sqrt(200))

acr <- autocorrelations(list(ma = c(0.8, 0.1)), maxlag = 7)
nvBD <- nvcovOfAcfBD(acr, 2, maxlag = 4)
all.equal(nv, nvBD) # TRUE
}
\keyword{ts}
% use one of  RShowDoc("KEYWORDS")
