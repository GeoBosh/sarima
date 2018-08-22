\name{sigmaSq}
\docType{methods}
\alias{sigmaSq}
\alias{sigmaSq-methods}
\alias{sigmaSq,InterceptSpec-method}
\title{Get the innovation variance of models}
\description{Get the innovation variance of models.}
\usage{
sigmaSq(object)
}
\arguments{
  \item{object}{an object from a suitable class.}
}
\details{

  \code{sigmaSq()} gives the innovation variance of objects from classes
  for which it makes sense, such as ARMA models.

  The value depends on the class of the object, e.g. for ARMA models it
  is a scalar in the univariate case and a matrix in the multivariate one.

}
%\value{
%}
\author{Georgi N. Boshnakov}
\section{Methods}{
\describe{

\item{\code{signature(object = "InterceptSpec")}}{
%%  ~~describe this method here~~
}
}}
\keyword{methods}
\keyword{ts}
