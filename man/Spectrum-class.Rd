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

\method{plot}{Spectrum}(x, y, to, from = y, n = 128, standardize = TRUE,
    log = NULL, main = "Spectral density", xlab = "Frequency", ylab = NULL, ...)
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

  \item{log}{
    if \code{log = "y"} plot the logarithm of the spectral density, see
    \code{?plot.default}.
  }
  \item{main}{
    a character string, the title of the plot.
  }
  \item{xlab}{
    a character string, the label for the x-axis.
  }
  \item{ylab}{

    a character string, the label for the y-axis. If \code{NULL}, the
    default, the label is set to \code{"Spd"} or \code{"log(Spd)"},
    depending on the value of argument \code{log}.

  }
  \item{\dots}{

    for \code{print}, further arguments for \code{print.default()};

    for \code{plot}, further arguments for \code{\link[graphics]{curve}}.

  }
}
\details{

  \code{"Spectrum"} is an S4 class and as such autoprinting calls the
  \code{"Spectrum"} method for \code{show()}, which prints and
  plots. \code{show} has a single argument, the object.  For more
  control over printing, call \code{print} which has additional
  arguments. Similarly, call \code{plot} for more flexible graphics.
      
  \code{print(object)} (i.e., without further arguments) is equivalent
  to \code{show(object)}, except that the former returns \code{object}
  while the latter returns \code{NULL} (both invisibly), as is standard
  for these functions.  If \code{print} is called with further
  arguments. the spectrum is not plotted.

  The peaks and throughs printed by \code{print} are computed by
  evaluating the spectral density at \code{n} equially spaced points and
  recording the maxima of the resulting discrete sequence. Set argument
  \code{n} to get a finer/coarser grid or to force calculations for
  particular frequencies. For example, a multiple of 12 may be suitable
  for \code{n} if the data is monthly.

  Except for \code{x} and \code{standardize} the arguments of the
  \code{plot} method are as for \code{curve}. With the default
  \code{standardize = TRUE} the spectral density integrates to one over
  one whole period (usually \eqn{(-1/2, 1/2]} but due to its symmetry it
  is usually plotted over the second half of that interval.
  
}

\section{Objects from the Class}{

  Objects contain spectra produced by \code{sarima::spectrum},
  see \code{\link[sarima]{spectrum}} for details.
  
  Objects can also be created by calling \code{"new"} but this is not
  recommended and currently considered internal.
  
}
\section{Slots}{
  \describe{
    \item{\code{.Data}:}{Object of class \code{"function"} ~~ }

    \item{\code{call}:}{Object of class \code{"call"} ~~ }
    
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
      including the peaks and troughs in the spectral density. It is
      equivalent to calling \code{print} and \code{plot} with a single
      argument, see section \sQuote{Details}.

    }
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
  \code{\link[sarima]{spectrum}} for details and further examples,

  \code{\linkS4class{ArmaSpectrum}} for ARMA spectra
}
\examples{
## ARFIMA(0,d,0) with parameters 'freq' and 'd'
spARFIMA0d0 <- function(freq){  sigma2 / (2 * sin(2*pi*freq/2)^(2 * d)) }
sp <- spectrum(spARFIMA0d0, param = list(sigma2 = 1, d = 0.2))
print(sp, digits = 4)
## evaluate the spd at selected frequencies 
sp(c(0:4 / 8))

## argument 'freq' doesn't need to be called 'freq' but it needs to be
##   the first one. This is equivalent to above:
spARFIMA0d0b <- function(x){  sigma2 / (2 * sin(2*pi*x/2)^(2 * d)) }
spb <- spectrum(spARFIMA0d0b, param = list(sigma2 = 1, d = 0.2))
plot(spb)

## An example without parameters, as above with sigma2 = 1, d = 0.2 hard
##   coded:
spARFIMA0d0c <- function(freq){  1 / (2 * sin(2*pi*freq/2)^(2 * 0.2)) }
spc <- spectrum(spARFIMA0d0c)
print(spc, digits = 4)

spc(c(0:4 / 8))
all.equal(spc(c(0:4 / 8)), sp(c(0:4 / 8))) # TRUE
}
\keyword{classes}
