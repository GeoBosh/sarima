\name{acfIidTest}
\docType{methods}
\alias{acfIidTest}
\alias{acfIidTest-methods}
\alias{acfIidTest,ANY-method}
\alias{acfIidTest,missing-method}
\alias{acfIidTest,SampleAutocorrelations-method}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{Carry out IID tests using sample autocorrelations}
\description{Carry out tests for IID from sample autocorrelations.}
\usage{
acfIidTest(acf, n, npar = 0, nlags = npar + 1,
           method = c("LiMcLeod", "LjungBox", "BoxPierce"),
           interval = 0.95, expandCI = TRUE, \dots)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{acf}{autocorrelations.}
  \item{n}{length of the corresponding time series.}
  \item{npar}{number of df to subtract.}
  \item{nlags}{
    number of autocorrelations to use for the portmonteau
    statistic, can be a vector to request several such statistics.
  }
  \item{method}{
    a character string, one of "LiMcLeod", "LjungBox" or "BoxPierce".
  }
  \item{interval}{
    a number or NULL.
  }
  \item{expandCI}{
    logical flag, if \code{TRUE} return a CI for each lag up to
    \code{max(nlags)}. Used only if CI's are requested.
  }
  \item{...}{currently ignored.}
}
\details{

  Performs one of several tests for IID based on sample
  autocorrelations. A correction of the degerees of freedom
  for residuals from fitted models can be specified with argument
  \code{npar}. \code{nlags} specifies the number of autocorrelations to
  use in the test, it can be a vector to request several tests.

  The results of the test are gathered in a matrix with one row for each
  element of \code{nlags}. The test statistic is in column "ChiSQ",
  degrees of freedom in "DF" and the p-value in "pvalue". The method is
  in attribute "method".

  If \code{interval} is not \code{NULL} confidence intervals for the
  autocorrelations are computed, under the null hypothesis of
  independence. The coverage probability (or probabilities) is
  speciified by \code{interval}.

  If argument \code{expandCI} is \code{TRUE}, there is one row
  for each lag, up to \code{max(nlags)}. It is best to use this feature
  with a single coverage probability.

  If \code{expandCI} to \code{FALSE} the confidence intervals are put in
  a matrix with one row for each coverage probability.

}
\value{
  a list with components "test" and (if requested) "ci", as described in
  Details
}
\section{Methods}{
\describe{

\item{\code{signature(acf = "ANY")}}{

  In this method \code{acf} contains the autocorrelations.

}

\item{\code{signature(acf = "missing")}}{

  The autocorrelations are computed from argument \code{x}.

}

\item{\code{signature(acf = "SampleAutocorrelations")}}{

  This is a convenience method in which argument \code{n} is taken from
  \code{acf} and thus does not need to be specified by the user.

}
}}

\references{
  \insertRef{Li2004diagnostic}{sarima}

}
\author{Georgi N. Boshnakov}
%\note{
%%%  ~~further notes~~
%}
%
%%% ~Make other sections like Warning with \section{Warning }{....} ~
%
\seealso{
  \code{\link{whiteNoiseTest}},
  \code{\link{acfGarchTest}},
  \code{\link{acfMaTest}}
}
\examples{
ts1 <- rnorm(100)

a1 <- drop(acf(ts1)$acf)
acfIidTest(a1, n = 100, nlags = c(5, 10, 20))
acfIidTest(a1, n = 100, nlags = c(5, 10, 20), method = "LjungBox")
acfIidTest(a1, n = 100, nlags = c(5, 10, 20), interval = NULL)
acfIidTest(a1, n = 100, method = "LjungBox", interval = c(0.95, 0.90), expandCI = FALSE)


## acfIidTest() is called behind the scenes by methods for autocorrelation objects
ts1_acrf <- autocorrelations(ts1)
class(ts1_acrf)  # "SampleAutocorrelations"
whiteNoiseTest(ts1_acrf, h0 = "iid", nlags = c(5,10,20), method = "LiMcLeod")
plot(ts1_acrf)

## use 10% level of significance in the plot:
plot(ts1_acrf, interval = 0.9)
}
\keyword{ts}
\keyword{htest}
% use one of  RShowDoc("KEYWORDS")
