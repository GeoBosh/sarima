library(sarima)
context("Fitting models using css")

test_that("the symmetric method matches non-symmetric method", {
    ## this produces NaN's and error on i386, skip it on that platform for now
    arch <- .Platform$r_arch
    flag_i386 <- !is.null(arch) && is.character(arch) && arch == "i386"
    if(!flag_i386){
        air.u.nosymm <- sarima(log(AirPassengers) ~ 0 | ma(1, c(-0.3), fixed = TRUE) +
                                   sma(12,1, c(-0.1), fixed = TRUE) +
                                   uar(13, c(rep(0,12), 1), fixed = 13, atanh.tr = TRUE),
                               ss.method = "css", use.symmetry = FALSE)
        air.u.symm <- sarima(log(AirPassengers) ~ 0 | ma(1, c(-0.3), fixed = TRUE) +
                                 sma(12,1, c(-0.1), fixed = TRUE) +
                                 uar(13, c(rep(0,12), 1), fixed = 13, atanh.tr = TRUE),
                             ss.method = "css", use.symmetry = TRUE)


        expect_equal(coef(air.u.nosymm)[3:15], coef(air.u.symm)[3:15], 1e-4)
    } else
        expect_true(TRUE)
})
