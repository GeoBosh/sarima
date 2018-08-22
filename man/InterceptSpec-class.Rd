\name{InterceptSpec-class}
\Rdversion{1.1}
\docType{class}
\alias{InterceptSpec-class}
%\alias{sigmaSq,InterceptSpec-method}

\title{Class InterceptSpec}
\description{

  A helper class from which a number of models inherit intercept,
  centering and innovations variance.

}
\section{Objects from the Class}{
Objects can be created by calls of the form \code{new("InterceptSpec", ...)}.
%%  ~~ describe objects here ~~
}
\section{Slots}{
  \describe{
    \item{\code{center}:}{Object of class \code{"numeric"},
      centering parameter, defaults to zero.
    }
    \item{\code{intercept}:}{Object of class \code{"numeric"},
      intercept parameter, defaults to zero.
    }
    \item{\code{sigma2}:}{Object of class \code{"numeric"},
      innovations variance, defaults to NA.
    }
  }
}
\section{Methods}{
  \describe{
    \item{sigmaSq}{\code{signature(object = "InterceptSpec")}: ... }
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
  \code{\linkS4class{ArmaModel}},
  \code{\linkS4class{SarimaModel}}
}
\examples{
showClass("InterceptSpec")
}
\keyword{classes}
