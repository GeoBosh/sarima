\name{rgarch1p1}
\alias{rgarch1p1}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Simulate GARCH(1,1) models}
\description{

  Simulate GARCH(1,1) models. This function is for internal purposes
  to generate data for examples and testing.

}
\usage{
rgarch1p1(n, alpha, beta, omega, n.skip = 100)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{length of the generated time series.}
  \item{alpha}{alpha parameters in the volatility equation.}
  \item{beta}{beta parameters in the volatility equation.}
  \item{omega}{constant term in the volatility equation.}
  \item{n.skip}{number of additional observation to generate at the
    beginning of the time series.
  }
}
%\details{
%%%  ~~ If necessary, more details than the description above ~~
%}
%\value{
%%%  ~Describe the value returned
%%%  If it is a LIST, use
%%%  \item{comp1 }{Description of 'comp1'}
%%%  \item{comp2 }{Description of 'comp2'}
%%% ...
%}
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
%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
\examples{
x <- rgarch1p1(100, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)
## autocorrelations(x)
## partialAutocorrelations(x)
}
\keyword{internal}
% use one of  RShowDoc("KEYWORDS")
