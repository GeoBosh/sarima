\name{sarima-package}
\alias{sarima-package}
\docType{package}
\title{Package sarima
  \Sexpr[stage=build,results=hide]{pd <- packageDescription("sarima")}
  \Sexpr[stage=build,results=hide]{lb <- library(help="sarima", character.only=TRUE)}
  \Sexpr[stage=build]{pd$Title}
}
\description{
  \Sexpr[stage=build]{pd$Description}
}
\details{
   \tabular{ll}{
   Package:  \tab \Sexpr[stage=build]{pd$Package}\cr
   Type:     \tab \Sexpr[stage=build]{pd$Type}\cr
   Version:  \tab \Sexpr[stage=build]{pd$Version} \cr
   Date:     \tab \Sexpr[stage=build]{pd$Date}\cr
   License:  \tab \Sexpr[stage=build]{pd$License}\cr
   LazyLoad: \tab \Sexpr[stage=build]{pd$LazyLoad}\cr
   Built:    \tab \Sexpr[stage=build]{pd$Built}\cr
   }

% Commenting out for now.
%    Index:
%   \Sexpr[stage=build,results=rd]{paste("\\\\preformatted{", paste(if(!is.null(lb$info[[2]])) lb$info[[2]] else "No entries",collapse="\n"), "}", sep="")}

There is a large number of packages for time series modelling. They provide a huge number of
functions, often with similar or overlapping functionality and different argument
conventions. One of the aims of package \pkg{sarima} is to provide consistent interface to
some frequently used functionality.

In package \pkg{sarima} a consistent naming scheme is used as much as
possible. Names of functions start with a lowercase letter and consist
of whole words, acronyms or commonly used abbreviations. In multiword
names, the second and subsequent words start with capital letters
(camelCase).  Only the first letter in acronyms is capitalised,
e.g. Arma stands for ARMA.  Formal (S4) classes follow the same rules
but the first letter of the first word is capitalised, as well.

For example, the functions that compute autocorrelations,
autocovariances, partial autocorrelations are called
\code{autocorrelations}, \code{autocovariances}, and
\code{partialAutocorrelations}, respectively. Moreover, they recognise
from their argument(s) what exactly is needed. If they are given times
series, they compute sample autocorrelations, etc; if they are given
model specifications, they compute the corresponding theoretical
properties.

This is work in progress, see also the vignette(s).
% e.g. \url{../doc/white_noise_tests.pdf}.



}
\author{
  \Sexpr[stage=build]{pd$Author}

Maintainer: \Sexpr[stage=build]{pd$Maintainer}
}
\references{
  \insertRef{boshnakov1996aism}{sarima}

  \insertRef{BrockwellDavis1991}{sarima}

  \insertRef{FrancqZakoian2010garch}{sarima}

  \insertRef{Li2004diagnostic}{sarima}

  \insertRef{McLeodYuKrougly2007}{sarima}

}
\seealso{
  \code{\link{ArmaModel}}
  \code{\link{autocorrelations}}
}
\examples{
## simulate a white noise ts (model from Francq & Zakoian)
n <- 5000
x <- sarima:::rgarch1p1(n, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)

## acf and pacf
( x.acf <- autocorrelations(x) )
( x.pacf <- partialAutocorrelations(x) )

## portmanteau test for iid, by default gives also ci's for the acf under H0
x.iid <- whiteNoiseTest(x.acf, h0 = "iid", nlags = c(5,10,20), x = x, method = "LiMcLeod")
x.iid

x.iid2 <- whiteNoiseTest(x.acf, h0 = "iid", nlags = c(5,10,20), x = x, method = "LjungBox")
x.iid2

## portmanteau test for garch H0
x.garch <- whiteNoiseTest(x.acf, h0 = "garch", nlags = c(5,10,20), x = x)
x.garch

## plot methods give the CI's under H0
plot(x.acf)

## if the data are given, the CI's under garch H0 are also given.
plot(x.acf, data = x)

## Tests based on partial autocorrelations are also available:
plot(x.pacf)
plot(x.pacf, data = x)

## Models
## AR
( ar2a1 <- ArModel(ar = c(-0.3, -0.7), sigma2 = 1) )
autocorrelations(ar2a1, maxlag = 6)
partialAutocorrelations(ar2a1, maxlag = 6)
autocovariances(ar2a1, maxlag = 6)
partialVariances(ar2a1, maxlag = 6)

## see examples for ArmaModel()
}
\keyword{package}
\keyword{ts}
% use one of  RShowDoc("KEYWORDS")
