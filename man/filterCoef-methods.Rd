\name{filterCoef-methods}
\docType{methods}
\alias{filterCoef-methods}
\alias{filterCoef,BJFilter,character-method}
%\alias{filterCoef,MonicFilterSpec,missing-method}
\alias{filterCoef,SPFilter,character-method}
\alias{filterCoef,VirtualArmaFilter,character-method}
\alias{filterCoef,VirtualArmaFilter,missing-method}
\alias{filterCoef,VirtualBJFilter,character-method}
\alias{filterCoef,VirtualSPFilter,character-method}
\alias{filterCoef,SarimaFilter,missing-method}
\alias{filterCoef,SarimaFilter,character-method}
\alias{filterCoef,VirtualMonicFilterSpec,missing-method}
\title{Methods for filterCoef()}
\description{Methods for \code{filterCoef} in package \pkg{sarima}.}
\section{Methods}{

  \code{filterCoef()} returns the coefficients of \code{object}. The
  format of the result depends on the type of filter, see the
  descriptions of the individual methods below.

  If argument \code{convention} is omitted, the sign convention for the
  coefficients is the one used in the object. \code{convention} can be
  set to "BJ" or "SP" to request, respectively, the Box-Jenkins or the
  signal processing convention. Also, "-" is equivalent to "BJ" and "+"
  to "SP". 

  For ARMA filters, "BJ" and "SP" request the corresponding convention
  for both parts (AR and MA). A widely used convention, e.g., by base R
  and \insertCite{BrockwellDavis1991}{sarima}, is "BJ" for the AR part
  and "SP" for the MA part.  It can be requested with \code{convention =
  "BD"}.  For convenience, "--" is equivalent to "BJ", "++" to "SP",
  "-+" to "BD". For completeness, "+-" can be used to request "SP" for
  the AR part and "BJ" for the MA part.

  Invalid values of \code{convention} throw error. In particular, low
  level filters, such as "BJFilter" don't know if they are AR or MA, so
  they throw error if \code{convention} is "BD" or "+-" (but "++" and
  "--" are ok, since they are unambiguous). Similarly and to avoid
  subtle errors, the ARMA filters do not accept "+" or "-".
  
  \describe{

    \item{\code{signature(object = "VirtualMonicFilterSpec", convention = "missing")}}{
      returns  \code{object@coef}.
    }
  
    \item{\code{signature(object = "VirtualBJFilter", convention = "character")}}{
      returns the filter coefficients in the requested convention.
    }

    \item{\code{signature(object = "VirtualSPFilter", convention = "character")}}{
      returns the filter coefficients in the requested convention.
    }
  
    \item{\code{signature(object = "BJFilter", convention = "character")}}{
      returns the filter coefficients in the requested convention.
    }

    \item{\code{signature(object = "SPFilter", convention = "character")}}{
      returns the filter coefficients in the requested convention.
    }

    \item{\code{signature(object = "VirtualArmaFilter", convention = "missing")}}{}
    \item{\code{signature(object = "VirtualArmaFilter", convention = "character")}}{
      Conceptually, calls \code{filterCoef()}, with one argument, on the
      AR and MA parts of the model. If \code{convention} is present,
      converts the result to the specified convention.  Returns a list
      with the following components:
      \describe{
	\item{ar}{AR coefficients.}
	\item{ma}{MA coefficients.}
      }
    }

    \item{\code{signature(object = "SarimaFilter", convention = "missing")}}{}
    \item{\code{signature(object = "SarimaFilter", convention = "character")}}{
      If \code{convention} is present, converts the coefficients to the
      specified convention. AR-like coefficients get the convention for
      the AR part, Ma-like coefficients get the convention for the MA
      part. Returns a list with the following components:
      \describe{
	\item{nseasons}{number of seasons.}
	\item{iorder}{integration order, number of (non-seasonal)
	  differences.} 
	\item{siorder}{seasonal integration order, number of seasonal
	  differences.}
	
	\item{ar}{ar coefficients.}
	\item{ma}{ma coefficients.}
	\item{sar}{seasonal ar coefficients.}
	\item{sma}{seasonal ma coefficients.}
      }
    }
  }
}
\author{Georgi N. Boshnakov}
\references{
  \insertAllCited{}
}
\seealso{
  \code{\link{filterCoef}} for examples and related functions
}
\examples{
## see the examples for ?filterCoef
}
\keyword{methods}
