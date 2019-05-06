\name{filterPolyCoef-methods}
\docType{methods}
%\alias{filterPolyCoef}
\alias{filterPolyCoef-methods}
\alias{filterPolyCoef,BJFilter-method}
\alias{filterPolyCoef,SarimaFilter-method}
\alias{filterPolyCoef,SPFilter-method}
\alias{filterPolyCoef,VirtualArmaFilter-method}
\alias{filterPolyCoef,VirtualBJFilter-method}
\alias{filterPolyCoef,VirtualSPFilter-method}
\title{Methods for filterPolyCoef}
\description{
  Methods for \code{filterPolyCoef} in package \pkg{sarima}.
}
% \usage{
% filterPolyCoef(object, lag_0 = TRUE, \dots)
% }
% \arguments{
%   \item{object}{an object.}
%   \item{lag_0}{
%     if \code{TRUE}, the default, include the coefficient of order zero.
%   }
%   \item{...}{further arguments for methods.}
% }
\section{Methods}{

  The \code{filterPolyCoef} methods return results with the same
  structure as the corresponding methods for \code{filterPoly} but with
  polynomials replaced by their coefficients. If \code{lag_0} is
  \code{FALSE} the order 0 coefficients are dropped.
  
\describe{

  \item{\code{signature(object = "VirtualBJFilter")}}{
    Calls \code{filterCoef(object)}, negates the result and prepends 1
    if \code{lag_0} is \code{TRUE}. 
  }

  \item{\code{signature(object = "VirtualSPFilter")}}{
    Calls \code{filterCoef(object)} and prepends 1 to the result if
    \code{lag_0} is \code{TRUE}.
  }

  \item{\code{signature(object = "VirtualArmaFilter")}}{
      Returns a list with the following components:
      \describe{
	\item{ar}{coefficients of the autoregression polynomial.}
	\item{ma}{coefficients of the moving average polynomial.}
      }
  }

  \item{\code{signature(object = "BJFilter")}}{
    The coefficients of a polynomial whose coefficients are the negated
    filter coefficients. This is equivalent to the method for
    "VirtualBJFilter" but somewhat more efficient.
  }

  \item{\code{signature(object = "SPFilter")}}{
    The coefficients of a polynomial whose coefficients are as stored in
    the object. This is equivalent to the method for "VirtualSPFilter"
    but somewhat more efficient.
  }

  \item{\code{signature(object = "SarimaFilter")}}{
    Returns a list with the same components as the "SarimaFilter" method
    for \code{\link{filterPoly}}, where the polynomials are replaced by
    their coefficients. 
  }
}}
\author{Georgi N. Boshnakov}
\seealso{
  \code{\link{filterCoef}} for examples and related functions
}
\examples{
## see the examples for ?filterCoef
}
\keyword{methods}
