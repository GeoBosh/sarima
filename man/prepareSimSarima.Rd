\name{prepareSimSarima}
\alias{prepareSimSarima}
\alias{print.simSarimaFun}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Prepare SARIMA simulations}
\description{Prepare SARIMA simulations.}
\usage{
prepareSimSarima(model, x = NULL, eps = NULL, n, n.start = NA,
                 xintercept = NULL, rand.gen = rnorm)

\S3method{print}{simSarimaFun}(x, ...)
}
\arguments{
  \item{model}{an object from a suitable class or a list, see Details.}
  \item{x}{

    initial/before values of the time series, a list, a numeric
    vector or time series, see Details.

  }
  \item{eps}{

    initial/before values of the innovations, a list or a numeric
    vector, see Details.

  }
  \item{n}{

    number of observations to generate, if missing an attempt is made to
    infer it from \code{x} and \code{eps}.

  }
  \item{n.start}{number of burn-in observations.
  }
  \item{xintercept}{

    non-constant intercept which may represent trend or covariate
    effects.

  }
  \item{rand.gen}{random number generator, defaults to N(0,1).}
  \item{...}{ignored.}
}
\details{

  \code{prepareSimSarima} does the preparatory work for simulation from
  a Sarima model, given the specifications and returns a function, which
  can be called as many times as needed.

  The variance of the innovations is specified by the model and the
  simulated innovations are multiplied by the corresponding standard
  deviation. So, it is expected that the random number generator
  simulates from a standardised distribution.

  Argument \code{model} can be from any class representing models in the
  SARIMA family, such as "SarimaModel", or a list with components
  suitable to be passed to =new()= for such models.

  The canonical form of argument \code{x} is a list with components
  \code{before}, \code{init} and \code{main}. If any of these components
  is missing or NULL, it is filled suitably.  Any other components of
  \code{x} are ignored. If \code{x} is not a list, it is put in
  component \code{main}. Conceptually, the three components are
  concatenated in the given order, the simulated values are put in
  \code{main} (\code{before} and \code{init} are not changed), the
  \code{before} part is dropped and the rest is returned. In effect,
  \code{before} and \code{init} can be viewed as initial values but
  \code{init} is considered part of the generated series.

  The format for \code{eps} is the same as that of \code{x}. The lengths of
  missing components in \code{x} are inferred from the corresponding
  components of \code{eps}, and vice versa.

  The format for \code{xintercept} is the same as that of \code{x} and
  \code{eps}.

  \code{print.simSarimaFun} is a print method for the objects generated
  by \code{prepareSimSarima}.
}
\value{

  for \code{prepareSimSarima}, a function to simulate time series, see
  Details.  it is typically called multiple times without arguments.
  All arguments have defaults set by \code{prepareSimSarima}.
  \item{n}{length of the simulated time series,}
  \item{rand.gen}{random number generator,}
  \item{...}{arguments for the random number generator, passed on to
    \code{arima.sim}.} 

}
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
\seealso{
  \code{\link{sim_sarima}}
}
\examples{
mo1 <- list(ar = 0.9, iorder = 1, siorder = 1, nseasons = 4, sigma2 = 2)
fs1 <- prepareSimSarima(mo1, x = list(before = rep(0,6)),  n = 100)
tmp1 <- fs1()
tmp1
plot(ts(tmp1))

fs2 <- prepareSimSarima(mo1, x = list(before = rep(1,6)),  n = 100)
tmp2 <- fs2()
plot(ts(tmp2))

mo3 <- mo1
mo3[["ar"]] <- 0.5
fs3 <- prepareSimSarima(mo3, x = list(before = rep(0,6)),  n = 100)
tmp3 <- fs3()
plot(ts(tmp3))
}
\keyword{simulation}
\keyword{arima}
\keyword{sarima}
% use one of  RShowDoc("KEYWORDS")
