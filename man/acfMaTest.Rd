\name{acfMaTest}
\alias{acfMaTest}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Autocorrelation test for MA(q)}
\description{Carry out autocorrelation test for MA(q).}
\usage{
acfMaTest(acf, ma, n, nlags, interval = 0.95)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{acf}{autocorrelations.}
  \item{ma}{a positive integer, the moving average order.}
  \item{n}{length of the corresponding time series.}
  \item{nlags}{
    number of autocorrelations to use for the portmonteau
    statistic, can be a vector to request several such statistics.
  }
  \item{interval}{
    a number or NULL.
  }
}
\details{

  \code{acfMaTest} performs a test that the time series is MA(\code{ma}), 
  under the classical assumptions of Bartlett's formulas.

  When intervals are requested, they are confidence intervals for lags from 1 to
  \code{ma}.  For lags greater than the moving average order, \code{ma},
  autocorrelations outside them suggest to reject the null hypothesis that the
  process is MA(\code{ma}).

%%  ~~ If necessary, more details than the description above ~~
}
\value{
    a list with components "test" and (if requested) "ci"
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link{whiteNoiseTest}},
  \code{\link{acfIidTest}}
  \code{\link{acfGarchTest}}
}
%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ts}
\keyword{htest}
% use one of  RShowDoc("KEYWORDS")
