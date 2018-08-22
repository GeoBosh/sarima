\name{sim_sarima}
\alias{sim_sarima}
\title{
  Simulate trajectories of seasonal arima models
}
\description{
  Simulate trajectories of seasonal arima models.
}
\usage{
sim_sarima(model, n = NA, rand.gen = rnorm, n.start = NA, x, eps,
           xcenter = NULL, xintercept = NULL, \dots)
}
\arguments{
  \item{model}{specification of the model, a list, see `Details'.}
  \item{rand.gen}{
    random number generator for the innovations.
  }
  \item{n}{length of the time series.}
  \item{n.start}{number of burn-in observations.}
  \item{x}{
    initial/before values of the time series, a list, a numeric
    vector or time series, see Details.
  }
  \item{eps}{
    initial/before values of the innovations, a list or a numeric
    vector, see Details.
  }
  \item{xintercept}{
    non-constant intercept which may represent trend or covariate
    effects.
  }
  \item{xcenter}{currently ignored.}
  \item{\dots}{additional arguments for \code{arima.sim} and
    \code{rand.gen}, see `Details'.
  }
}
\details{

  The model is specified by the argument "model" which is a list with
  elements suitable to be passed to \code{new("SarimaModel", ...)}, see
  the description of class \code{"SarimaModel"}. Here are some of the
  possible components:

  \describe{
    \item{nseasons}{number of seasons in a year (or whatever is the larger
      time unit)}
    \item{iorder}{order of differencing, specifies the factor
      \eqn{(1-B)^{d1}} for the model.
    }
    \item{siorder}{order of seasonal differencing, specifies the factor
      \eqn{(1-B^{period})^{ds}}  for the model.}
    \item{ar}{ar parameters (non-seasonal)}
    \item{ma}{ma parameters (non-seasonal)}
    \item{sar}{seasonal ar parameters}
    \item{sma}{seasonal ma parameters}
  }

  Additional arguments for \code{rand.gen}  may be specified
  via the "\dots" argument.
  In particular, the length of the generated series is specified with
  argument \code{n}. Arguments for \code{rand.gen} can also be passed
  via the "\dots" argument.

  \code{sim_sarima} calls internally \code{arima.sim} to simulate the
  ARMA part of the model. Then undifferences the result to obtain the
  end result.

  The function returns the simulated time series from the requested
  model.

  Information about the model is printed on the screen if
  \code{info="print"}. To suppress this, set \code{info} to any other
  value.
}
\value{
  an object of class "ts"
}
% \references{
% %% ~put references to the literature/web site here ~
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
\examples{
require("PolynomF") # package "sarima" imports it, so should not be absent here.

x <- sim_sarima(n=144, model = list(ma=0.8))               # MA(1)
x <- sim_sarima(n=144, model = list(ar=0.8))               # AR(1)

x <- sim_sarima(n=144, model = list(ar=c(rep(0,11),0.8)))  # SAR(1), 12  seasons
x <- sim_sarima(n=144, model = list(ma=c(rep(0,11),0.8)))  # SMA(1)

                                  # more enlightened SAR(1) and SMA(1)
x <- sim_sarima(n=144,model=list(sar=0.8, nseasons=12, sigma2 = 1))  # SAR(1), 12 seasons
x <- sim_sarima(n=144,model=list(sma=0.8, nseasons=12, sigma2 = 1))  # SMA(1)

x <- sim_sarima(n=144, model = list(iorder=1, sigma2 = 1)) # (1-B)X_t = e_t (random walk)
acf(x)
acf(diff(x))

x <-sim_sarima(n=144, model = list(iorder=2, sigma2 = 1))  # (1-B)^2 X_t = e_t
x <-sim_sarima(n=144, model = list(siorder=1,
                                   nseasons=12, sigma2 = 1)) # (1-B)^{12} X_t = e_t

x <- sim_sarima(n=144, model = list(iorder=1, siorder=1,
                                    nseasons=12, sigma2 = 1))
x <- sim_sarima(n=144, model = list(ma=0.4, iorder=1, siorder=1,
                                    nseasons=12, sigma2 = 1))
x <- sim_sarima(n=144, model = list(ma=0.4, sma=0.7, iorder=1, siorder=1,
                                    nseasons=12, sigma2 = 1))

x <- sim_sarima(n=144, model = list(ar=c(1.2,-0.8), ma=0.4,
                                    sar=0.3, sma=0.7, iorder=1, siorder=1,
                                    nseasons=12, sigma2 = 1))

x <- sim_sarima(n=144, model = list(iorder=1, siorder=1,
                                    nseasons=12, sigma2 = 1),
                x = list(init=AirPassengers[1:13]))

p <- polynom(c(1,-1.2,0.8))
solve(p)
abs(solve(p))

sim_sarima(n=144, model = list(ar=c(1.2,-0.8), ma=0.4, sar=0.3, sma=0.7,
                               iorder=1, siorder=1, nseasons=12))

x <- sim_sarima(n=144, model=list(ma=0.4, iorder=1, siorder=1, nseasons=12))
acf(x, lag.max=48)
x <- sim_sarima(n=144, model=list(sma=0.4, iorder=1, siorder=1, nseasons=12))
acf(x, lag.max=48)
x <- sim_sarima(n=144, model=list(sma=0.4, iorder=0, siorder=0, nseasons=12))
acf(x, lag.max=48)
x <- sim_sarima(n=144, model=list(sar=0.4, iorder=0, siorder=0, nseasons=12))
acf(x, lag.max=48)
x <- sim_sarima(n=144, model=list(sar=-0.4, iorder=0, siorder=0, nseasons=12))
acf(x, lag.max=48)

x <- sim_sarima(n=144, model=list(ar=c(1.2, -0.8), ma=0.4, sar=0.3, sma=0.7,
                                  iorder=1, siorder=1, nseasons=12))
}
\keyword{ts}
\keyword{simulation}
%\keyword{datagen}
