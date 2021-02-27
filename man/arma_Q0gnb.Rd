\name{arma_Q0gnb}
\alias{arma_Q0gnb}
\title{Compute the initial state covariance of ARMA model}
\description{Compute the initial state covariance of ARMA model}
\usage{
arma_Q0gnb(phi, theta, tol = 2.220446e-16)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{phi}{autoregression parameters.}
  \item{theta}{moving average parameters.}
  \item{tol}{tollerance. (TODO: explain)}
}
\details{

  Experimental computation of the initial state covariance matrix of
  ARMA models.

  The numerical results are comparable to
  \code{SSinit = "Rossignol2011"} method in \code{\link{arima}} and
  related functions.
  The method seems about twice faster than "Rossignol2011" on the models
  I tried but I haven't done systematic tests. 

  See section \sQuote{examples} below and, for more tests based on the
  tests from \pkg{stats}, the tests in
  \verb{test/testthat/test-arma-q0.R}.
 
}
\value{
   a matrix
}
\references{
  \insertRef{gardner+harvey+phillips:1980}{sarima}

  R bug report PR#14682 (2011-2013)
  <URL: https://bugs.r-project.org/bugzilla3/show_bug.cgi?id=14682>.
}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
    \code{\link{makeARIMA}}, 
    \code{\link{arima}}
}
\examples{
Q0a <- arma_Q0gnb(c(0.2, 0.5), c(0.3)) 
Q0b <- makeARIMA(c(0.2, 0.5), c(0.3), Delta = numeric(0))$Pn
all.equal(Q0a, Q0b) ## TRUE

## see test/testthat/test-arma-q0.R for more;
## these functions cannot be defined in the package due to their use of
## \code{:::} on exported base R functions.
##
## "Gardner1980"
arma_Q0Gardner <- function(phi, theta, tol = .Machine$double.eps){
    ## tol is not used here
    .Call(stats:::C_getQ0, phi, theta)
}
## "Rossignol2011"
arma_Q0bis <- function(phi, theta, tol = .Machine$double.eps){
    .Call(stats:::C_getQ0bis, phi, theta, tol)
}

arma_Q0Gardner(c(0.2, 0.5), c(0.3))
arma_Q0bis(c(0.2, 0.5), c(0.3)) 
Q0a
Q0b
}
\keyword{arma}
\keyword{arima}
% use one of  RShowDoc("KEYWORDS")
