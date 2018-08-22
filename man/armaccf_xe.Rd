\name{armaccf_xe}
\alias{armaccf_xe}
\alias{armaacf}
\title{Crosscovariances between an ARMA process and its innovations}
\description{

  Compute autocovariances of ARMA models and crosscovariances between an
  ARMA process and its innovations.

}
\usage{
armaccf_xe(model, lag.max = 1)
armaacf(model, lag.max, compare)
}
\arguments{
  \item{model}{
    the model, a list with components \code{ar}, \code{ma} and
    \code{sigma2} (for the time being, \code{sigmasq} is also accepted,
    if \code{model$sigma2} is NULL).
  }
  \item{lag.max}{maximal lag for the result.}

  \item{compare}{

    if \code{TRUE} compute the autocovariances also using
    \code{tacvfARMA()} and return both results for comparison.

  }
}
\details{

  Given a causal ARMA model, \code{armaccf_xe} computes theoretical
  crosscovariances \eqn{R_{xe}(0)}, \eqn{R_{xe}(1)},
  \eqn{R_{xe}(lag.max)}, where \eqn{R_{xe}(k)=E(X_{t}e_{t-k})}, between
  an ARMA process and its innovations. Negative lags are not considered
  since \eqn{R_{xe}(k)=0} for \eqn{k<0}. The moving average polynomial
  may have roots on the unit circle.


  This is a simple illustration of the equations I give in my time
  series courses.

  \code{armaacf} computes ARMA autocovariances. The default method
  computes computes the zero lag autocovariance using
  \code{armaccf_xe()} and multiplies the autocorrelations obtained from
  \code{ARMAacf} (which computes autocorrelations, not
  autocovariances). If \code{compare = TRUE} it also uses
  \code{tacvfARMA} from package \pkg{ltsa} and returns both results in a
  matrix for comparison. The matrix has columns \code{"native"},
  \code{"tacvfARMA"} and \code{"difference"}, where the last column
  contains the (zapped) differences between the autocorrelations
  obtained by the two methods.

  The ARMA parameters in argument \code{model} follow the
  Brockwell-Davis convention for the signs. Since \code{tacvfARMA()}
  uses the Box-Jenkins convention for the signs, the moving average
  parameters are negated for calls to \code{tacvfARMA()}.

}
\value{
  for \code{armaccf_xe}, the crosscovariances for lags 0, ..., maxlag.

  for \code{armaacf}, the autocovariances, see Details.
}
\references{
  \insertRef{McLeodYuKrougly2007}{sarima}
}
\author{Georgi N. Boshnakov}
\note{

  \code{armaacf} is useful for exploratory computations but
  \code{\link{autocovariances}} is more convenient and eliminates the
  need to know function names for particular cases.
  % The built-in R function \code{ARMAacf()} computes autocorrelations,
  % not the autocovariances.

  % \code{tacvfARMA()} uses the Box-Jenkins convention for the signs of the
  % coefficients, while the base R function \code{ARMAacf} uses the
  % Brockwell-Davis convention.
}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
## Example 1 from ?ltsa::tacvfARMA
z <- sqrt(sunspot.year)
n <- length(z)
p <- 9
q <- 0
ML <- 5
out <- arima(z, order = c(p, 0, q))

phi <- theta <- numeric(0)
if (p > 0) phi <- coef(out)[1:p]
if (q > 0) theta <- coef(out)[(p+1):(p+q)]
zm <- coef(out)[p+q+1]
sigma2 <- out$sigma2

armaacf(list(ar = phi, ma = theta, sigma2 = sigma2), lag.max = 20)
## this illustrates that the methods
## based on ARMAacf and tacvARMA are equivalent:
armaacf(list(ar = phi, ma = theta, sigma2 = sigma2), lag.max = 20, compare = TRUE)

## In the original example in ?ltsa::tacvfARMA
## the comparison is with var(z), not with the theoretical variance:
rA <- ltsa::tacvfARMA(phi, - theta, maxLag=n+ML-1, sigma2=sigma2)
rB <- var(z) * ARMAacf(ar=phi, ma=theta, lag.max=n+ML-1)
## so rA and rB are different.
## but the difference is due to the variance:
rB2 <- rA[1] * ARMAacf(ar=phi, ma=theta, lag.max=n+ML-1)
cbind(rA[1:5], rB[1:5], rB2[1:5])

## There is no need to use specific functions,
## autocovariances() is most convenient for routine use:
armalist <- list(ar = phi, ma = theta, sigma2 = sigma2)
autocovariances(armalist, maxlag = 10)

## even better, set up an ARMA model:
mo <- new("ArmaModel", ar = phi, ma = theta, sigma2 = sigma2)
autocovariances(mo, maxlag = 10)
}
\keyword{ts}
\keyword{arma}
% use one of  RShowDoc("KEYWORDS")

