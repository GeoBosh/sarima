\name{nvarOfAcfKP}
\alias{nvarOfAcfKP}
\title{Compute variances of autocorrelations under ARCH-type hypothesis}
\description{

  Compute variances of autocorrelations under ARCH-type hypothesis.

}
\usage{
nvarOfAcfKP(x, maxlag, center = FALSE, acfscale = c("one", "mom"))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{time series.}
  \item{maxlag}{a positive integer, the maximal lag.}
  \item{center}{

    logical flag, if FALSE, the default, don't center the time series
    before squaring, see Details.
  }
  \item{acfscale}{

    character string, specifying what factor to use for the
    autocovariances. \code{"one"} stands for \eqn{1/n}, \code{"mom"} for
    \eqn{1/(n-k)}, where \eqn{n} is the length of \code{x} and \eqn{k}
    is lag.
    
  }
}
\details{

  \code{nvarOfAcfKP} computes estimates of \eqn{n} times the variances
  of sample autocorrelations of white noise time series. It implements
  the result of \insertCite{kokoszka2011nonlinearity}{sarima} which
  holds under weak assumptions. In particular, it can be used to test if
  the true autocorrelations of a time series are equal to zero in GARCH
  modelling.
  
}
\value{
  a numeric vector
}
\references{
  \insertAllCited{}
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{whiteNoiseTest}}
}
\examples{
## see examples for whiteNoisTest()
}
\keyword{ts}
\keyword{garch}
% use one of  RShowDoc("KEYWORDS")
