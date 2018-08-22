\name{ArmaModel-class}
\Rdversion{1.1}
\docType{class}
\alias{ArmaModel-class}
\alias{ArModel-class}
\alias{MaModel-class}

% \alias{modelOrder,ArmaModel,ArFilter-method}
% \alias{modelOrder,ArmaModel,MaFilter-method}
% \alias{modelOrder,ArmaModel,missing-method}
% \alias{modelOrder,SarimaModel,ArmaModel-method}
% \alias{sigmaSq,ArmaModel-method}

\title{Classes ArmaModel, ArModel and MaModel in package sarima}
\description{Classes ArmaModel, ArModel and MaModel in package sarima.}
\section{Objects from the Class}{

  Classes \code{"ArModel"} and \code{"MaModel"} are subclasses of
  \code{"ArmaModel"} with the corresponding order always zero.
  
  The recommended way to create objects from these classes is with the
  functions \code{\link{ArmaModel}}, \code{\link{ArModel}} and
  \code{\link{MaModel}}. Objects can also be created by calls of the
  form \code{new("ArmaModel", ..., ar, ma, mean, check)}.  See also
  \code{\link{coerce-methods}} for further ways to create objects from
  these classes.

%%  ~~ describe objects here ~~
}
\section{Slots}{
  \describe{
    \item{\code{center}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{intercept}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{sigma2}:}{Object of class \code{"numeric"} ~~ }
    \item{\code{ar}:}{Object of class \code{"BJFilter"} ~~ }
    \item{\code{ma}:}{Object of class \code{"SPFilter"} ~~ }
  }
}
\section{Extends}{
Class \code{"\linkS4class{ArmaSpec}"}, directly.
Class \code{"\linkS4class{VirtualArmaModel}"}, directly.
Class \code{"\linkS4class{ArmaFilter}"}, by class "ArmaSpec", distance 2.
Class \code{"\linkS4class{VirtualFilterModel}"}, by class "VirtualArmaModel", distance 2.
Class \code{"\linkS4class{VirtualStationaryModel}"}, by class "VirtualArmaModel", distance 2.
Class \code{"\linkS4class{VirtualArmaFilter}"}, by class "ArmaSpec", distance 3.
Class \code{"\linkS4class{VirtualAutocovarianceModel}"}, by class "VirtualArmaModel", distance 3.
Class \code{"\linkS4class{VirtualMeanModel}"}, by class "VirtualArmaModel", distance 3.
Class \code{"\linkS4class{VirtualMonicFilter}"}, by class "ArmaSpec", distance 4.
}
\section{Methods}{
  \describe{
    \item{modelOrder}{\code{signature(object = "ArmaModel", convention = "ArFilter")}: ... }
    \item{modelOrder}{\code{signature(object = "ArmaModel", convention = "MaFilter")}: ... }
    \item{modelOrder}{\code{signature(object = "ArmaModel", convention = "missing")}: ... }
    \item{modelOrder}{\code{signature(object = "SarimaModel", convention = "ArmaModel")}: ... }
    \item{sigmaSq}{\code{signature(object = "ArmaModel")}: ... }
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
  \code{\link{ArmaModel}}, \code{\link{ArModel}}, \code{\link{MaModel}}, 
  \code{\link{coerce-methods}}
}
\examples{
arma1p1 <- new("ArmaModel", ar = 0.5, ma = 0.9, sigma2 = 1)
autocovariances(arma1p1, maxlag = 10)
autocorrelations(arma1p1, maxlag = 10)
partialAutocorrelations(arma1p1, maxlag = 10)
partialAutocovariances(arma1p1, maxlag = 10)

new("ArmaModel", ar = 0.5, ma = 0.9, intercept = 4)
new("ArmaModel", ar = 0.5, ma = 0.9, center = 1.23)

new("ArModel", ar = 0.5,  center = 1.23)
new("MaModel", ma = 0.9,  center = 1.23)

# argument 'mean' is an alias for 'center':
new("ArmaModel", ar = 0.5, ma = 0.9, mean = 1.23)

##  both center and intercept may be given
## (the mean is not equal to the intercept in this case)
new("ArmaModel", ar = 0.5, ma = 0.9, center = 1.23, intercept = 2)

## Don't use 'mean' together with 'center' and/or 'intercept'.
##    new("ArmaModel", ar = 0.5, ma = 0.9, center = 1.23, mean  = 4)
##    new("ArmaModel", ar = 0.5, ma = 0.9, intercept = 2, mean  = 4)
## Both give error message:
##   Use argument 'mean' only when 'center' and 'intercept' are missing or zero
}
\keyword{classes}
\keyword{ts}
