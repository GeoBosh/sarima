\name{filterOrder-methods}
\docType{methods}
\alias{filterOrder-methods}
\alias{filterOrder,SarimaFilter-method}
\alias{filterOrder,VirtualArmaFilter-method}
\alias{filterOrder,VirtualMonicFilterSpec-method}
\title{Methods for function \code{filterOrder} in package \pkg{sarima}}
\description{
    Methods for function \code{filterOrder} in package \pkg{sarima}.
}
\section{Methods}{
  The following methods ensure that  all filters in package \pkg{sarima}
  have a method for \code{filterOrder}.
\describe{

  \item{\code{signature(object = "VirtualMonicFilterSpec")}}{
    Returns \code{object@order}.
  }

  \item{\code{signature(object = "SarimaFilter")}}{
    Returns a list with the following components:
    \describe{
      \item{nseasons}{number of seasons.}
      \item{iorder}{integration order, number of (non-seasonal) differences.}
      \item{siorder}{seasonal integration order, number of seasonal
	differences.}
      \item{ar}{autoregression order}
      \item{ma}{moving average order}
      \item{sar}{seasonal autoregression order}
      \item{sma}{seasonal moving average order}
    }
  }

  \item{\code{signature(object = "VirtualArmaFilter")}}{
      Returns a list with the following components:
      \describe{
	\item{ar}{autoregression order.}
	\item{ma}{moving average order.}
      }
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

