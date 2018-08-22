\name{nSeasons}
\docType{methods}
\alias{nSeasons}
\alias{nSeasons-methods}
\alias{nSeasons,SarimaFilter-method}
\alias{nSeasons,VirtualArmaFilter-method}
\title{Number of seasons}
\description{Number of seasons.}
\usage{
nSeasons(object)
}
\arguments{
  \item{object}{
    an object for which the notion of number of seasons makes sense.
  }
}
\details{

  This is a generic function.

}
\value{
  an integer number
}
\author{Georgi N. Boshnakov}
\section{Methods}{
\describe{

\item{\code{signature(object = "SarimaFilter")}}{{
%%  ~~describe this method here~~
}
}\item{\code{signature(object = "VirtualArmaFilter")}}{{
%%  ~~describe this method here~~
}
}}}
%\examples{
%ap <- pcts(AirPassengers)
%nSeasons(ap)
%}
\keyword{methods}
\keyword{ts}
