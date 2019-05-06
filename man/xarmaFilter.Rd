\name{xarmaFilter}
\alias{xarmaFilter}
\title{ Applies an extended ARMA filter to a time series }
\description{
  Filter time series with an extended arma filter.
  If \code{whiten} is \code{FALSE} (default) the function applies
  the given ARMA filter to \code{eps} (\code{eps} is often
  white noise).  If \code{whiten} is \code{TRUE} the function applies
  the \dQuote{inverse filter} to \eqn{x}, effectively computing
  residuals.
}
\usage{
xarmaFilter(model, x = NULL, eps = NULL, from = NULL, whiten = FALSE,
            xcenter = NULL, xintercept = NULL)
}
\arguments{
  \item{x}{ the time series to be filtered, a vector. }
  \item{eps}{ residuals, a vector or NULL. }
  \item{model}{
    the model parameters, a list with components \code{"ar"},
    \code{"ma"}, \code{"center"} and \code{"intercept"}, see Details.
  }
  \item{from}{ the index from which to start filtering. }
  \item{whiten}{
    if TRUE use \code{x} as input and apply the inverse filter to
    produce \code{eps} ("whiten" \code{x}), if FALSE use \code{eps} as
    input and generate \code{x} ("colour" \code{eps}).
  }
  \item{xcenter}{
    a vector of means of the same length as the time series, see Details.
  }
  \item{xintercept}{
    a vector of intercepts having the length of the series, see Details.
  }
}
\details{

  The model is specified by argument \code{model}, which is a list with
  the following components:
  \describe{

    \item{\code{ar}}{ the autoregression parameters,}
    \item{\code{ma}}{ the moving average parameters,}
    \item{\code{center}}{ center by this value,}
    \item{\code{intercept}}{intercept.}

  }

  \code{model$center} and \code{model$intercept} are scalars and usually
  at most one of them is nonzero. They can be considered part of the
  model specification. In contrast, arguments \code{xcenter} and
  \code{xintercept} are vectors of the same length as \code{x}. They can
  represent contributions from covariate variables. Usually at most one
  of \code{xcenter} and \code{xintercept} is used.

  The description below uses \eqn{\mu_t}{mu(t)} and \eqn{c_t}{c(t)} for
  the contributions by \code{model$center} plus \code{xcenter} and
  \code{model$intercept} plus \code{xintercept}, respectively.
  The time series \eqn{\{x_t\}} and \eqn{\{\varepsilon_t\}} are
  represented by \code{x} and \code{eps} in the \R code.
  Let
      \deqn{y_t = x_t - \mu_t}{y(t)=x(t)-mu(t)}
  be the centered series.  where the centering term \eqn{\mu_t}{mu(t)}
  is essentially the sum of \code{center} and \code{xcenter} and is not
  necessarilly the mean.  The equation relating the centered series,
  \eqn{y_t=x_t - \mu_t}{y(t)=x(t)-mu(t)}, and \code{eps} is the
  following:
    \deqn{ y_t
    =   c_t
      + \sum_{i=1}^{p} \phi(i)y            _{t-i}
      + \sum_{i=1}^{q} \theta(i)\varepsilon_{t-i}
      + \varepsilon_t
    }{   y(t)
      = c(t)
      + \sum_\{i=1\}^\{p\} phi(i) y(t-i)
      + \sum_\{i=1\}^\{q\} theta(i)e(t-i)
      + e(t),
    }
  where \eqn{c_t}{c(t)} is the intercept (basically the sum of
  \code{intercept} with \code{xintercept}).

  If \code{whiten = FALSE}, \eqn{y_t}{y(t)} is computed for
  \code{t=from,...,n} using the above formula, i.e. the filter is
  applied to get \code{y} from \code{eps} (and some initial values). If
  \code{eps} is white noise, it can be said that \code{y} is obtained by
  ``colouring'' the white noise \code{eps}. This can be used, for
  example, to simulate ARIMA time series.  Finally, the centering term
  is added back, \eqn{x_t=y_t+\mu_t} for \code{t=from,...,n}, and the
  modified \code{x} is returned.  The first \code{from - 1} elements of
  \code{x} are left unchanged.


  The inverse filter is obtained by rewriting the above equation as an equation
  expressing \eqn{\varepsilon_t} in terms of the remaining quantities:
  \deqn{ \varepsilon_t
    = - c_t
      - \sum_{i=1}^{q} \theta(i)\varepsilon_{t-i}
      - \sum_{i=1}^{p} \phi  (i)y          _{t-i}
      + y_t
    }{   e(t)
    = - c(t)
      - \sum_\{i=1\}^\{q\} theta(i)e(t-i)
      - \sum_\{i=1\}^\{p\} phi(i) y(t-i)
      + y(t)
    }

  If \code{whiten = TRUE}, \code{xarmaFilter} uses this formula for
  \code{t=from,...,n} to compute \code{eps} from \code{y} (and some
  initial values). If \code{eps} is white noise, then it can be said
  that the time series \code{y} has been whitened.

  In both cases the first few values in \code{x} and/or
  \code{eps} are used as initial values.


  The centering is formed from \code{model$center} and argument
  \code{xcenter}.  If \code{model$center} is supplied it is recycled
  to the length of the series, \code{x}, and subtracted from
  \code{x}. If argument \code{xcenter} is supplied, it is subtracted
  from \code{x}. If both \code{model$center} and \code{xcenter} are
  supplied their sum is subtracted from \code{x}.

  \code{xarmaFilter} can be used to simulate ARMA series with the
  default value of \code{whiten = FALSE}. In this case \code{eps} is the
  input series and \code{y} the output:
  Then \code{model$center} and/or \code{xcenter} are added to \code{y}
  to form the output vector \code{x}.

  Residuals corresponding to a series \code{x} can be obtained by
  setting \code{whiten = TRUE}. In this case \code{x} is the input series.
  The elements of the output vector \code{eps} are calculated by the
  formula for \eqn{\varepsilon_{t}}{e(t)} given above.
  There is no need in this case to restore \code{x} since \code{eps} is
  returned.

  In both cases any necessary initial values are assumed to be already
  in the vectors and provide the first \code{from - 1} values in the
  returned vectors.  Argument \code{from} should not be smaller than the
  default value \code{max(p,q)+1}.

  \code{xarmaFilter} calls the lower level function \code{coreXarmaFilter}
  to do the computation.
}
\value{
  the result of applying the filter or its inverse, as descibed in Details:
    if \code{whiten = FALSE}, the modified \code{x};
    if \code{whiten = TRUE}, the modified \code{eps}.
}
%\references{ }
\author{Georgi N. Boshnakov}
%\note{ }
%\section{Level}{1}
%\seealso{
%  the lower level functions
%  \code{\link{coreXarmaFilter}}
%  which does the computations
%}
\examples{
## define a seasonal ARIMA model
m1 <- new("SarimaModel", iorder = 1, siorder = 1, ma = -0.3, sma = -0.1, nseasons = 12)

model0 <- modelCoef(m1, "ArmaModel")
model1 <- as(model0, "list")

ap.1 <- xarmaFilter(model1, x = AirPassengers, whiten = TRUE)
ap.2 <- xarmaFilter(model1, x = AirPassengers, eps = ap.1, whiten = FALSE)
ap <- AirPassengers
ap[-(1:13)] <- 0 # check that the filter doesn't use x, except for initial values.
ap.2a <- xarmaFilter(model1, x = ap, eps = ap.1, whiten = FALSE)
ap.2a - ap.2 ## indeed = 0
##ap.3 <- xarmaFilter(model1, x = list(init = AirPassengers[1:13]), eps = ap.1, whiten = TRUE)

## now set some non-zero initial values for eps
eps1 <- numeric(length(AirPassengers))
eps1[1:13] <- rnorm(13)
ap.A <- xarmaFilter(model1, x = AirPassengers, eps = eps1, whiten = TRUE)
ap.Ainv <- xarmaFilter(model1, x = ap, eps = ap.A, whiten = FALSE)
AirPassengers - ap.Ainv # = 0

## compare with sarima.f (an old function)
## compute predictions starting at from = 14
pred1 <- sarima.f(past = AirPassengers[1:13], n = 131, ar = model1$ar, ma = model1$ma)
pred2 <- xarmaFilter(model1, x = ap, whiten = FALSE)
pred2 <- pred2[-(1:13)]
all(pred1 == pred2) ##TRUE
}
\keyword{ts}
