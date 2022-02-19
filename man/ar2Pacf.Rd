\name{ar2Pacf}
\alias{ar2Pacf}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Convert AR parameters to parcor}
\description{Convert AR parameters to parcor.}
\usage{
ar2Pacf(phi)
}
\arguments{
  \item{phi}{
    numeric, the AR parameters. \code{numeric(0)} stands for AR(0).
  }
}
\details{
  This is internal for now, could be exported under a better name.
}
\value{
  numeric, the parcor coefficients
  (but if \code{length(phi) <= 1}, phi is returned as is)
}
%\references{
%%% ~put references to the literature/web site here ~
%}
%\author{
%%%  ~~who you are~~
%}
%\note{
%%%  ~~further notes~~
%}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
\keyword{internal}
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
