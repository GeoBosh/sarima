\name{se}
\alias{se}
\title{Compute standard errors}
\description{Compute standard errors.}
\usage{
se(object, ...)
}
\arguments{
  \item{object}{
    an object containing estimates, such as a fitted model.
  }
  \item{\dots}{
    further arguments for \code{vcov}.
  }
}
\details{
  This is a convenience function for the typical case where only the
  square root of the diagonal of the variance-covariance matrix is
  needed.
}
\value{
  a numeric vector giving standard errors.
}
\seealso{
  \code{\link{vcov}}
}
%\examples{
%}
\keyword{htest}
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.


