\name{coerce-methods}
\docType{methods}
\alias{coerce-methods}
\alias{setAs}
\alias{coerce,ANY,Autocorrelations-method}
\alias{coerce,ANY,ComboAutocorrelations-method}
\alias{coerce,ANY,ComboAutocovariances-method}
\alias{coerce,ANY,PartialAutocorrelations-method}
\alias{coerce,ANY,PartialAutocovariances-method}
\alias{coerce,ANY,PartialVariances-method}
\alias{coerce,ArmaSpec,list-method}
\alias{coerce,Autocorrelations,ComboAutocorrelations-method}
\alias{coerce,Autocorrelations,ComboAutocovariances-method}
\alias{coerce,Autocovariances,ComboAutocorrelations-method}
\alias{coerce,Autocovariances,ComboAutocovariances-method}
\alias{coerce,BJFilter,SPFilter-method}
\alias{coerce,numeric,BJFilter-method}
\alias{coerce,numeric,SPFilter-method}
\alias{coerce,PartialVariances,Autocorrelations-method}
\alias{coerce,PartialVariances,Autocovariances-method}
\alias{coerce,PartialVariances,ComboAutocorrelations-method}
\alias{coerce,PartialVariances,ComboAutocovariances-method}
\alias{coerce,SarimaFilter,ArmaFilter-method}
\alias{coerce,SarimaModel,list-method}
\alias{coerce,SPFilter,BJFilter-method}
\alias{coerce,vector,Autocorrelations-method}
\alias{coerce,vector,Autocovariances-method}
\alias{coerce,vector,PartialAutocorrelations-method}
\alias{coerce,vector,PartialAutocovariances-method}
\alias{coerce,VirtualArmaFilter,list-method}
\alias{coerce,VirtualSarimaModel,ArmaModel-method}

\title{setAs methods in package sarima}
\description{Methods for as() in package sarima.}
\section{Methods}{

  This section shows the methods for converting objects from one class
  to another, defined via \code{setAs()}. Use \code{as(obj,
  "classname")} to convert object \code{obj} to class "classname".

\describe{

\item{\code{signature(from = "ANY", to = "Autocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "ANY", to = "ComboAutocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "ANY", to = "ComboAutocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "ANY", to = "PartialAutocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "ANY", to = "PartialAutocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "ANY", to = "PartialVariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "ArmaSpec", to = "list")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "Autocorrelations", to = "ComboAutocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "Autocorrelations", to = "ComboAutocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "Autocovariances", to = "ComboAutocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "Autocovariances", to = "ComboAutocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "BJFilter", to = "SPFilter")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "numeric", to = "BJFilter")}}{
  Convert a numeric vector to a BJFilter object.
  This is a way to state that the coefficients follow the Box-Jenkins
  convention for the signs, see the examples.
}

\item{\code{signature(from = "numeric", to = "SPFilter")}}{
  Convert a numeric vector to an SPFilter object.  This is a way to
  state that the coefficients follow the signal processing (SP)
  convention for the signs, see the examples.
}

\item{\code{signature(from = "PartialVariances", to = "Autocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "PartialVariances", to = "Autocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "PartialVariances", to = "ComboAutocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "PartialVariances", to = "ComboAutocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "SarimaFilter", to = "ArmaFilter")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "SarimaModel", to = "list")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "SPFilter", to = "BJFilter")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "vector", to = "Autocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "vector", to = "Autocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "vector", to = "PartialAutocorrelations")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "vector", to = "PartialAutocovariances")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "VirtualArmaFilter", to = "list")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(from = "VirtualSarimaModel", to = "ArmaModel")}}{
%%  ~~describe this method here~~
}
}}
\author{Georgi N. Boshnakov}
\examples{

## the default for ARMA model is BJ for ar and SP for ma:
mo <- new("ArmaModel", ar = 0.9, ma = 0.4, sigma2 = 1)
modelPoly(mo)

## here we declare explicitly that 0.4 uses the SP convention
##    (not necessary, the result is the same, but the intention is clear).
mo1 <- new("ArmaModel", ar = 0.9, ma = as(0.4, "SPFilter"), sigma2 = 1)
modelPoly(mo1)
identical(mo, mo1) ## TRUE

## if the sign of theta follows the BJ convention, this can be stated unambiguously.
##   This creates the same model:
mo2 <- new("ArmaModel", ar = 0.9, ma = as(-0.4, "BJFilter"), sigma2 = 1)
modelPoly(mo2)
identical(mo, mo2) ## TRUE

## And this gives the intended model whatever the default conventions:
ar3 <- as(0.9, "BJFilter")
ma3 <- as(-0.4, "BJFilter")
mo3 <- new("ArmaModel", ar = ar3, ma = ma3, sigma2 = 1)
modelPoly(mo3)
identical(mo, mo3) ## TRUE

## The coefficients can be extracted in any particular form,
## e.g. to pass them to functions with specific requirements:
modelCoef(mo3) # coefficients of the model with the default (BD) sign convention
modelCoef(mo3, convention = "BD") # same result
modelCoef(mo3, convention = "SP") # signal processing convention


## for ltsa::tacvfARMA() the convention is BJ, so:
co <- modelCoef(mo3, convention = "BJ") # Box-Jenkins convention

ltsa::tacvfARMA(co$ar, co$ma, maxLag = 6, sigma2 = 1)
autocovariances(mo3, maxlag = 6) ## same
}
\keyword{methods}

