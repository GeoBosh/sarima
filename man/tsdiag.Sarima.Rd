\name{tsdiag.Sarima}
\alias{tsdiag.Sarima}

\alias{tsdiag}


\title{Diagnostic Plots for fitted seasonal ARIMA models}

\description{

  Produce diagnostics for fitted seasonal ARIMA models. The method
  offers several portmanteau tests (including Ljung-Box, Li-McLeod and
  Box-Pierce), plots of autocorrelations and partial autocorrelations of
  the residuals, ability to control which graphs are produced (including
  interactively), as well as their layout.

}
\usage{
\method{tsdiag}{Sarima}(object, gof.lag = NULL, ask = FALSE, \dots, plot = 1:3, layout = NULL)

# if 'object' is produced by stats::arima(), forecast::auto.arima() and
# similar, use the full name, 'tsdiag.Sarima()', in the call. The
# arguments are the same.
}
\arguments{
  \item{object}{
    
    fitted (seasonal) ARIMA model. currently the output of
    \code{sarima}, \code{stats::arima} or compatible (e.g.,
    \code{forecast::Arima} and \code{forecast::auto.arima}).  If
    \code{object} is not from \code{sarima}, use the full name,
    \code{tsdiag.Sarima}, of the method when calling it, see the
    examples. 

  }
  \item{gof.lag}{maximal lag for portmanteau tests.}
  \item{ask}{
    if \code{TRUE} present a menu of available plots, see section
    \sQuote{Details}.
  }
  \item{\dots}{not used.}
  \item{plot}{
    if \code{TRUE} all available plots; a vector of positive integers
    specifies a subset of the available plots.
  }
  \item{layout}{
    a list with arguments for \code{graphics::layout} for the plots. The
    default is as for the ARIMA method of \code{stats::tsdiag}.
  }
}
\details{

  Compute and graph diagnostics for seasonal ARIMA models. For objects
  of class \code{"Sarima"} (produced by \code{sarima}) just call the
  generic, \code{tsdiag}. The method can be called also directly on the output
  from base R's \code{arima()} with \code{tsdiag.Sarima()} or
  \code{sarima::tsdiag.Sarima()}.

  The method offers several portmanteau tests (including Ljung-Box,
  Li-McLeod and Box-Pierce), plots of autocorrelations and partial
  autocorrelations of the residuals, ability to control which graphs are
  produced (including interactively), as well as their layout.

  The method always makes a correction of the degrees of freedom of the
  portmanteau tests (roughly, subtracting the number of estimated ARMA
  parameters). Note that \code{stats::tsdiag} doesn't do that.

  \code{plot} can be \code{TRUE} to ask for all plots or a vector of
  positive integers specifying which plots to consider. Currently the
  following options are available:
  \Sexpr[stage=build,results=rd]{paste0("\\\\tabular{rl}{", paste0(1:length(sarima:::.tsdiag_choices),  " \\\\tab ", sarima:::.tsdiag_choices, collapse = " \\\\cr\n "), "}\n")}
  The default is \code{plot = 1:3}, which produces a plot similar to the
  one from \code{stats::tsdiag} (but with adjusted d.f., see above). 
  If \code{plot} is \code{TRUE}, you probably need also \code{ask = TRUE}.

  If argument \code{plot} is of length two the graphics window is split
  into 2 equal subwindows. Argument \code{layout} can still be used to
  change this.  If argument \code{plot} is of length one the graphics
  window is not split at all.
  
  In interactive sessions, if the number of requested graphs (as
  specified by argument \code{plot}) is larger than the number of graphs
  specified by the layout (by default 3), the function makes the first
  graph and then presents a menu of the requested plots. 

  Argument \code{layout} can be used to change the layout of the plot,
  for example to put two graphs per plot, see the examples. Currently it
  should be a list of arguments for \code{\link[graphics]{layout}}, see \code{?layout}.
  Don't call \code{layout} youself, as that will change the graphics
  device prematurely.
  
  The computed results are returned (invisibly). This is another
  difference from \code{stats::tsdiag} which doesn't return them.
}
\value{
  a list with components:
  \item{residuals}{residuals}
  \item{LjungBox}{Ljung box test}
  \item{LiMcLeod}{LiMcLeod test}
  \item{BoxPierce}{BoxPierce test}

  Only components that are actually computed are included, the rest are
  NULL or absent.
}
%\references{
%%% ~put references to the literature/web site here ~
%}
\author{Georgi N. boshnakov}
%\note{
%%%  ~~further notes~~
%}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
  \code{\link[stats]{tsdiag}}
}
\examples{
ap.baseA <- sarima(log(AirPassengers) ~ 
    0 | ma(1, c(-0.3)) + sma(12,1, c(-0.1)) + i(1) + si(12,1), 
    ss.method = "base")
tsdiag(ap.baseA)

## apply the method on objects from arima()
ap.arima <- arima(log(AirPassengers), order = c(0,1,1), seasonal = c(0,1,1))
tsdiag.Sarima(ap.arima)
## use Li-McLeod test instead of Ljung-Box
tsdiag.Sarima(ap.arima, plot = c(1:2,4))
## call R's tsdiag method, for comparison:
tsdiag(ap.arima, plot = c(1:2,4))

## plot only acf and p-values
tsd <- tsdiag.Sarima(ap.arima, plot = c(2:3), layout = list(matrix(1:2, nrow = 2)))
## the results can be used for further calculations:
head(tsd$LjungBox$test, 4)

\dontshow{if(FALSE) # otherwise R check warns about help page running time > 5s}
## plot resid, acf, and p-values, leaving half the space for residuals
tsdiag.Sarima(ap.arima, plot = c(1:3), layout = list(matrix(1:3, nrow = 3),
                                                     heights = c(1,2,2)))

\dontshow{if(FALSE)}
## four plots arranged as a 2x2 matrix.
tsdiag.Sarima(ap.arima, plot = c(2:5), layout = list(matrix(1:4, nrow = 2)))
}
\keyword{ts}
\keyword{htest}
\concept{diagnostics}
\concept{diagnostic plots}
