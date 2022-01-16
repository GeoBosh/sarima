\name{plot-methods}
\docType{methods}
\alias{plot-methods}
\alias{plot,SampleAutocorrelations,matrix-method}
\alias{plot,SampleAutocorrelations,missing-method}
\alias{plot,SamplePartialAutocorrelations,missing-method}
\title{Plot methods in package sarima}
\description{

  Plot methods in package sarima.

}
\section{Methods}{
\describe{

\item{\code{signature(x = "SampleAutocorrelations", y = "matrix")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(x = "SampleAutocorrelations", y = "missing")}}{

  plots the sample autocorrelations with (individual) rejection limits
  computed under the null hypothesis of i.i.d. (strong white noise) If
  argument \code{data} is provided, it should be the time series from
  which the autocorrelations were computed. In this case rejection
  limits for null hypothesis that the time series is (garch) weak white
  noise are provided, as well.

  Additional arguments can be supplied, see \code{\link{whiteNoiseTest}}
  the examples, and the vignettes.

}

\item{\code{signature(x = "SamplePartialAutocorrelations", y =
    "missing")}}{
  
    plots the sample partial autocorrelations with rejection limits for
    the hypotheses and controlling arguments as for \code{"SampleAutocorrelations"}.
    
}
}}
\seealso{
  \code{\link{whiteNoiseTest}} for the computations for the rejection
  levels;

  
}
\examples{
set.seed(1234)
n <- 5000
x <- sarima:::rgarch1p1(n, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)
x.acf <- autocorrelations(x)
x.acf
x.pacf <- partialAutocorrelations(x)
x.pacf

plot(x.acf)
## add limits for a weak white noise test:
plot(x.acf, data = x)

## similarly for pacf
plot(x.pacf)
plot(x.pacf, data = x)

plot(x.acf, data = x, main = "Autocorrelation test")
plot(x.pacf, data = x, main = "Partial autocorrelation test")

plot(x.acf, ylim = c(NA,1))
plot(x.acf, ylim.fac = 1.5)
plot(x.acf, data = x, ylim.fac = 1.5)
plot(x.acf, data = x, ylim = c(NA, 1))
}
\author{Georgi N. Boshnakov}
\keyword{methods}
\keyword{hplot}
