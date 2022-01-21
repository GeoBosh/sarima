\name{confint}
\alias{confint}
\alias{confint,SampleAutocorrelations-method}

\title{
  Confidence and acceptance intervals in package sarima
}
\description{

  Compute confidence and acceptance intervals for sample
  autocorrelations under assumptions chosen by the user.

}
\usage{
\S4method{confint}{SampleAutocorrelations}(object, parm, level = 0.95, se = FALSE, maxlag, \dots, assuming)
}
%%                !!! TODO: argument 'x' for the garch case !!!
\arguments{
  \item{object}{
    an object containing sample autocorrelations (sacfs).
  }
  \item{parm}{which parameters to include, as for \code{stats::confint}.}
  \item{level}{coverage level, such as 0.95.}
  \item{se}{If \code{TRUE} return also standard errors.}
  \item{assuming}{

    under what assumptions to do the computations?
    Currently can be \code{"iid"}, \code{"garch"}, a fitted model, or a
    theoretical model, see Details.

  }
  \item{maxlag}{maximal lag to include}
  \item{\dots}{
    further arguments for \code{se}.
  }
}
\details{

  For lags not fixed by the assumed model the computed intervals are
  confidence intervals.

  The autocorrelations postulated by the null model (argument
  \code{assuming}) are usually fixed for some lags. For such lags it
  doesn't make sense to talk about confidence intervals.  We use the
  term \emph{acceptance interval} in this case since the sacfs for such
  lags fall in the corresponding intervals with high probability if the
  null model is correct.

  If \code{assuming} is \code{"iid"} (strong white noise), then all
  autocorrelations in the null model are fixed (to zero) and the limits
  of the resulting acceptance intervals are ethose from the familiar
  plots produced by base-R's function \code{\link{acf}}.

  If \code{assuming} is a fitted MA(q) model, e.g. obtained from
  \code{arima()}, then for lags \eqn{1,\ldots,q}{1,...,q} we get
  confidence intervals, while for lags greater than \eqn{q} the
  intervals are acceptance intervals. 

  The autocorrelations of ARMA models with non-trivial autoregressive
  part may also have structural patterns of zeroes (for example some
  seasonal models), leading to acceptance intervals for such lags.

  If \code{assuming} specifies a theoretical (non-fitted) model, then
  the autocorrelation function of the null model is completely fixed and
  we get acceptance intervals for all lags.

  The return value is a matrix with one row for each requested lag,
  containg the lag, lower bound, upper bound, estimate for acf(lag) and
  the value of acf(lag) under H0 (if fixed) and \code{NA} if not fixed
  under H0. The null model is stored as attribute \code{"assuming"}.
  
  \strong{Note:} When \code{assuming = "garch"} it is currently
  necessary to submit the time series from which the autocorrelations
  were computed as argument \code{x}.
  
}
\value{
  a matrix as described in section \sQuote{Details};

  if \code{se = TRUE}, a column giving the standard errors of the sample
  autocorrelations is appended. 
}
\seealso{
  \code{\link{se}}

  \code{vignette("white_noise_tests", package = "sarima")}
  
  \code{vignette("garch_tests_example", package = "sarima")}
}
\examples{
set.seed(1234)
v1 <- arima.sim(n = 100, list(ma = c(0.8, 0.1), sd = 1))
v1.acf <- autocorrelations(v1, maxlag = 10)

confint(v1.acf, parm = 1:4, assuming = "iid")
confint(v1.acf,  assuming = "iid", maxlag = 4) # same

## a fitted MA(2) - rho_1, rho_2 not fixed, the rest fixed
ma2fitted <- arima(v1, order = c(0,0,2), include.mean=FALSE)
confint(v1.acf, assuming = ma2fitted, maxlag = 4)

## a theoretical MA(2) model, all acfs fixed under H0
ma2 <- MaModel(ma = c(0.8, 0.1), sigma2 = 1)
confint(v1.acf, assuming = ma2, maxlag = 4)

# a weak white noise null
confint(v1.acf, assuming = "garch", maxlag = 4, x = v1)
}
\keyword{htest}
\keyword{ts}
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.


