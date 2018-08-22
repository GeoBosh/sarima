\name{ArmaModel}
\alias{ArmaModel}
\alias{ArModel}
\alias{MaModel}
\title{Create ARMA objects}
\description{Create ARMA objects.}
\usage{
ArmaModel(...)
ArModel(...)
MaModel(...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{\dots}{the arguments a reassed to \code{new()}. Typical
    arguments are \code{ar}, \code{ma} and \code{mean}. 
  }
}
%\details{
%  
%}
\value{
  an object representing an ARMA, AR or MA model
}
%\references{
%%% ~put references to the literature/web site here ~
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
  \code{\linkS4class{ArModel}},
  \code{\linkS4class{MaModel}}
}
\examples{
## MA
( ma2a1 <- MaModel(ma = c(0.3, 0.7), sigma2 = 1) )
autocorrelations(ma2a1, maxlag = 6)
partialAutocorrelations(ma2a1, maxlag = 6)
autocovariances(ma2a1, maxlag = 6)
partialVariances(ma2a1, maxlag = 6)

## sigma2 is set to NA if not specified
## but things that don't depend on it are computed:
( ma2a2 <- MaModel(ma = c(0.3, 0.7)) )
autocorrelations(ma2a2, maxlag = 6)
partialAutocorrelations(ma2a2, maxlag = 6)

## AR
( ar2a1 <- ArModel(ar = c(-0.3, -0.7), sigma2 = 1) )
autocorrelations(ar2a1, maxlag = 6)
partialAutocorrelations(ar2a1, maxlag = 6)
autocovariances(ar2a1, maxlag = 6)
partialVariances(ar2a1, maxlag = 6)

## ARMA
( arma2a1 <- ArmaModel(ar = 0.5, ma = c(0.3, 0.7), sigma2 = 1) )
autocorrelations(arma2a1, maxlag = 6)
partialAutocorrelations(arma2a1, maxlag = 6)


## modelCoef() returns a list with components 'ar' and 'ma'
modelCoef(arma2a1)
modelCoef(ma2a1)
modelCoef(ar2a1)

## modelOrder() returns a list with components 'ar' and 'ma'
modelOrder(arma2a1)
modelOrder(ma2a1)
modelOrder(ar2a1)

as(ma2a1, "ArmaModel")  # success, as expected
as(ar2a1, "ArModel")  # success, as expected
as(ArmaModel(ar = c(-0.3, -0.7)), "ArModel")
## But these fail:
## as(ma2a1, "ArModel") # fails
## as(arma2a1, "ArModel") # fails
## as(arma2a1, "MaModel") # fails

}
\keyword{ts}
\keyword{arma}
% use one of  RShowDoc("KEYWORDS")
