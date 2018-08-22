\name{sarima.f}
\alias{sarima.f}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
  Function used internally to compute forecasts
}
\description{
  Function used internally to compute forecasts.
}
\usage{
sarima.f(past = numeric(length(ar)), n = max(2 * length(past), 12),
         ar = numeric(0), ma = numeric(0), intercept = 0,
         pasteps = numeric(length(ma)), trend = numeric(n))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{past}{past values of the time series.}
  \item{n}{number of forecasts to generate.}
  \item{ar}{ar coefficients.}
  \item{ma}{ma coefficients.}
  \item{intercept}{intercept.}
  \item{pasteps}{past values of the innovations.}
  \item{trend}{trend.}
}
\details{
  Computes predictions using the specified parameters and past values.
  \code{ar} and \code{ma} are the coefficients of the fully expanded
  polynomials of a SARIMA mmodel.
}
\value{
  numeric vector
}
% \references{
% %% ~put references to the literature/web site here ~
% }
% \author{
% %%  ~~who you are~~
% }
\author{Georgi N. Boshnakov}
% \note{
% %%  ~~further notes~~
% }
%
% %% ~Make other sections like Warning with \section{Warning }{....} ~
%
% \seealso{
% %% ~~objects to See Also as \code{\link{help}}, ~~~
% }
% \examples{
% }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ internal }
