\name{SarimaModel-class}
\Rdversion{1.1}
\docType{class}
\alias{SarimaModel-class}
% \alias{modelCoef,SarimaModel,ArFilter-method}
% \alias{modelCoef,SarimaModel,ArmaFilter-method}
% \alias{modelCoef,SarimaModel,character-method}
% \alias{modelCoef,SarimaModel,MaFilter-method}
% \alias{modelCoef,SarimaModel,missing-method}
% \alias{modelCoef,SarimaModel,SarimaFilter-method}
% \alias{modelOrder,SarimaModel,ArFilter-method}
% \alias{modelOrder,SarimaModel,ArmaFilter-method}
% \alias{modelOrder,SarimaModel,ArmaModel-method}
% \alias{modelOrder,SarimaModel,ArModel-method}
% \alias{modelOrder,SarimaModel,MaFilter-method}
% \alias{modelOrder,SarimaModel,MaModel-method}
% \alias{modelOrder,SarimaModel,missing-method}
% \alias{modelPolyCoef,SarimaModel,ArmaFilter-method}
% \alias{modelPolyCoef,SarimaModel,missing-method}
% \alias{modelPoly,SarimaModel,ArmaFilter-method}
% \alias{modelPoly,SarimaModel,missing-method}

\title{Class SarimaModel in package sarima}
\description{Class SarimaModel in package sarima.}
\section{Objects from the Class}{

  Class \code{"SarimaModel"} represents standard SARIMA models.  Objects
  can be created by calls of the form
  \code{new("SarimaModel", ..., ar, ma, sar, sma)},
  using named arguments in the form \code{slotname = value}, where
  \code{slotname} is one of the slots, see below.  The arguments have
  natural defaults. It may be somewhat surprising though that the
  default for the variance of the innovations (slot \code{"sigma2"}) is
  \code{NA}. The rationale for this choice is that for some calculations
  the innovations' variance is not needed and, more importantly, it is
  far too easy to forget to include it in the model (at least for the
  author) when the variance matters. The latter may may lead silently to
  wrong results if the "natural" default value of one is used when
  \code{sigma2} matters.

  The models may be specified in intercept (\code{center = 0}) or
  mean-corrected (\code{intercept = 0}) form. Setting both to non-zero
  values is accepted but rarely needed.

  If you waih to modify an existing object from class
  \code{"SarimaModel"}, give it as an unnamed argument to \code{"new"}
  and specify only the slots to be changed, see the examples.

  Use \code{\link{as.SarimaModel}} to convert a model fitted with
  \code{stats::arima()} to \code{"SarimaModel"}. 
  
}
\section{Slots}{
  \describe{
    \item{\code{center}:}{Object of class \code{"numeric"},
      a number, the ARIMA equation is for \code{X(t) - center}.

    }
    \item{\code{intercept}:}{Object of class \code{"numeric"},
      a number, the intercept in the ARIMA equation.

    }
    \item{\code{sigma2}:}{Object of class \code{"numeric"},
      a positive number, the innovations variance.

    }
    \item{\code{nseasons}:}{Object of class \code{"numeric"},
      a positive integer, the number of seasons. For non-seasonal models
      this is NA.

    }
    \item{\code{iorder}:}{Object of class \code{"numeric"},
      non-negative integer, the integration order.

    }
    \item{\code{siorder}:}{Object of class \code{"numeric"},
      non-negative integer, the seasonal integration order.

    }
    \item{\code{ar}:}{Object of class \code{"BJFilter"},
      the non-seasonal AR part of the model.

    }
    \item{\code{ma}:}{Object of class \code{"SPFilter"},
      the non-seasonal MA part of the model.

    }
    \item{\code{sar}:}{Object of class \code{"BJFilter"},
      the seasonal AR part of the model.
    }

    \item{\code{sma}:}{Object of class \code{"SPFilter"},
      the seasonal MA part of the model.
    }
  }
}
\section{Extends}{
Class \code{"\linkS4class{VirtualFilterModel}"}, directly.
Class \code{"\linkS4class{SarimaSpec}"}, directly.
Class \code{"\linkS4class{SarimaFilter}"}, by class "SarimaSpec", distance 2.
Class \code{"\linkS4class{VirtualSarimaFilter}"}, by class "SarimaSpec", distance 3.
Class \code{"\linkS4class{VirtualCascadeFilter}"}, by class "SarimaSpec", distance 4.
Class \code{"\linkS4class{VirtualMonicFilter}"}, by class "SarimaSpec", distance 5.
}
\section{Methods}{

  SARIMA models contain as special cases a number of models.
  The one-argument method of \code{modelCoef} is essentially a
  definition of model coefficients for SARIMA models. The two-argument
  methods request the model coefficients according to the convention of
  the class of the second argument. The second argument may also be a
  character string naming the target class.

  Essentially, the methods for \code{modelCoef} are a generalisation of
  \code{as()} methods and can be interpreted as such (to an extent, the
  result is not necessarilly from the target class, not least because
  the target class may be virtual).

  \describe{
    \item{modelCoef}{\code{signature(object = "SarimaModel", convention = "missing")}:
      Converts \code{object} to "SarimaFilter".

    }
    \item{modelCoef}{\code{signature(object = "SarimaModel", convention = "SarimaFilter")}:
      Converts \code{object} to "SarimaFilter", equivalent to the
      one-argument call \code{modelCoef(object)}.

    }

    \item{modelCoef}{\code{signature(object = "SarimaModel", convention	= "ArFilter")}:
      Convert \code{object} to "ArFilter". An error is raised if
      \code{object} has non-trivial moving average part.

    }
    \item{modelCoef}{\code{signature(object = "SarimaModel", convention	= "MaFilter")}:
      Convert \code{object} to "MaFilter". An error is raised if
      \code{object} has non-trivial autoregressive part.

    }
    \item{modelCoef}{\code{signature(object = "SarimaModel", convention	= "ArmaFilter")}:
      Convert \code{object} to "ArmaFilter". This operation always successeds.

    }
    \item{modelCoef}{\code{signature(object = "SarimaModel", convention	= "character")}:
      The second argument gives the name of the target class.
      This is conceptually equivalent to \code{modelCoef(object, new(convention))}.

    }
  }

  \code{modelOrder} gives the order of the model according to the
  conventions of the target class. An error is raised if \code{object}
  is not compatible with the target class.

  \describe{
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "ArFilter")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "ArmaFilter")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "ArmaModel")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "ArModel")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "MaFilter")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "MaModel")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "missing")}: ... }
  }

  The polynomials associated with \code{object} can be obtained with the
  following methods. Note that target "ArmaFilter" gives the fully
  expanded products of the AR and MA polynomials, as needed, e.g., for
  filtering.

  \describe{
    \item{modelPoly}{\code{signature(object = "SarimaModel", convention = "ArmaFilter")}:
`      Gives the fully expanded polynomials as a list

    }
    \item{modelPoly}{\code{signature(object = "SarimaModel", convention = "missing")}:
      Gives the polynomials associated with the model as a list.

    }

    \item{modelPolyCoef}{\code{signature(object = "SarimaModel", convention = "ArmaFilter")}:
      Give the coefficients of the fully expanded polynomials as a list.
    }
    \item{modelPolyCoef}{\code{signature(object = "SarimaModel", convention = "missing")}:
      Gives the coefficients of the polynomials associated with the model as a list.

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
  \code{\linkS4class{ArmaModel}}
}
\examples{
ar1 <- new("SarimaModel", ar = 0.9)
ar1c <- new("SarimaModel", ar = 0.9, intercept = 3)
ar1c
ar1m <- new("SarimaModel", ar = 0.9, center = 1)
ar1m

sm0 <- new("SarimaModel", nseasons = 12)
sm1 <- new("SarimaModel", nseasons = 12, intercept = 3)
sm1
## alternatively, pass a model and modify with named arguments
sm1b <- new("SarimaModel", sm0, intercept = 3)
identical(sm1, sm1b) # TRUE

## in the above models sigma2 is NA

## sm2 - from scratch, the rest modefy an existing model
sm2  <- new("SarimaModel", ar = 0.9, nseasons = 12, intercept = 3, sigma2 = 1)
sm2a <- new("SarimaModel", sm0, ar = 0.9, intercept = 3, sigma2 = 1)
sm2b <- new("SarimaModel", sm1, ar = 0.9, sigma2 = 1)
sm2c <- new("SarimaModel", ar1c, nseasons =12, sigma2 = 1)
identical(sm2, sm2a) # TRUE
identical(sm2, sm2b) # TRUE
identical(sm2, sm2c) # TRUE

sm3 <- new("SarimaModel", ar = 0.9, sar = 0.8, nseasons = 12, intercept = 3,
           sigma2 = 1)
sm3b <- new("SarimaModel", sm2, sar = 0.8)
identical(sm3, sm3b) # TRUE

## The classic 'airline model' (from examples for AirPassengers)
(fit <- arima(log10(AirPassengers), c(0, 1, 1),
              seasonal = list(order = c(0, 1, 1), period = 12)))

as.SarimaModel(fit)
}
\keyword{classes}
\keyword{ts}
\keyword{sarima}

