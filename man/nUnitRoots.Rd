\name{nUnitRoots}
\docType{methods}
\alias{nUnitRoots}
\alias{nUnitRoots-methods}
\alias{nUnitRoots,SarimaSpec-method}
\alias{nUnitRoots,VirtualStationaryModel-method}
\title{Number of unit roots in a model}
\description{
  Gives the number of roots with modulus one in a model.
}
\usage{
nUnitRoots(object)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{an object.}
}
\details{

  \code{nUnitRoots()} gives the number of roots with modulus one in a
  model. This number is zero for stationary models, see also
  \code{isStationaryModel()}.

%%  ~~ If necessary, more details than the description above ~~
}
\value{
  a non-negative integer number
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
\item{\code{signature(object = "VirtualStationaryModel")}}{{
%%  ~~describe this method here~~
}
}}}

%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%}
\keyword{methods}
\keyword{ts}
