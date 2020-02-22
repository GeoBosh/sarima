test_that("functions in autocorrelations.org work ok", {
    v1 <- rnorm(100)
    autocorrelations(v1)
    v1.acf <- autocorrelations(v1, maxlag = 10)

    v1.acf[1:10] # drop lag zero value (and the class)
    autocorrelations(v1, maxlag = 10, lag_0 = FALSE) # same
                       
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

})
