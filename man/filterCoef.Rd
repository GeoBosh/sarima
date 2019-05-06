\name{filterCoef}
\alias{filterCoef}
\alias{filterOrder}
\alias{filterPoly}
\alias{filterPolyCoef}
\title{

  Coefficients and other basic properties of filters

}
\description{

  Coefficients and other basic properties of filters.

}
\usage{
filterCoef(object, convention, \dots)

filterOrder(object, \dots)

filterPoly(object, \dots)

filterPolyCoef(object, lag_0 = TRUE, \dots)
}
\arguments{
  \item{object}{object.}
  \item{convention}{convention for the sign.}
  \item{lag_0}{if FALSE, drop the coefficient of order zero.}
  \item{\dots}{further arguments for methods.}
}
\details{

  Generic functions to extract basic properties of filters:
  \code{filterCoef} returns coefficients,
  \code{filterOrder} returns the order,
  \code{filterPoly}, returns the characteristic polynomial,
  \code{filterPolyCoef} gives the coefficients of the characteristic
  polynomial.

  For further details on argument \code{convention} see 
  \code{\link{filterCoef-methods}}.

  What exactly is returned depends on the specific filter classes, see
  the description of the corresponding methods. For the core filters,
  the values are as can be expected. For "ArmaFilter", the value is a
  list with components "ar" and "ma" giving the requested property for the
  corresponding part of the filter. Similarly, for "SarimaFilter" the
  values are lists, maybe with additional quantities.
}
\value{
  the requested property as described in Details.
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
\note{
  The \code{filterXXX()} functions are somewhat low level and
  technical. They should be rarely needed in routine work.
  The corresponding \code{modelXXX} are more flexible.
}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  \code{\link{modelOrder}},
  \code{\link{modelCoef}},
  \code{\link{modelPoly}},
  \code{\link{modelPolyCoef}},
  for the recommended higher level alternatives for models.

  \code{\link{filterOrder-methods}},
  \code{\link{filterCoef-methods}},
  \code{\link{filterPoly-methods}},
  \code{\link{filterPolyCoef-methods}},
  for more information on the methods and the arguments.
}
\examples{
filterPoly(as(c(0.3, 0.5), "BJFilter"))   # 1 - 0.3*x - 0.5*x^2
filterPoly(as(c(0.3, 0.5), "SPFilter"))   # 1 + 0.3*x + 0.5*x^2

## now two representations of the same filter:
fi1 <- as(c(0.3, 0.5), "BJFilter")
fi2 <- as(c(-0.3, -0.5), "SPFilter")
identical(fi2, fi1) # FALSE, but
## fi1 and fi2 represent the same filter, eg. same ch. polynomials:
filterPoly(fi1)
filterPoly(fi2)
identical(filterPolyCoef(fi2), filterPolyCoef(fi1))

# same as above, using new()
fi1a <- new("BJFilter", coef = c(0.3, 0.5))
identical(fi1a, fi1) # TRUE

fi2a <- new("SPFilter", coef = c(-0.3, -0.5))
identical(fi2a, fi2) # TRUE

## conversion by as() changes the internal representation
## but represents the same filter:
identical(as(fi1, "SPFilter"), fi2) # TRUE

c(filterOrder(fi1), filterOrder(fi2))

## these give the internally stored coefficients:
filterCoef(fi1)
filterCoef(fi2)

## with argument 'convention' the result doesn't depend
## on the internal representation:
co1 <- filterCoef(fi1, convention = "SP")
co2 <- filterCoef(fi2, convention = "SP")
identical(co1, co2) # TRUE
}
\keyword{ts}
