\name{spectrum}
\alias{spectrum}
\alias{spec}
\alias{spectrum.default}
\alias{spectrum.Arima}
\alias{spectrum.ArmaModel}
\alias{spectrum.SarimaModel}

\alias{spectrum,ANY-method}
\alias{spectrum,ArmaModel-method}
\alias{spectrum,SarimaModel-method}
\alias{print.genspec}

\title{Spectral Density}
\description{
  
  Estimate the spectral density of a time series or compute the spectral
  density associated with a time series model.

}
\usage{
spectrum(x, standardize = TRUE, \dots)

\method{spectrum}{default}(x, standardize = TRUE, raw = TRUE, taper = 0.1, 
         demean = FALSE, detrend = TRUE, \dots)

\method{print}{genspec}(x, n.head = min(length(x$spec), 6), sort = TRUE, plot = TRUE, \dots)

\method{spectrum}{Arima}(x, standardize = TRUE, \dots)

\method{spectrum}{ArmaModel}(x, standardize = TRUE, \dots)

\method{spectrum}{SarimaModel}(x, standardize = TRUE, \dots)
}
\arguments{
  \item{x}{
    a model or a univariate or multivariate time series.
  }
  \item{standardize}{
    if \code{TRUE}, the default method standardises the time series
    before computing the periodogram, while the methods for models scale
    the spectral density so that it is a probability density function.
  }
  \item{raw}{

    if \code{TRUE}, the default, compute a completely raw periodogram,
    unless further arguments request otherwise, see section Details.

  }
  \item{taper,demean,detrend}{

    see \code{\link[stats]{spec.pgram}} and section \sQuote{Details}.

  }
  \item{...}{
    further arguments for the default method. Currently not used by
    other methods.
  }
  \item{n.head}{how many rows to print?}
  \item{sort}{\code{TRUE}, \code{FALSE} or \code{"max"}, see section \sQuote{Details'}.}
  \item{plot}{if \code{TRUE}, the default, plot the spectrum.}
}
\details{
  
  \code{spectrum} in package \pkg{sarima} is a generic function with a
  default method its namesake in package \pkg{stats}, see its help page
  \code{\link[stats]{spectrum}} for a full description of its
  functionality.

  \code{print(object)} (and \code{show}, where applicable), for objects
  returned by \code{spectrum} print concise information about the
  spectrum and plot it. This means that a plot is produced whenever
  printing of the object occurs. Most usefully, when the result of a
  call to the function is not assigned to a variable or if a command
  containing just the name of the object is executed. If you don't want
  the graph, just assign the result to a variable. For more control over
  the printing (for example, number of digits) use \code{print(object,
  ...)} explicitly. Similarly, call \code{plot} if additional graphical
  parameters are desired. Note that \code{print} doesn't plot when there
  are additional arguments in the call.

  All methods print some basic information about the object and a table
  giving the most influential frequencies and their contributions to the
  spectrum.
  
  Methods for objects representing ARIMA and SARIMA models (fitted or
  theoretical) compute the corresponding spectral densities. For
  non-stationary models, the spectral density for the stationary part.
  These methods for \code{spectrum} return objects from class
  \code{"Spectrum"}.  If \code{standardize = TRUE} the spectral density
  is scaled, so that it integrates to one (and so is a probability
  density function).  For fitted models confidence bands are not
  computed currently.

  The rest of this section describes the default method. For futher
  details on the other methods see \code{"\linkS4class{Spectrum}"}.


  \subsection{The default method for \code{spectrum}}{

    The default method is a wrapper for \code{stats::spectrum()}.
  
    The default method returns an object from class "genspec". It
    inherits from \code{"spec"}, the class returned by
    \code{stats::spectrum}, and adds some additional components. The
    main difference though is that it has a print method, which plots
    the object as discussed above.  \code{raw = FALSE} with no further
    arguments is equivalent to \code{stats::spectrum(object)} and
    computes a raw periodogram (for the standardised time series if
    \code{standardize = TRUE}). This still detrends and tapers the
    series though.  \code{raw = TRUE} sets \code{detrend} to
    \code{FALSE}, \code{taper} to zero, and \code{demean} to
    \code{TRUE}, to compute a \sQuote{completely raw} periodogram. In
    both cases, further arguments are respected.

    Argument \code{sort} of the \code{print} method for \code{"genspec"}
    controls the sorting order of the columns of the printed table. If
    \code{FALSE}, no sorting is done.  If \code{TRUE}, the spectrum is
    sorted in decreasing order, so the first row contains the frequency
    with the highest value of the spectrum. If \code{"max"}, the local
    maxima are found and sorted in decreasing order, followed by the
    rest, also sorted in decreasing order. Note that due to aliasing the
    local maxima may be shifted from the \dQuote{true} frequency
    (e.g. not be exactly on the harmonics of the number of
    seasons). Tapering and smoothing parameters may help.

    The plot method for class \code{"genspec"} is inherited from that
    for \code{"spec"}, see \code{?plot.spec}.
  
  }
}
\value{

  for the default method, an object of class \code{"genspec"}, which
  inherits from \code{"spec"}, and contains the following additional
  components:
  \item{standardized}{TRUE or FALSE,}
  \item{nseasons}{number of seasons,}
  \item{freq.range}{\code{numeric(2)}, the frequency range - \verb{(-m/2, m/2]},
    where \code{m = floor(frequency(x))};}

  for the remaining methods, an object of class \code{"\linkS4class{Spectrum}"}.  
}
%\references{ 
%}
%\note{
%}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link[stats]{spectrum}} which is called by the default method to
    do the work.

  class \code{"\linkS4class{Spectrum}"} for further details on the
  methods for objects returned by \code{spectrum()}.

}
\examples{
## spectral density of the stationary part of a fitted 'airline model'
fit0 <- arima(AirPassengers, order = c(0,1,1),
              seasonal = list(order = c(0,1,1), period = 12))
spectrum(fit0)

## spectral densities of some ARMA models models from Chan and Gray ().
##   (TODO: complete the reference)
spectrum(ArmaModel(ma = c(-1, 0.6), sigma2 = 1))
spectrum(ArmaModel(ar = 0.5, sigma2 = 1))
spectrum(ArmaModel(ar = 0.5, ma = -0.8, sigma2 = 1))
spectrum(new("SarimaModel", ar = 0.5, sar = 0.9, nseasons = 12, sigma2 = 1))

mo <- new("SarimaModel", ma = -0.4, sma = -0.9, nseasons = 12, sigma2 = 1)
sp1.mo <- spectrum(mo)
## this also plots the object.  (if you are reading the web version, generated
##     by pkgdown, it may not be showing some of the graphs,
##     I haven't figured out why.)
show(sp1.mo)  # equivalently, just sp1.mo

print(sp1.mo)
print(sp1.mo, digits = 4)
plot(sp1.mo)
plot(sp1.mo, standardize = FALSE)
head(sp1.mo())
sp1.mo(seq(0, 0.5, length.out = 12))
sp1.mo(seq(0, 0.5, length.out = 12), standardize = FALSE)

sarima1b <- new("SarimaModel", ar = 0.9, ma = 0.1, sar = 0.5, sma = 0.9,
                nseasons = 12, sigma2 = 1)
show(spectrum(sarima1b))

## default method for spectrum()

## frequency range is c(-1/2, 1/2] since frequency(x) = 1
frequency(lh)
spectrum(lh)

## frequency range is c(-12/2, 12/2] since frequency(x) = 12
frequency(ldeaths)
( sp <- spectrum(ldeaths) )
print(sp) # equivalently: print(sp, sort = TRUE)
print(sp, sort = FALSE, n.head = Inf, plot = FALSE)
print(sp, sort = "max", plot = FALSE)
print(sp, sort = "max", n.head = Inf, plot = FALSE)
plot(sp)
plot(sp, log = "dB")  # see ?plot.spec for further arguments
}
\keyword{ts}
