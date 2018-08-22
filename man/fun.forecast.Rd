\name{fun.forecast}
\alias{fun.forecast}
\title{
  Forecasting functions for seasonal ARIMA models
}
\description{
  Forecasting functions for seasonal ARIMA models.
}
\usage{
fun.forecast(past, n = max(2 * length(past), 12), eps = numeric(n), pasteps, ...)
}
\arguments{
  \item{past}{
    past values of the time series, by default zeroes.
  }
  \item{n}{number of forecasts to compute.}
  \item{eps}{values of the white noise sequence (for simulation  of
    future). Currently not used!
  }
  \item{pasteps}{past values of the white noise sequence for models with
    MA terms, 0 by default.
  }
  \item{\dots}{specification of the model, passed to \code{new()} to
    create a \code{"SarimaModel"} object, see Details.}
}
\details{

  \code{fun.forecast} computes predictions from a SARIMA model.  The
  model is specified using the "\dots" arguments which are passed to
  \code{new("SarimaModel", ...)}, see the description of class
  \code{"SarimaModel"} for details.

  Argument \code{past}, if provided, should contain a least as many values as
  needed for the prediction equation. It is harmless to provide more
  values than necessary, even a whole time series.

  \code{fun.forecast} can be used to illustrate, for example, the
  inherent difference for prediction of integrated and seasonally
  integrated models to corresponding models with roots close to the unit
  circle.
}
\value{
  the forecasts as an object of class "ts"
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
f1 <- fun.forecast(past = 1, n = 100, ar = c(0.85), center = 5)
plot(f1)

f2 <- fun.forecast(past = 8, n = 100, ar = c(0.85), center = 5)
plot(f2)

f3 <- fun.forecast(past = 10, n = 100, ar = c(-0.85), center = 5)
plot(f3)

frw1 <- fun.forecast(past = 1, n = 100, iorder = 1)
plot(frw1)

frw2 <- fun.forecast(past = 3, n = 100, iorder = 1)
plot(frw2)

frwa1 <- fun.forecast(past = c(1, 2), n = 100, ar = c(0.85), iorder = 1)
plot(frwa1)

fi2a <- fun.forecast(past = c(3, 1), n = 100, iorder = 2)
plot(fi2a)

fi2b <- fun.forecast(past = c(1, 3), n = 100, iorder = 2)
plot(fi2b)

fari1p2 <- fun.forecast(past = c(0, 1, 3), ar = c(0.9), n = 20, iorder = 2)
plot(fari1p2)

fsi1 <- fun.forecast(past = rnorm(4), n = 100, siorder = 1, nseasons = 4)
plot(fsi1)

fexa <- fun.forecast(past = rnorm(5), n = 100, ar = c(0.85), siorder = 1,
                     nseasons = 4)
plot(fexa)

fi2a <- fun.forecast(past = rnorm(24, sd = 5), n = 120, siorder = 2,
                     nseasons = 12)
plot(fi2a)

fi1si1a <- fun.forecast(past = rnorm(24, sd = 5), n = 120, iorder = 1,
                        siorder = 1, nseasons = 12)
plot(fi1si1a)

fi1si1a <- fun.forecast(past = AirPassengers[120:144], n = 120, iorder = 1,
                        siorder = 1, nseasons = 12)
plot(fi1si1a)


m1 <- list(iorder = 1, siorder = 1, ma = 0.8, nseasons = 12, sigma2 = 1)
m1
x <- sim_sarima(model = m1, n = 500)
acf(diff(diff(x), lag = 12), lag.max = 96)
pacf(diff(diff(x), lag = 12), lag.max = 96)

m2 <- list(iorder = 1, siorder = 1, ma = 0.8, sma = 0.5, nseasons = 12,
           sigma2 = 1)
m2
x2 <- sim_sarima(model = m2, n = 500)
acf(diff(diff(x2), lag = 12), lag.max = 96)
pacf(diff(diff(x2), lag = 12), lag.max = 96)
fit2 <- arima(x2, order = c(0, 1, 1),
              seasonal = list(order = c(0, 1, 0), nseasons = 12))
fit2
tsdiag(fit2)
tsdiag(fit2, gof.lag = 96)

x2past <- rnorm(13, sd = 10)
x2 <- sim_sarima(model = m2, n = 500, x = list(init = x2past))
plot(x2)

fun.forecast(ar = 0.5, n = 100)
fun.forecast(ar = 0.5, n = 100, past = 1)
fun.forecast(ma = 0.5, n = 100, past = 1)
fun.forecast(iorder = 1, ma = 0.5, n = 100, past = 1)
fun.forecast(iorder = 1, ma = 0.5, ar = 0.8, n = 100, past = 1)

fun.forecast(m1, n = 100)
fun.forecast(m2, n = 100)
fun.forecast(iorder = 1, ar = 0.8, ma = 0.5, n = 100, past = 1)
}
\keyword{ts}
