\name{isStationaryModel}
\docType{methods}
\alias{isStationaryModel}
\alias{isStationaryModel-methods}
\alias{isStationaryModel,SarimaSpec-method}
\alias{isStationaryModel,VirtualIntegratedModel-method}
\alias{isStationaryModel,VirtualStationaryModel-method}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Check if a model is stationary}
\description{Check if a model is stationary.}
\usage{
isStationaryModel(object)
}
\arguments{
  \item{object}{an object}
}
\details{

  This is a generic function.
  It returns \code{TRUE} if \code{object} represents a stationary model
  and FALSE otherwise.

}
\value{
  TRUE or FALSE
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~
\section{Methods}{
\describe{

\item{\code{signature(object = "SarimaSpec")}}{
%%  ~~describe this method here~~
}

\item{\code{signature(object = "VirtualIntegratedModel")}}{
%%  ~~describe this method here~~
}
\item{\code{signature(object = "VirtualStationaryModel")}}{{
%%  ~~describe this method here~~
}
}}}

\seealso{
  \code{\link{nUnitRoots}}
}
%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{methods}
