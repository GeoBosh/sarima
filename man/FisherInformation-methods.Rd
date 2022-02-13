\name{FisherInformation-methods}
\docType{methods}

\alias{FisherInformation-methods}
\alias{FisherInformation}
\alias{FisherInformation.Arima}
\alias{FisherInformation,ANY-method}
\alias{FisherInformation,SarimaModel-method}
\alias{FisherInformation,ArmaModel-method}

\title{Fisher information}
\description{

  Compute the Fisher information for the parameters of a model.

}
\usage{
FisherInformation(model, ...)

\S3method{FisherInformation}{Arima}(model, ...)
}
\arguments{
  \item{model}{
    a fitted or theoretical model for which a method is available.
  }
  \item{\dots}{further arguments for methods.}
}
\details{

  \code{FisherInformation} computes the information matrix for the
  parameters of \code{model}. This is a generic function. The methods
  for objects from S4 classes are listed in section \sQuote{Methods}.

  Currently package \pkg{sarima} defines methods for objects
  representing fitted or theoretical ARMA and seasonal ARMA models.
  For integrated models the result should be interpreted as the
  information matrix after differencing.

  For ARMA models the implementation is based on
  \insertCite{Friedlander1984CramerRaoArma}{sarima} and (for the seasonal
  specifics) \insertCite{Godolphin2007Sarma}{sarima}.

}
\value{
  a square matrix with attribute \code{"nseasons"}
}
\references{
  \insertAllCited{}
}
\author{Georgi Boshnakov}
\section{Methods}{
  This section lists \code{FisherInformation} methods for S4
  classes. 
\describe{

\item{\code{signature(model = "ANY")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(model = "SarimaModel")}}{
%%  ~~describe this method here~~
}
\item{\code{signature(model = "ArmaModel")}}{{
%%  ~~describe this method here~~
}
}}}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
## a fitted model (over-parameterised)
seas_spec <- list(order = c(1,0,1), period = 4)
fitted <- arima(rnorm(100), order = c(1,0,1), seasonal = seas_spec)
(fi <- FisherInformation(fitted))
## asymptotic covariance matrix of the ARMA parameters:
fitted$sigma2 * solve(fi) / 100

## a theoretical seasonal ARMA model:
sarima1 <- new("SarimaModel", ar = 0.9, ma = 0.1, sar = 0.5, sma = 0.9, nseasons = 12)
FisherInformation(sarima1)

## a non-seasonal ARMA model:
arma2a1 <- ArmaModel(ar = 0.5, ma = c(0.3, 0.7), sigma2 = 1)
FisherInformation(arma2a1)
## sigma2 is not needed for the information matrix:
arma2a1a <- ArmaModel(ar = 0.5, ma = c(0.3, 0.7))
FisherInformation(arma2a1a) # same as above
}
\keyword{methods}
\keyword{ts}
\keyword{htest}
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.

