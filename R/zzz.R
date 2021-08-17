.onLoad <- function(libname, pkgname){
    ## TODO: when Polynom 2.0.0 or later has been around for some time,
    ##       rename the calls in the package with the new names
    ##       and reverse the check here to
    ##                 utils::packageVersion("PolynomF") < "2.0.0"
    if (utils::packageVersion("PolynomF") >= "2.0.0") {
                                               # or: envir = asNamespace("sarima")
        assign("as.polylist", PolynomF::as_polylist, envir = topenv())
        ## add other renamed functions from PolynomF
    }

    ## invertibleQ is not visible in FitARMA::InformationMatrixARMA(), v1.6.1 and earlier,
    ##    unless FitAR is attached. v1.6.1 is the current one at the time of writing this
    ##    (2021-03-07) but it would be unsafe to make this changed for later versions.  Also,
    ##    if a new version appears on CRAN this should be resolved since there is a NOTE
    ##    about it by R CMD check.
    if (utils::packageVersion("FitARMA") <= "1.6.1") {
        fu <- FitARMA::InformationMatrixARMA
        body(fu)[[c(2,2)]] <- 
            quote(!(FitAR::InvertibleQ(phi) & FitAR::InvertibleQ(theta)))
        assign("InformationMatrixARMA", fu, envir = topenv())
    }
        
    NULL
}
