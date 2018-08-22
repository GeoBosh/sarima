\name{nvcovOfAcf}
\alias{nvcovOfAcf}
\alias{nvcovOfAcfBD}
\alias{acfOfSquaredArmaModel}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Covariances of sample autocorrelations}
\description{Compute covariances of autocorrelations.}
\usage{
nvcovOfAcf(model, maxlag)

nvcovOfAcfBD(acf, ma, maxlag)

acfOfSquaredArmaModel(model, maxlag)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{a model, see Details.}
  \item{maxlag}{a positive integer number, the maximal lag.}
  \item{acf}{autocorrelations.}
  \item{ma}{a positive integer number, the order of the MA(q) model.}
}
\details{

  \code{nvcovOfAcf} computes the unscaled asymptotic autocovariances of
  sample autocorrelations of ARMA models, under the classical
  assumptions when the Bartlett's formulas are valid.  It works directly
  with the parameters of the model and uses Boshnakov (1996).  Argument
  \code{model} can be any specification of ARMA models for which
  \code{autocorrelations()} will work, e.g. a list with components "ar",
  "ma", and "sigma2".

  \code{nvcovOfAcfBD} computes the same quantities but uses the formula
  given by Brockwell \& Davis (1991) (eq. (7.2.6.), p. 222), which is
  based on the autocorrelations of the model. Argument
  \code{acf} contains the autocorrelations. Currently \code{nvcovOfAcfBD}
  works for MA models only (but specifying a high order MA(q) should be
  fine in typical use).

  \code{acfOfSquaredArmaModel(model, maxlag)} is a convenience function
  which computes the autocovariances of the "squared" model, see
  Boshnakov (1996).

}
\value{
  a matrix
}
\references{
  \insertRef{boshnakov1996aism}{sarima}

  \insertRef{BrockwellDavis1991}{sarima}
}
\author{Georgi N. Boshnakov}
\note{

  Currently the implementation of \code{nvcovOfAcfBD} is limited
  to MA models.

}

%% ~Make other sections like Warning with \section{Warning }{....} ~

%\seealso{
%%% ~~objects to See Also as \code{\link{help}}, ~~~
%}
%\examples{
%##---- Should be DIRECTLY executable !! ----
%}
\keyword{ts}
% use one of  RShowDoc("KEYWORDS")
