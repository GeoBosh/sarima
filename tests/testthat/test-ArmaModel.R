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


    m1 <- new("SarimaModel", iorder = 1, siorder = 1, ma = -0.3, sma = -0.1, nseasons = 12)
    modelOrder(m1)
    modelOrder(m1, "ArmaFilter")
    modelOrder(m1, new("ArmaFilter"))
    
    modelPoly(m1, "ArmaModel")
    modelPolyCoef(m1, "ArmaModel")

    ## from coerce-methods.Rd
    mo <- new("ArmaModel", ar = 0.9, ma = 0.4, sigma2 = 1)
    modelPoly(mo)
    
    mo1 <- new("ArmaModel", ar = 0.9, ma = as(0.4, "SPFilter"), sigma2 = 1)
    modelPoly(mo1)
    expect_identical(mo, mo1)
    
    mo2 <- new("ArmaModel", ar = 0.9, ma = as(-0.4, "BJFilter"), sigma2 = 1)
    modelPoly(mo2)
    expect_identical(mo, mo2)
    
    ar3 <- as(0.9, "BJFilter")
    ma3 <- as(-0.4, "BJFilter")
    mo3 <- new("ArmaModel", ar = ar3, ma = ma3, sigma2 = 1)
    modelPoly(mo3)
    expect_identical(mo, mo3)
    
    modelCoef(mo3) # coefficients of the model with the default (BD) sign convention
    modelCoef(mo3, convention = "BD") # same result
    modelCoef(mo3, convention = "SP") # signal processing convention
    
    ## for ltsa::tacvfARMA() the convention is BJ, so:
    co <- modelCoef(mo3, convention = "BJ") # Box-Jenkins convention
    
    ## ltsa::tacvfARMA(co$ar, co$ma, maxLag = 6, sigma2 = 1)
    autocovariances(mo3, maxlag = 6) ## same

})
