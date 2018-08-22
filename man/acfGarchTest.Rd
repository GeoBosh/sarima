\name{acfGarchTest}
\alias{acfGarchTest}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Test for GARCH white noise}
\description{Carry out a test for GARCH white noise}
\usage{
acfGarchTest(acr, x, nlags, interval = 0.95)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{acr}{autocorrelations.}
  \item{x}{time series.}
  \item{nlags}{how many lags to use.}
  \item{interval}{If not NULL, compute also confidence intervals with
    the specified coverage probability.}
}
\details{

  \code{acfGarchTest} performs a test for uncorrelatedness of a time
  series. The null hypothesis is that the time series is GARCH,
  see Francq \& Zakoian (2010).

  Unlike the autocorrelation IID test, the time series is needed here to
  estimate the covariance matrix of the autocorrelations under the null
  hypothesis.

  The format of the return vaue is the same as for \code{acfIidTest}.

}
\value{
  a list with components "test" and "ci"
}
\references{
  \insertRef{FrancqZakoian2010garch}{sarima}
}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{whiteNoiseTest}},
  \code{\link{acfIidTest}}
}
\examples{
## see also the examples for \code{\link{whiteNoiseTest}}
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
}
\keyword{ts}
\keyword{garch}
\keyword{htest}
