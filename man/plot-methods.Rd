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
%%  ~~describe this method here~~
}

\item{\code{signature(x = "SamplePartialAutocorrelations", y = "missing")}}{
%%  ~~describe this method here~~
}
}}
\examples{
n <- 5000
x <- sarima:::rgarch1p1(n, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)
x.acf <- autocorrelations(x)
x.acf
x.pacf <- partialAutocorrelations(x)
x.pacf

plot(x.acf)
plot(x.acf, data = x)

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
