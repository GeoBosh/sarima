test_that("Sarima and Arma models work ok", {
    sm0 <- new("SarimaModel", nseasons = 12)
    sm1 <- new("SarimaModel", nseasons = 12, intercept = 3)
    sm1b <- new("SarimaModel", sm0, intercept = 3)
    identical(sm1, sm1b) # TRUE

    sm2  <- new("SarimaModel", ar = 0.9, nseasons = 12, intercept = 3, sigma2 = 1)
    sm2b <- new("SarimaModel", sm1, ar = 0.9, sigma2 = 1)
    sm2c <- new("SarimaModel", sm0, ar = 0.9, intercept = 3, sigma2 = 1)

    expect_identical(sm2, sm2b)
    expect_identical(sm2, sm2c)

    sm3 <- new("SarimaModel", ar = 0.9, sar= 0.8, nseasons = 12, intercept = 3, sigma2 = 1)
    expect_equal_to_reference(sm3, "sm3.RDS")

    sm3b <- new("SarimaModel", sm2, sar = 0.8)

    expect_error(new("MaModel", ma = 0.9, ar = 0.5), "Autoregressive terms found in MaModel")
    expect_error(new("ArModel", ma = 0.9, ar = 0.5), "Moving average terms found in ArModel")

    expect_null(.reportClassName(sm0, "VirtualSarimaModel"))
    expect_null(.reportClassName(sm0, "SarimaModel"))
    expect_output(.reportClassName(sm0, "SarimaModel"), "An object")

    expect_output(show(sm0), "An object")

    arma1p1 <- new("ArmaModel", ar = 0.5, ma = 0.9, center = 1.23, intercept = 2)
    expect_output(show(arma1p1), "An object")

    expect_output(show(new("MaModel", ma = 0.9)), "An object")
    expect_output(show(new("ArModel", ar = 0.5)), "An object")

    expect_output(summary(sm0))
    expect_output(summary(sm1))
    expect_output(summary(sm2))
    expect_output(summary(sm3))

    expect_output(summary(as(sm0, "SarimaSpec")))
    expect_output(summary(as(sm1, "SarimaSpec")))
    expect_output(summary(as(sm2, "SarimaSpec")))
    expect_output(summary(as(sm3, "SarimaSpec")))

    sm3i <- new("SarimaModel", ar = 0.9, sar= 0.8, nseasons = 12, intercept = 3, sigma2 = 1, iorder = 1)

    expect_output(summary(sm3i))
    expect_output(show(as(sm3i, "InterceptSpec")))
    isStationaryModel(sm3i)
    as(sm3i, "list")

    isStationaryModel(sm3)
    ## as(sm3, "ArmaModel") # TODO: this gives Warning message:
    ##                              In .local(.Object, ...) : The AR polynomial is not stable.
    ##                        Investigate! 
    as(sm2, "ArmaModel")
    as(sm3, "list")

})
