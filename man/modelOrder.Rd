\name{modelOrder}
\alias{modelOrder}
\alias{modelPoly}
\alias{modelPolyCoef}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Get the model order and other properties of models}
\description{Get the model order and other properties of models.}
\usage{
modelOrder(object, convention, \dots)

modelPoly(object, convention, \dots)

modelPolyCoef(object, convention, lag_0 = TRUE, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{a model object.}
  \item{convention}{convention.}
  \item{lag_0}{if TRUE include lag_0 coef, otherwise drop it.}
  \item{\dots}{further arguments for methods.}
}
\details{

  These functions return the requested quantity, optionally requesting
  the returned value to follow a specific convention, see also
  \code{\link{modelCoef}}.

  When called with one argument, these functions return corresponding
  property in the native format for the object's class.

  Argument \code{convention} requests the result in some other
  format. The mental model is that the returned value is as if the
  object was first converted to the class specified by \code{convention}
  and then the property extracted or computed. Normally, the object is
  not actually converted to that class. one obvious reason is efficiency
  but it may also not be possible, for example if argument
  \code{convention} is the name of a virtual class.

  For example, the order of a seasonal SARIMA model is specified by
  several numbers. The call \code{modelOrder(object)} returns it as a
  list with components ar, ma, sar, sma, iorder, siorder and nseasons.
  For some computations all that is needed are the overall AR and MA
  orders obtained by multiplying out the AR-like and MA-like terms in
  the model.
  The result would be an ARMA filter and could be requested  by
  \code{modelOrder(object, "ArmaFilter")}.

  The above operation is valid for any ARIMA model, so will always
  succeed.  On the other hand, if further computation would work only if
  there are no moving average terms in the model one could use
  \code{modelOrder(object, "ArFilter")}. Here, if \code{object} contains
  MA terms an error will be raised.

  The concept is powerful and helps in writing expressive code.
  In this example a simple check on the returned value would do but even
  so, such a check may require additional care.

}
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

%\author{
%%%  ~~who you are~~
%}
%\note{
%%%  ~~further notes~~
%}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  \code{\link{modelCoef}}
}
\examples{
m1 <- new("SarimaModel", iorder = 1, siorder = 1, ma = -0.3, sma = -0.1, nseasons = 12)
modelOrder(m1)
modelOrder(m1, "ArmaFilter")
modelOrder(m1, new("ArmaFilter"))

modelPoly(m1, "ArmaModel")
modelPolyCoef(m1, "ArmaModel")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ts}
% use one of  RShowDoc("KEYWORDS")
