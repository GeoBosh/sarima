\name{whiteNoiseTest}
\alias{whiteNoiseTest}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{White noise tests}
\description{White noise tests.}
\usage{
whiteNoiseTest(object, h0, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
    an object, such as sample autocorrelations or partial autocorrelations.}
  \item{h0}{the null hypothesis, currently "iid" or "garch".}
  \item{\dots}{
    additional arguments passed on to methods.
  }
}
\details{

  \code{whiteNoiseTest} carries out tests for white noise.  The null
  hypothesis is identified by argument \code{h0}, based on which
  \code{whiteNoiseTest} chooses a suitable function to call.  The
  functions implementing the tests are also available to be called
  directly and their documentation should be consulted for further
  arguments that are available.

  If \code{h0 = "iid"}, the test statistics and rejection regions can be
  use to test if the underlying time series is iid. Argument
  \code{method} specifies the method for portmanteau tests: one of
  "LiMcLeod" (default), "LjungBox", "BoxPierce".

  If \code{h0 = "garch"}, the null hypothesis is that the time series is
  GARCH, see Francq \& Zakoian (2010). The
  tests in this case are based on a non-parametric estimate of the
  asymptotic covariance matrix.

  Portmonteau statistics and p-values are computed for the lags
  specified by argument \code{nlags}. If it is missing, suitable lags
  are chosen automatically.

  If argument \code{interval} is TRUE, confidence intervals for the
  individual autocorrelations or partial autocorrelations are computed.

}
\value{
  a list with component \code{test} and, if \code{ci=TRUE}, component
  \code{ci}.
}
\references{
  \insertRef{FrancqZakoian2010garch}{sarima}

  \insertRef{Li2004diagnostic}{sarima}

}
\author{Georgi N. Boshnakov}

\note{
  Further methods will be added in the future.
}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  \code{\link{acfGarchTest}} (\code{h0 = "garch"}),
  \code{\link{acfIidTest}} (\code{h0 = "iid"});

  \code{\link{acfMaTest}}
}
\examples{
n <- 5000
x <- sarima:::rgarch1p1(n, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)
x.acf <- autocorrelations(x)
x.pacf <- partialAutocorrelations(x)

x.iid <- whiteNoiseTest(x.acf, h0 = "iid", nlags = c(5,10,20), x = x, method = "LiMcLeod")
x.iid

x.iid2 <- whiteNoiseTest(x.acf, h0 = "iid", nlags = c(5,10,20), x = x, method = "LjungBox")
x.iid2

x.garch <- whiteNoiseTest(x.acf, h0 = "garch", nlags = c(5,10,20), x = x)
x.garch
}
\keyword{ts}
\keyword{htest}
\keyword{garch}
% use one of  RShowDoc("KEYWORDS")
