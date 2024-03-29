\name{acfGarchTest}
\alias{acfGarchTest}
\alias{acfWnTest}
\title{Tests for weak white noise}
\description{

  Carry out tests for weak white noise under GARCH, GARCH-type, and
  stochastic volatility null hypotheses.

}
\usage{
acfGarchTest(acr, x, nlags, interval = 0.95)

acfWnTest(acr, x, nlags, interval = 0.95, \dots)
}
\arguments{
  \item{acr}{autocorrelations.}
  \item{x}{time series.}
  \item{nlags}{how many lags to use.}
  \item{interval}{If not NULL, compute also confidence intervals with
    the specified coverage probability.}
  \item{...}{
    additional arguments for the computation of the variance matrix
    under the null hypothesis, passed on to \code{\link{nvarOfAcfKP}}.
  }
}
\details{

  Unlike the autocorrelation IID test, the time series is needed here to
  estimate the covariance matrix of the autocorrelations under the null
  hypothesis.

  \code{acfGarchTest} performs a test for uncorrelatedness of a time
  series. The null hypothesis is that the time series is GARCH,
  see \insertCite{FrancqZakoian2010garch;textual}{sarima}.

  \code{acfWnTest} performs a test for uncorrelatedness of a time
  series under a weaker null hypothesis.
  The null hypothesis is that the time series is GARCH-type or
  from a stochasitc volatily model,
  see   \insertCite{kokoszka2011nonlinearity;textual}{sarima}.

  See the references for details and precise specification of the
  hypotheses.
  
  The format of the return value is the same as for \code{acfIidTest}.

}
\value{
  a list with components "test" and "ci"
}
\references{
  \insertAllCited{}
}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{whiteNoiseTest}},
  \code{\link{acfIidTest}};

  \code{\link{plot-methods}} for graphical representations of results
}
\examples{
## see also the examples for \code{\link{whiteNoiseTest}}
set.seed(1234)
n <- 5000
x <- sarima:::rgarch1p1(n, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)
x.acf <- autocorrelations(x)
x.pacf <- partialAutocorrelations(x)

acfGarchTest(x.acf, x = x, nlags = c(5,10,20))
acfGarchTest(x.pacf, x = x, nlags = c(5,10,20))

# do not compute CI's:
acfGarchTest(x.pacf, x = x, nlags = c(5,10,20), interval = NULL)

## plot methods call acfGarchTest() suitably if 'x' is given:
plot(x.acf, data = x)
plot(x.pacf, data = x)

## use 90% limits:
plot(x.acf, data = x, interval = 0.90)

acfWnTest(x.acf, x = x, nlags = c(5,10,20))
nvarOfAcfKP(x, maxlag = 20)
whiteNoiseTest(x.acf, h0 = "arch-type", x = x, nlags = c(5,10,20))
}
\keyword{ts}
\keyword{garch}
\keyword{htest}
