\name{se}
\alias{se}
\alias{vcov}
\alias{vcov,SampleAutocorrelations-method}
\title{Compute standard errors}
\description{Compute standard errors.}
\usage{
se(object, \dots)

\S4method{vcov}{SampleAutocorrelations}(object, assuming = "iid", maxlag = maxLag(object), \dots)
}
\arguments{
  \item{object}{
    an object containing estimates, such as a fitted model.
  }
  \item{\dots}{
    further arguments for \code{vcov}.
  }
  \item{assuming}{

    under what assumptions to do the computations?
    Currently can be \code{"iid"}, \code{"garch"}, a fitted model, or a
    theoretical model, see Details.

  }
  \item{maxlag}{maximal lag to include}
}
\details{
  \code{se} is a convenience function for the typical case where only the
  square root of the diagonal of the variance-covariance matrix is
  needed.

  The method for \code{vcov} gives the variance-covariance matrix of the
  first \code{maxlag} autocorrelation coefficients in the object. The
  result depends on the underlying assumptions and the method of
  calculation. These can be specifyed with the additional arguments.

  Argument \code{"assuming"} can be though also as specifying a null
  hypothesis. Setting it to \code{"iid"} or \code{"garch"} corresponds
  to strong white noise (iid) and weak white noise, respectively. 

  Setting \code{"assuming"} to an ARMA model (theoretical or fitted)
  specifies that as the null model. 

  \bold{Note:} The method for \code{vcov} is not finalised yet. It is
  used by a method for \code{\link{confint}}.  Bug
  reports and requests on the github repo may bring this closer to the
  top of my task list.
  
}
\value{
  for \code{se}, a numeric vector giving standard errors;

  for the \code{vcov} method, a square matrix
}
\seealso{
  \code{link{confint}},
  \code{\link[stats]{vcov}}
}
%\examples{
%}
\keyword{htest}
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.


