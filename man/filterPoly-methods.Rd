\name{filterPoly-methods}
\docType{methods}
\alias{filterPoly-methods}
\alias{filterPoly,BJFilter-method}
\alias{filterPoly,SarimaFilter-method}
\alias{filterPoly,SPFilter-method}
\alias{filterPoly,VirtualArmaFilter-method}
\alias{filterPoly,VirtualMonicFilterSpec-method}
\title{Methods for \code{filterPoly} in package \pkg{sarima}}
\description{Methods for \code{filterPoly} in package \pkg{sarima}.}
\section{Methods}{

  The methods for \code{filterPoly} take care implicitly for the sign
  convention used to store the coefficients in the object.
  
  \describe{

    \item{\code{signature(object = "BJFilter")}}{
      A polynomial whose coefficients are the negated filter
      coefficients.
    }

    \item{\code{signature(object = "SPFilter")}}{
      A polynomial whose coefficients are as stored in the object.
    }

    \item{\code{signature(object = "SarimaFilter")}}{
      Returns a list with the following components:
      \describe{
	\item{nseasons}{number of seasons.}
	\item{iorder}{integration order, number of (non-seasonal)
	  differences.} 
	\item{siorder}{seasonal integration order, number of seasonal
	  differences.}
	
	\item{arpoly}{autoregression polynomial}
	\item{mapoly}{moving average polynomial}
	\item{sarpoly}{seasonal autoregression polynomial}
	\item{smapoly}{seasonal moving average polynomial}

	\item{fullarpoly}{the polynomial obtained by multiplying out all
	  AR-like terms, including differences.}
	\item{fullmapoly}{the polynomial obtained by multiplying out all
	  MA terms}

	\item{core_sarpoly}{core seasonal autoregression polynomial. It
	  is such that sarpoly(\eqn{z}) = core_sarpoly(\eqn{z^{nseasons}})}
      
	\item{core_smapoly}{core seasonal moving average polynomial. It
	  is such that smapoly(\eqn{z}) = core_smapoly(\eqn{z^{nseasons}})}
      }
    }
    
    \item{\code{signature(object = "VirtualArmaFilter")}}{
      Returns a list with the following components:
      \describe{
	\item{ar}{autoregression polynomial.}
	\item{ma}{moving average polynomial.}
      }
    }
    
    \item{\code{signature(object = "VirtualMonicFilterSpec")}}{
      Calls \code{filterPolyCoef(object)} and converts the result to a
      polynomial. Thus, it is sufficient to have a method for
      \code{filterPolyCoef()}. 
    }
  }
}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{filterCoef}} for examples and related functions
}
\examples{
## see the examples for ?filterCoef
}
\keyword{methods}
