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

  The relation between \code{x} and \code{eps} is assumed to be the
  following. Let
      \deqn{y_t = x_t - \mu_t}{y(t)=x(t)-mu(t)}
  be the centered series, where \eqn{\mu_t}{mu(t)} is obtained from
  \code{center} and \code{xcenter} and is not necessarilly the mean,
  see below. The equation relating the
  centered series, \eqn{y_t=x_t - \mu_t}{y(t)=x(t)-mean(t)}, and
  \code{eps} is the following:
    \deqn{ y_t
    =   c_t
      + \sum_{i=1}^{p} \phi(i)y            _{t-i}
      + \sum_{i=1}^{q} \theta(i)\varepsilon_{t-i}
      + \varepsilon_t
    }{   y(t)
      = c(t)
      + \sum_\{i=1\}^\{p\} phi(i) y(t-i)
      + \sum_\{i=1\}^\{q\} theta(i)e(t-i)
      + e(t)
    }
  where \eqn{c_t}{c(t)} is the intercept (basically the sum of
  \code{intercept} with \code{xintercept}. The inverse
  filter is obtained by writing this as an equation expressing
  \eqn{\varepsilon_t} in terms of the remaining quantities:
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
  If \code{whiten = TRUE}, \code{xarmaFilter} uses the above formula to
  compute the filtered values of \code{x} for \code{t=from,...,n},
  i.e. whitening the time series if \code{eps} is white noise.  If
  \code{whiten = FALSE}, \code{eps} is computed, i.e. the inverse filter
  is applied to get \code{x} from \code{eps}, i.e. ``colouring'' \code{eps}.
  In both cases the first few values in \code{x} and/or \code{eps} are
  used as initial values.

  Essentially, the centering is subtracted from the series to obtain the
  centred series, say \code{y}. Then either \code{y} is filtered to
  obtain \code{eps} or the inverse filter is applied to obtain \code{y}
  from \code{eps}. Finally the mean is added back to \code{y} and the
  result returned.

  The centering is formed from \code{model$center} and argument
  \code{xcenter}.  If \code{model$center} is supplied it is recycled
  to the length of the series, \code{x}, and subtracted from
  \code{x}. If argument \code{xcenter} is supplied, it is subtracted
  from \code{x}. If both \code{model$center} and \code{xcenter} are
  supplied their sum is subtracted from \code{x}.

  The above gives a vector \code{y}, \eqn{y_t=x_t -
  \mu_t}{y(t)=x(t)-mean(t)}, which is then filtered.  If the mean is
  zero, \eqn{y_t=x_t}{y[t]=x[t]} in the formulas below.

  Finally, the mean is added back, \eqn{x_t=y_t+\mu_t}, and the new
  \code{x} is returned.

  \code{xarmaFilter} can be used to simulate arma series with the
  default value of \code{whiten = FALSE}. In this case \code{eps} is the
  input series and \code{y} the output:
  Then \code{model$center} and/or \code{xcenter} are added to \code{y}
  to form the output vector \code{x}.

  Residuals corresponding to a series \code{y} can be obtained by
  setting \code{whiten = TRUE}. In this case \code{y} is the input series.
  The elements of the output vector \code{eps} are calculated by the
  formula for \eqn{\varepsilon_{t}}{e(t)} given above.
  There is no need in this case to restore \code{x} since \code{eps} is
  returned.

  In both cases any necessary initial values are assumed to be already
  in the vectors. Argument \code{from} should be not smaller than the
  default value \code{max(p,q)+1}.

  \code{xarmaFilter} calls the lower level function \code{coreXarmaFilter}
  to do the computation.

}
\value{
  The filtered series: the modified \code{x} if \code{whiten = FALSE}, the
  modified \code{eps} if \code{whiten = TRUE}.
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
m1 <- new("SarimaModel", iorder = 1, siorder = 1, ma = -0.3, sma = -0.1, nseasons = 12)
model0 <- modelCoef(m1, "ArmaModel")
## model1 <- filterCoef(model1)
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
