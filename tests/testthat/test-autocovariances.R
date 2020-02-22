test_that("functions in autocorrelations.org work ok", {
    acv1 <- autocovariances(list(ar = c(0.5), ma = c(0.8), sigma2 = 2), maxlag = 5)
    expect_true(is(acv1, "Autocovariances"))

    v1 <- rnorm(100)
    autocorrelations(v1)
    v1.acf <- autocorrelations(v1, maxlag = 10)

    v1.acf[1:10] # drop lag zero value (and the class)
    autocorrelations(v1, maxlag = 10, lag_0 = FALSE) # same
                       
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
    
    ## ## plot methods call acfGarchTest() suitably if 'x' is given:
    ## plot(x.acf, data = x)
    ## plot(x.pacf, data = x)
    
    ## ## use 90% limits:
    ## plot(x.acf, data = x, interval = 0.90)
    
    acfWnTest(x.acf, x = x, nlags = c(5,10,20))
    nvarOfAcfKP(x, maxlag = 20)
    whiteNoiseTest(x.acf, h0 = "arch-type", x = x, nlags = c(5,10,20))

})
