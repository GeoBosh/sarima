\name{sarima}
\alias{sarima}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Fit extended SARIMA models}
\description{

  Fit extended SARIMA models, which can include lagged exogeneous
  variables, general unit root non-stationary factors, multiple
  periodicities, and multiplicative terms in the SARIMA
  specification. The models are specified with a flexible formula syntax
  and contain as special cases many models with specialised names, such
  as ARMAX and reg-ARIMA.

}
\usage{
sarima(model, data = NULL, ss.method = "sarima", use.symmetry = FALSE, 
       SSinit = "Rossignol2011")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{model}{a model formula specifying the model.}
  \item{data}{a list or data frame, usually can be omitted.}
  \item{ss.method}{state space engine to use, defaults to
    \code{"sarima"}. (\strong{Note:} this argument will
    probably be renamed.)}
  \item{use.symmetry}{a logical argument indicating whether 
    symmetry should be used to estimate the unit polynomial.}
  \item{SSinit}{method to use for computation of the stationary part of
    the initial covariance matrix, one of "Rossignol2011", "gnb",
    "Gardner1980".} 
}
\details{

  \code{sarima} fits extended SARIMA models, which can include
  exogeneous variables, general unit root non-stationary factors and
  multiplicative terms in the SARIMA specification.

  Let \eqn{\{Y_t\}} be a time series and \eqn{f(t)} and \eqn{g(t)} be
  functions of time and/or (possibly lagged) exogeneous variables.


  An extended pure SARIMA model for \eqn{Y_t} can be written with the
  help of the backward shift operator as
  \deqn{U(B)\Phi(B)Y_t = \Theta(B)\varepsilon_t,}
  where \eqn{\{\varepsilon_t\}}{\{eps_t\}} is white noise, and 
  \eqn{U(z)}, \eqn{\Phi(z)}, and \eqn{\Theta(z)} are polynomials,
  such that all roots of \eqn{U(z)} are on the unit circle, while the
  roots of \eqn{\Phi(z)} and \eqn{\Theta(z)} are outside the unit
  circle. If unit roots are missing, ie \eqn{U(z)\equiv 1}{U(z)=1}, the
  model is stationary with mean zero.

  A reg-SARIMA or X-SARIMA model can be defined as a regression with
  SARIMA residuals: 
  \deqn{Y_t = f(t) + Y^c_t}
  \deqn{U(B)\Phi(B)Y^c_t = \Theta(B)\varepsilon_t,}
  where \eqn{Y^c_t = Y_t - f(t)} is the centred \eqn{Y_t}.
  This can be written equivalently as a single equation:
  \deqn{U(B)\Phi(B)(Y_t - f(t)) = \Theta(B)\varepsilon_t.}
  The regression function \eqn{f(t)} can depend on
  time and/or (possibly lagged) exogeneous variables.  We call it
  centering function. If \eqn{Y^c_t}{Yc_t} is stationary with mean zero,
  \code{f(t)} is the mean of \eqn{Y_t}. If \code{f(t)} is constant, say
  \code{mu}, \eqn{Y_t} is stationary with mean \code{mu}. Note that the
  two-equation form above shows that in that case \code{mu} is the
  intercept in the first equation, so it is perfectly reasonable to
  refer to it also as intercept but to avoid confusion we reserve
  the term \strong{intercept} for  \code{g(t)} below.

  If the SARIMA part is stationary, then \eqn{EY_t = f(t)}, so
  \eqn{f(t)} can be interpreted as trend. In this case the above
  specification is often referred to as \strong{mean corrected form} of
  the model. 

  An alternative way to specify the regression part is to add the
  regression function, say \eqn{\{g(t)\}}, to the right-hand side of the SARIMA
  equation:
  \deqn{U(B)\Phi(B)Y_t = g(t) + \Theta(B)\varepsilon_t.}
  In the stationary case this is the classical ARMAX specification. 
  This can be written in two-stage form in various ways, eg
  \deqn{U(B)\Phi(B)Y_t = (1 - \Theta(B))\varepsilon_t + u_t,}
  \deqn{u_t = g(t) + \varepsilon_t .}
  So, in a sense, g(t) is a trend associated with the residuals from the
  SARIMA modelling. We refer to this form as intercept form of the
  model (as opposed to the mean-corrected form discussed previously). 

  In general, if there are no exogeneous variables the mean-corrected
  model is equivalent to some intercept model, which gives some
  justification of the terminology, as well. If there are exogeneous
  variables equivalence may be achievable but at the expense of
  introducing more lags in the model, whish is not desirable in general.
  
  Some examples of equivalence. Let Y be a stationary SARIMA
  process (\eqn{U(z)=1}) with mean \eqn{\mu}{mu}. Then the
  mean-corrected form of the SARIMA model is 
  \deqn{\Phi(B)(Y_t - \mu) = \Theta(B)\varepsilon_t,}
  while the intercept form is
  \deqn{\Phi(B)Y_t = c + \Theta(B)\varepsilon_t,}
  where \eqn{c = \Phi(B)\mu}. So, in this case the mean-corrected model
  X-SARIMA model with \eqn{f(t) = \mu}{f(t) = mu} is equivalent to the
  intercept model with \eqn{g(t) = \Phi(B)\mu}{g(t) = Phi(B)mu}.

  As another example, with \eqn{f(t) = bt}, the mean-corrected model is
  \eqn{(1-B)(Y_t - bt) = \varepsilon_t}. Expanding the left-hand side
  we obtain the intercept form  \eqn{(1-B)Y_t = b + \varepsilon_t},
  which demonstrates that \eqn{Y_t} is a random walk with drift \eqn{g(t) = b}. 

  \strong{Model specification}

  Argument \code{model} specifies the model with a syntax similar to
  other model fitting functions in \R.  A formula can be given for each
  of the components discussed above as \code{y ~ f | SARIMA | g}, where
  \code{f}, \code{SARIMA} and \code{g} are model formulas giving the
  specifications for the centering function \code{f}, the \code{SARIMA}
  specification, and the intercept function \code{g}.  In normal use
  only one of \code{f} or \code{g} will be different from zero. \code{f}
  should always be given (use \code{0} to specify that it is identical
  to zero), but \code{g} can be omitted altogether.  Sometimes we refer
  to the terms specified by \code{f} and \code{g} by \code{xreg} and
  \code{regx}, respectively.

  \strong{Model formulas for trends and exogeneous regressions}
  % \strong{The trend parts} of the model (xreg and regx):
  
  The formulas for the centering and intercept (ie \code{f} and
  \code{g}) use the same syntax as in linear models with some additional
  functions for trigonometric trends, polynomial trends and lagged
  variables.

  Here are the available specialised terms:
  
  \describe{

    \item{.p(d)}{
      Orthogonal polynomials over \code{1:length(y)} of degree d
      (starting from degree 1, no constant).
    }
    
    \item{t}{
      Stands for \code{1:length(y)}. Note that powers need to be
      protected by I(), e.g. \code{y ~ 1 + .t + I(.t^2)}.
    }

    \item{.cs(s, k)}{
      cos/sin pair for the k-th harmonic of 2pi/s. Use vector k to
      specify several harmonics.

    }
    
    \item{.B(x, lags)}{
      Include lagged terms of x, \eqn{B^{lags}(x[t]) = x[t - lags]}.
      \code{lags} can be a vector.
      If \code{x} is a matrix, the specified lags are taken from each
      column. 
      
    }
  }
  
  

  \strong{Model formulas for SARIMA models}

  A flexible syntax is provided for the specification of the SARIMA part
  of the model.  It is formed using a number of primitives for
  stationary and unit root components, which have 
  non-seasonal and seasonal variants. Arbitrary number of multiplicative
  factors and multiple seasonalities can be specified.  
  
  The SARIMA part of the model can contain any of the following
  terms. They can be repeated as needed. The first argument for all
  seasonal operators is the number of seasons. 

  \describe{

    \item{ar(p)}{autoregression term of order p}
    \item{ma(q)}{moving average term of order q}

    \item{sar(s,p)}{seasonal autoregression term (s seasons, order p)}
    \item{sma(s,q)}{seasonal moving average term (s seasons, order q)}

    \item{i(d)}{\eqn{(1-B)^d}}
    \item{s(seas)}{summation operator,
      \eqn{(1 + B + \cdots + B^{seas -1})}{(1 + B + ... + B^(seas-1))}
    }


    \item{u(x)}{
      quadratic unit root term, corresponding to a complex pair on the
      unit circle. If \eqn{x} is real, it specifies the argument of one
      of the roots as a fraction of \eqn{2\pi}{2pi}. If \eqn{z} is
      complex, it is the root itself.

      The real roots of modulus one (1 and \eqn{-1}) should be specified
      using \code{i(1)} and \code{s(2)}, which correspond to \eqn{1-B}
      and \eqn{1+B}, respectively.
    }

    \item{su(s, h)}{quadratic unit root terms corresponding to seasonal
      differencing factors. h specifies the desired harmonic which
      should be one of 1,2, ..., [s/2]. Several harmonics can be
      specified by setting h to a vector. 
    }    


    \item{ss(s, p)}{
      seasonal summation operator,
      \eqn{(1 + B^s + \cdots + B^{(s-1)p})}{(1 + B^s + ... + B^(p(s-1)))}

    }
  }

  Terms with parameters can contain additional arguments specifying
  initial values, fixed parameters, and transforms. For \code{ar},
  \code{ma}, \code{sar}, \code{sma}, values of the coefficients can be
  specified by an unnamed argument after the parameters given in the
  descriptions above. In estimation these values will be taken as
  initial values for optimisation.  By default, all coefficients are
  taken to be non-fixed.

  Argument \code{fixed} can be used to fix some of them.  If it is a
  logical vector it should be of length one or have the same length as
  the coefficients. If \code{fixed} is of length one and \code{TRUE}, all
  coefficients are fixed. If FALSE, all are non-fixed. Otherwise, the
  TRUE/FALSE values in \code{fixed} determine the fixedness of the
  corresponding coefficients.

  \code{fixed} can also be a vector of positive integer numbers
  specifying the indices of fixed coefficients, the rest are non-fixed.

  Sometimes it may be easier to declare more (e.g. all) coefficients as
  fixed and then `unfix' selectively. Argument \code{nonfixed} can be
  used to mark some coefficients as non-fixed after they have been
  declared fixed. Its syntax is the same as for \code{fixed}.

  TODO: streamline "atanh.tr"

  TODO: describe \code{SSinit}
}
\value{
  an object from S3 class Sarima
  
  (\strong{Note:} the format of the object is still under development
  and may change; use accessor functions, such as \code{coef()}, where provided.)
  
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. Boshnakov}
\note{
    Currently the implementation of the intercept form (ie the third
    part of the model formula) is incomplete. 
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link[stats]{arima}}
}
\examples{
## AirPassengers example
## fit the classic airline model using arima()
ap.arima <- arima(log(AirPassengers), order = c(0,1,1), seasonal = c(0,1,1))

## samemodel using twoequivalent ways to specify it
ap.baseA <- sarima(log(AirPassengers) ~ 
                   0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(1) + si(12,1), 
                   ss.method = "base")
ap.baseB <- sarima(log(AirPassengers) ~ 
                   0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(2) + s(12), 
                   ss.method = "base")

ap.baseA
summary(ap.baseA)
ap.baseB
summary(ap.baseB)

## as above, but drop 1-B from the model:
ap2.arima <- arima(log(AirPassengers), order = c(0,0,1), seasonal = c(0,1,1))
ap2.baseA <- sarima(log(AirPassengers) ~ 
                    0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) +     si(12,1), 
                    ss.method = "base")
ap2.baseB <- sarima(log(AirPassengers) ~ 
                    0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(1) + s(12), 
                    ss.method = "base")

## for illustration, here the non-stationary part is 
##     (1-B)^2(1+B+...+B^5) = (1-B)(1-B^6)
##     (  compare to (1-B)(1-B^{12}) = (1-B)(1-B^6)(1+B^6) ) 
ap3.base <- sarima(log(AirPassengers) ~ 
                   0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(2) + s(6), 
                   ss.method = "base")

## further unit roots, equivalent specifications for the airline model
tmp.su <- sarima(log(AirPassengers) ~ 
                 0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(2) + s(2) + su(12,1:5), 
                 ss.method = "base")
tmp.su$interna$delta_poly
prod(tmp.su$interna$delta_poly)
zapsmall(coef(prod(tmp.su$interna$delta_poly)))
tmp.su

tmp.u <- sarima(log(AirPassengers) ~ 
                0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(2) + s(2) + u((1:5)/12), 
                ss.method = "base")
tmp.u
}
\keyword{ts}
% use one of  RShowDoc("KEYWORDS")
\keyword{arima}
