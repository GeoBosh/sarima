\name{ArmaSpectrum-class}
\Rdversion{1.1}
\docType{class}
\alias{ArmaSpectrum-class}
\alias{plot,ArmaSpectrum,ANY-method}
\alias{show,ArmaSpectrum-method}
\alias{plot.ArmaSpectrum}
\alias{print.ArmaSpectrum}

\title{Class \code{"ArmaSpectrum"}}
\description{

  Objects from class \code{"ArmaSpectrum"} spectra computed by
  \code{\link[sarima]{spectrum}}. 

}
\details{

  The methods for \code{show}, \code{print} and \code{plot} work
  analogously to those for class \code{"\linkS4class{Spectrum}"} (which
  is a super class of \code{"ArmaSpectrum"}). In addition, \code{print}
  and \code{show} print also the parameters of the ARMA model.
    
}

\section{Objects from the Class}{

  Objects contain spectra produced by \code{sarima::spectrum}
  (recommended), see \code{\link[sarima]{spectrum}} for details.
  
  Objects can also be created by calls of the form
  \code{new("ArmaSpectrum", ar = , ma = , sigma2 = , ...)},
  where \code{ar} and \code{ma} are numeric vectors and \code{sigma2} is
  a number. \code{sigma2} may be omitted but then only normalized
  spectra can be computed. There further possibilities for the arguments
  but they should be considered internal and subject to change.
  
}
\section{Slots}{
  All slots are inherited from class \code{"Spectrum"}.
  \describe{
    \item{\code{.Data}:}{Object of class \code{"function"}.}
    \item{\code{call}:}{Object of class \code{"call"}.}
    \item{\code{model}:}{Object of class \code{"ANY"}.}
  }
}
\section{Methods}{
  \describe{
    \item{initialize}{\code{signature(.Object = "ArmaSpectrum")}: ... }
  }
}
%\references{
%%%  ~~put references to the literature/web site here~~
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  class \code{"\linkS4class{Spectrum}"} for further details,
  
  \code{\link[sarima]{spectrum}} for further examples
}
\examples{
## spectral density of the stationary part of a fitted 'airline model'
fit0 <- arima(AirPassengers, order = c(0,1,1),
              seasonal = list(order = c(0,1,1), period = 12))
sd.air <- spectrum(fit0)
show(sd.air)
plot(sd.air, log = "y") # plot log of the spectral density

## use the "ArmaSpectrum" object as a function to evaluate the sp. density:
sd.air(seq(0, 0.5, length.out = 13))
sd.air(seq(0, 0.5, length.out = 13), standardize = FALSE)

## white noise (constant spectral density)
sp.wn <- spectrum(ArmaModel(sigma2 = 2))
sp.wn
print(sp.wn)
print(sp.wn, standardize=FALSE)
show(sp.wn)
}
\keyword{classes}
