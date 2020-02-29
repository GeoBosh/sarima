test_that("functions in autocorrelations.org work ok", {
    acv1 <- autocovariances(list(ar = c(0.5), ma = c(0.8), sigma2 = 2), maxlag = 5)
    expect_true(is(acv1, "Autocovariances"))
    expect_identical(autocovariances(acv1), acv1)
    autocovariances(acv1, maxlag = 3)
    autocorrelations(acv1, maxlag = 3)
    autocorrelations(acv1, maxlag = 3, lag_0 = TRUE)
    partialAutocovariances(acv1, maxlag = 3)
    partialAutocovariances(as(acv1, "Autocovariances"))
    partialVariances(as(acv1, "Autocovariances"))

    v1 <- rnorm(100)
    autocorrelations(v1)
    v1.acf <- autocorrelations(v1, maxlag = 10, se = TRUE)
    v1.acvf <- autocovariances(v1, maxlag = 10, se = TRUE)
    expect_output(show(v1.acf))
    autocorrelations(autocovariances(v1, maxlag = 10, se = TRUE))

    vcov(v1.acf)
    diagOfVcov(v1.acf)
    confint(v1.acf)
    confint(v1.acf, maxlag = 5)
    coef(v1.acf)

    .comboAcf(v1.acf)
    .comboAcf(v1.acf, 1:2)
    .comboAcf(v1.acf, c("acf", "pacf"))
    .comboAcf(v1.acf, c("ar", "stdsigma2"))

    expect_error(as(v1.acf, "ComboAutocovariances"), "not possible, missing R\\(0\\)")
    as(v1.acvf, "ComboAutocovariances")

    as(v1.acvf, "ComboAutocorrelations")
    as(v1.acf, "ComboAutocorrelations")

    as(as(v1.acf, "Autocorrelations"), "Autocovariances")
    as(v1.acf, "Autocovariances")
    as(v1.acf, "SampleAutocovariances")

    as(v1.acvf, "ComboAutocorrelations")
    modelCoef(as(v1.acvf, "ComboAutocovariances"), "Autocovariances")

    modelCoef(v1.acvf)
    expect_error(modelCoef(v1.acf, "Autocovariances"), 
       "Can.t obtain autocovariances from object from class SampleAutocorrelations")
    modelCoef(v1.acvf, "ComboAutocovariances")

    modelCoef(v1.acf, "ComboAutocorrelations")
    combo_acr <- as(v1.acvf, "ComboAutocorrelations")
    modelCoef(v1.acvf, "ComboAutocorrelations")

    modelCoef(v1.acvf, "Autocorrelations")
    modelCoef(v1.acvf, "PartialAutocorrelations")

    ## modelCoef(v1.acf, "Autocorrelations")
    modelCoef(v1.acf, "PartialAutocorrelations")

    modelCoef(as(v1.acvf, "ComboAutocovariances"), "Autocovariances")
    modelCoef(as(v1.acvf, "ComboAutocovariances"), "PartialAutocovariances")
    modelCoef(as(v1.acvf, "ComboAutocovariances"), "PartialVariances")
    modelCoef(combo_acr, new("Autocorrelations"))
    modelCoef(combo_acr, new("PartialAutocorrelations"))

    ## TODO: these need sorting out
    expect_error(backwardPartialVariances(v1.acvf))
    expect_error(backwardPartialCoefficients(v1.acvf))

    ## need an object from S4 class for which this doesn't make sense:
    ## expect_error(autocovariances(), "there is no applicable method for objects from class")

    v1.acf[1:10] # drop lag zero value (and the class)
    autocorrelations(v1, maxlag = 10, lag_0 = FALSE) # same

    autocorrelations(v1.acf) # null op.
    autocorrelations(v1.acf, maxlag = 4)
    autocorrelations(v1.acf, maxlag = 12) # introduces NA's since maxlag > 10

    autocorrelations(acv1)
    autocorrelations(acv1, maxlag = 6)
    pacr_acv1 <- partialAutocorrelations(acv1)
    partialAutocorrelations(pacr_acv1)
    autocorrelations(pacr_acv1)
    autocorrelations(pacr_acv1, maxlag = 5)

    partialAutocorrelations(AirPassengers)
    partialAutocorrelations(AirPassengers, maxlag = 10)
    z <- ts(matrix(rnorm(60), 20, 3), start = c(1961, 1), frequency = 4)
    partialAutocorrelations(z)
    partialAutocorrelations(z, maxlag = 8)
                       
    expect_output(show(autocorrelations(v1, maxlag = 10) ))
    expect_output(show(autocorrelations(v1, maxlag = 10, lag_0 = FALSE) ))
    expect_output(show(partialAutocorrelations(v1)              ))
    expect_output(show(partialAutocorrelations(v1, maxlag = 10) ))

    ## compute 2nd order properties from raw data
    expect_output(show(autocovariances(v1)                    ))
    expect_output(show(autocovariances(v1, maxlag = 10)       ))
    expect_output(show(partialAutocovariances(v1, maxlag = 6) ))
    expect_output(show(partialAutocovariances(v1)             ))
    expect_output(show(partialVariances(v1, maxlag = 6)       ))
    ## pv1 <- partialVariances(v1)

    expect_true(is.numeric(partialAutocorrelations(v1, lag_0 = FALSE)))
    partialAutocorrelations(v1, lag_0 = "var")

    ##  
    n <- 5000
    x <- sarima:::rgarch1p1(n, alpha = 0.3, beta = 0.55, omega = 1, n.skip = 100)
    x.acf <- autocorrelations(x)
    x.pacf <- partialAutocorrelations(x)
    
    acfGarchTest(x.acf, x = x, nlags = c(5,10,20))
    acfGarchTest(x.pacf, x = x, nlags = c(5,10,20))
    
    # do not compute CI's:
    acfGarchTest(x.pacf, x = x, nlags = c(5,10,20), interval = NULL)
    
    ## plot methods call acfGarchTest() suitably if 'x' is given:
    plot(x.acf, data = x)
    plot(x.pacf, data = x)
    
    ## use 90% limits:
    plot(x.acf, data = x, interval = 0.90)
    
    acfWnTest(x.acf, x = x, nlags = c(5,10,20))
    whiteNoiseTest(x.acf, h0 = "arch-type", x = x, nlags = c(5,10,20))
    expect_error(whiteNoiseTest(x.acf, h0 = "argh", x = x, nlags = c(5,10,20)))

    ts1 <- rnorm(100)
    
    a1 <- drop(acf(ts1)$acf)
    acfIidTest(a1, n = 10)
    acfIidTest(a1, n = 100, nlags = c(5, 10, 20))
    acfIidTest(a1, n = 100, nlags = c(5, 10, 20), method = "LjungBox")
    expect_error(acfIidTest(a1,          nlags = c(5, 10, 20), method = "LjungBox"),
        "argument .n. is missing, with no default")
    acfIidTest(a1, n = 100, nlags = c(5, 10, 20), method = "BoxPierce")
    expect_error(acfIidTest(a1, n = 100, nlags = c(5, 10, 20), method = "unknown") )
    acfIidTest(a1, n = 100, nlags = c(5, 10, 20), interval = NULL)
    acfIidTest(a1, n = 100, method = "LjungBox", interval = c(0.95, 0.90), expandCI = FALSE)

    acfIidTest(x = AirPassengers)    
    
    ## acfIidTest() is called behind the scenes by methods for autocorrelation objects
    ts1_acrf <- autocorrelations(ts1)
    class(ts1_acrf)  # "SampleAutocorrelations"
    whiteNoiseTest(ts1_acrf, h0 = "iid", nlags = c(5,10,20), method = "LiMcLeod")
    plot(ts1_acrf)
    
    ## use 10% level of significance in the plot:
    plot(ts1_acrf, interval = 0.9)



    nvarOfAcfKP(x, maxlag = 10)
    nvarOfAcfKP(x, maxlag = 10, center = TRUE, acfscale = "mom")
    expect_error(nvarOfAcfKP(x, maxlag = 10, acfscale = "argh"),
                 ".arg. should be one of")

    ## MA(2)
    ma2 <- list(ma = c(0.8, 0.1), sigma2 = 1)
    nv <- nvcovOfAcf(ma2, maxlag = 4)
    d <- diag(nvcovOfAcf(ma2, maxlag = 7))
    cbind(ma2 = 1.96 * sqrt(d) / sqrt(200), iid = 1.96/sqrt(200))
    
    acr <- autocorrelations(list(ma = c(0.8, 0.1)), maxlag = 7)
    nvBD <- nvcovOfAcfBD(acr, 2, maxlag = 4)
    expect_equal(nv, nvBD)
    nvcovOfAcfBD(acr, maxlag = 2)
    nvcovOfAcfBD(acr, maxlag = 4)

    expect_error(acfMaTest(acr, 2, nlags = 4), "argument .n. is missing, with no default")
    acfMaTest(acr, 2, nlags = 4, n = 100)

    expect_error(autocorrelations(list(ma = c(0.8, 0.1)), maxlag = 7, lag_0 = "var"),
                 "sigma2 > 0 is not TRUE")
    autocorrelations(list(ma = c(0.8, 0.1), sigma2 = 1), maxlag = 7, lag_0 = "var")

    acfOfSquaredArmaModel(ma2, maxlag = 4)
})
