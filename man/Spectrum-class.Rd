\name{Spectrum-class}
\Rdversion{1.1}
\docType{class}
\alias{Spectrum-class}
\alias{plot,Spectrum,ANY-method}
\alias{show,Spectrum-method}
\alias{plot.Spectrum}
\alias{print.Spectrum}

\title{Class \code{"Spectrum"}}
\description{

  Objects from class \code{"Spectrum"} spectra computed by
  \code{\link[sarima]{spectrum}}. 

}
\usage{
\method{print}{Spectrum}(x, ..., n = 128, standardize = TRUE)

\method{plot}{Spectrum}(x, y, to, from = y, n = 128, standardize = TRUE, ...)
}
\arguments{
  \item{x}{a \code{"Spectrum"} object.}
  \item{y}{not used but same as \code{from}}
  \item{from,to}{
    interval of frequencies to plot, defaults to \eqn{[0,1/2]}.
  }
  \item{n}{
    number of points to plot (for the plot method), number of points to
    look at for the peaks and troughs (print method).
  }
  \item{standardize}{
    if \code{TRUE} make the spectral density integrate to one (i.e., be
    a probability density function).
  }
  \item{\dots}{

    for \code{print}, further arguments for \code{print.default()};
    for \code{plot}, further arguments for \code{\link[graphics]{curve}}.

  }
}
\section{Objects from the Class}{

  Objects contain spectra produced by \code{sarima::spectrum}
  (recommended), see \code{\link[sarima]{spectrum}} for details.
  
  Objects can also be created by calls of the form
  \code{new("Spectrum", ar = , ma = , sigma2 = , ...)},
  where \code{ar} and \code{ma} are numeric vectors and \code{sigma2} is
  a number. \code{sigma2} may be omitted but then only normalized
  spectra can be computed. There further possibilities for the arguments
  but they should be considered internal and subject to change.
  
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{Object of class \code{"function"} ~~ }

    \item{\code{model}:}{Object of class \code{"ANY"},
      the underlying model.
    }
  
  }
}
\section{Methods}{
  \describe{
    \item{plot}{\code{signature(x = "Spectrum", y = "ANY")}:
      plots \code{x}.
    }
    \item{show}{\code{signature(object = "Spectrum")}:
      
      plots \code{object} and prints succinct information about it,
      including the peaks and troughs in the spectral density
      (sd). These are computed by evaluating the sd at \code{n} equially
      spaced points and recording the maxima of the resulting discrete
      sequence. Set argument \code{n} to get a finer/coarser grid or to
      force calculations for particular frequencies. For example, a
      multiple of 12 may be suitable for \code{n} if the data is
      monthly.

    }
  
    \item{initialize}{\code{signature(.Object = "Spectrum")}: ... }}
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
  \code{\link[sarima]{spectrum}} for details and examples
}
\examples{
## spectral density of the stationary part of a fitted 'airline model'
fit0 <- arima(AirPassengers, order = c(0,1,1),
              seasonal = list(order = c(0,1,1), period = 12))
sd.air <- spectrum(fit0)
show(sd.air)

## use the "Spectrum" object as a function to evaluate the sp. density:
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
