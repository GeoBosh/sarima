\name{arma_Q0Gardner}
\alias{arma_Q0Gardner}
\alias{arma_Q0bis}
\alias{arma_Q0naive}
\alias{arma_Q0gnbR}
\title{Computing the initial state covariance matrix of ARMA}
\description{
  Wrappers for the internals 'stats' functions used by arima()
  to compute the initial state covariance matrix of ARMA models.
}
\usage{
% arma_Q0Gardner(phi, theta, tol = .Machine$double.eps)

% arma_Q0bis(phi, theta, tol = .Machine$double.eps)

arma_Q0naive(phi, theta, tol = .Machine$double.eps)

arma_Q0gnbR(phi, theta, tol = .Machine$double.eps)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{phi}{autoregressive coefficients.}
  \item{theta}{moving average coefficients.}
  \item{tol}{tollerance.}
}
\details{
  
  \code{arima()} uses one of two methods to compute the initial state
  covariance matrix of a stationary ARMA model. Both methods are
  implemented by internal non-exported C functions.
  \code{arma_Q0Gardner()} and \code{arma_Q0bis} are simple \R wrappers
  for those functions. They are defined in the tests (\strong{TODO:} put
  in the examples?) bit are not defined in the namespace of the package
  since they use unexported functions. 

  \code{arma_Q0Gardner()} implements the original method from Gardner et
  al (1980). \code{arma_Q0bis()} is a more recent method that deals
  better with roots very close to the unit circle.

  These functions can be useful for comparative testing.  They cannot be
  put in package 'sarima' since they use \code{`:::`} operator and are
  hence inadmissible to CRAN.
  
}
\value{
  a matrix
}
\references{
  \insertRef{gardner+harvey+phillips:1980}{sarima}

}
%\author{
%%%  ~~who you are~~
%}
%\note{
%%%  ~~further notes~~
%}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
## arma_Q0Gardner(phi, theta, tol = .Machine$double.eps)
## arma_Q0bis(phi, theta, tol = .Machine$double.eps)
}
\keyword{arma}
\keyword{arima}
\keyword{htest}



