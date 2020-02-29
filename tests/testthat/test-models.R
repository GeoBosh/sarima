test_that("Sarima and Arma models work ok", {
    sm0 <- new("SarimaModel", nseasons = 12)
    sm1 <- new("SarimaModel", nseasons = 12, intercept = 3)
    sm1b <- new("SarimaModel", sm0, intercept = 3)
    identical(sm1, sm1b) # TRUE

    sm2  <- new("SarimaModel", ar = 0.9, nseasons = 12, intercept = 3, sigma2 = 1)
    sm2b <- new("SarimaModel", sm1, ar = 0.9, sigma2 = 1)
    sm2c <- new("SarimaModel", sm0, ar = 0.9, intercept = 3, sigma2 = 1)

    nSeasons(sm2)

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

    sm3i <- new("SarimaModel", ar = 0.9, sar= 0.8, nseasons = 12, intercept = 3, 
                               sigma2 = 1, iorder = 1)

    expect_output(show(sm3i))
    expect_output(show(new("SarimaModel", ar = 0.9, sar = 0.8, nseasons = 12, intercept = 3, 
                               sigma2 = 1, iorder = 2, siorder = 2)))
    expect_output(show(new("SarimaModel", ar = 0.9, sar = 0.8, nseasons = 12, intercept = 3, 
                               sigma2 = 1, center = 5)))

    expect_output(summary(sm3i))

    expect_output(show(as(sm3i, "InterceptSpec")))
    isStationaryModel(sm3i)
    as(sm3i, "list")

    isStationaryModel(sm3)
    ## as(sm3, "ArmaModel") # TODO: this gives Warning message:
    ##                              In .local(.Object, ...) : The AR polynomial is not stable.
    ##                        Investigate! 
    mo_arma <- as(sm2, "ArmaModel")
    as(sm3, "list")

    as(mo_arma, "list")
    as(mo_arma, "ArmaSpec")
    as(as(mo_arma, "ArmaSpec"), "list")

    m1 <- new("SarimaModel", iorder = 1, siorder = 1, ma = -0.3, sma = -0.1, nseasons = 12)
    modelOrder(m1)
    modelOrder(m1, "ArmaFilter")
    modelOrder(m1, new("ArmaFilter"))
    expect_error(modelOrder(m1, new("ArModel")),  "iorder == 0 is not TRUE")
        
    modelPoly(m1, "ArmaModel")
    modelPolyCoef(m1, "ArmaModel")

    m1xx <- new("SarimaModel", ar = 0.5, ma = -0.3, sma = -0.1, nseasons = 12)
    expect_error(modelOrder(m1xx, new("ArModel")),  "Non-zero moving average order")    
    expect_error(modelOrder(m1xx, new("MaModel")),  "Non-zero autoregressive order")    
    modelOrder(m1xx, "ArmaModel")

    modelOrder(new("SarimaModel", ma = -0.3, sma = -0.1, nseasons = 12), "MaFilter")
    modelOrder(new("SarimaModel", ar = -0.3, sar = -0.1, nseasons = 12), "ArFilter")

    autocorrelations(m1xx, 20)
    
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
    ar3SP <- as(ar3, "SPFilter")

    
    filterCoef(ar3, "SP")
    expect_error(filterCoef(ar3, "+-"))
    filterCoef(ar3, "BJ")
    
    filterCoef(ar3SP)
    filterCoef(ar3SP, "SP")
    expect_error(filterCoef(ar3SP, "+-"))
    filterCoef(ar3SP, "BJ")

    filterPolyCoef(ar3)
    filterPolyCoef(ar3SP)
    filterPolyCoef(ar3, lag_0 = FALSE)
    filterPolyCoef(ar3SP, lag_0 = FALSE)

    filterPoly(ar3)
    filterPoly(ar3SP)

    new("BJFilter", order = 2)

    armafi <- new("ArmaFilter", ar = 0.9, ma = 0.3)
    filterCoef(armafi, "BJ")
    filterCoef(armafi, "SP")
    filterCoef(armafi, "BD")
    filterCoef(armafi, "-+")
    filterCoef(armafi, "+-")
    filterCoef(armafi, "--")
    filterCoef(armafi, "++")
    
    expect_error(filterCoef(armafi, "-"))
    expect_error(filterCoef(armafi, "+"))
    expect_error(filterCoef(armafi, "argh"))


    filterPolyCoef(armafi)
    expect_error(filterPolyCoef(armafi, "SP")) # poly coef's have no notion of convention
    filterPolyCoef(armafi, lag_0 = TRUE)
    filterPolyCoef(armafi, lag_0 = FALSE)



    
    ## nSeasons(armafi)
    as(armafi, "list")

    expect_error(new("ArFilter", ar = 0.9, ma = 0.3), "Non-trivial moving average part")
    expect_error(new("MaFilter", ar = 0.9, ma = 0.3), "Non-trivial autoregressive part")

    
    mo3 <- new("ArmaModel", ar = ar3, ma = ma3, sigma2 = 1)
    modelPoly(mo3)
    modelPolyCoef(mo3)
    modelPolyCoef(mo3, "ArmaModel")
    expect_identical(mo, mo3)

    expect_error(modelOrder(mo3, "ArFilter"), "Non-zero moving average order")
    expect_error(modelOrder(mo3, "MaFilter"), "Non-zero autoregressive order")
    
    expect_equal(nUnitRoots(mo3), 0)
    
    expect_true(isStationaryModel(mo3))
    modelPoly(mo3)
    modelPolyCoef(mo3)
    modelPolyCoef(mo3, lag_0 = FALSE)
    modelCoef(mo3, "ArmaFilter")

    ArmaModel(ar = ar3, ma = ma3, sigma2 = 1)
    ArModel(ar = ar3, sigma2 = 1)
    MaModel(ma = ma3, sigma2 = 1)

    modelOrder(ArModel(ar = ar3, sigma2 = 1), "ArFilter")
    modelOrder(MaModel(ma = ma3, sigma2 = 1), "MaFilter")
    
    as(ArmaModel(ar = ar3, sigma2 = 1), "ArModel")
    as(ArmaModel(ma = ma3, sigma2 = 1), "MaModel")

    expect_error(as(ArmaModel(ar = ar3, ma = ma3, sigma2 = 1), "ArModel"))
    expect_error(as(ArmaModel(ar = ar3, ma = ma3, sigma2 = 1), "MaModel"))
    
    modelCoef(mo3) # coefficients of the model with the default (BD) sign convention
    modelCoef(mo3, convention = "BD") # same result
    modelCoef(mo3, convention = "SP") # signal processing convention
    
    ## for ltsa::tacvfARMA() the convention is BJ, so:
    co <- modelCoef(mo3, convention = "BJ") # Box-Jenkins convention
    
    ## ltsa::tacvfARMA(co$ar, co$ma, maxLag = 6, sigma2 = 1)
    autocovariances(mo3, maxlag = 6) ## same

    autocovariances(mo3)

    autocorrelations(mo3, maxlag = 6)


    expand_ar(0.5, 0.8, 12)

    new("ArmaSpec", ar = 0.5, mean = 3)
    expect_error(new("ArmaSpec", center = 1, ar = 0.5, mean = 3),
                 "Use argument 'mean' only when 'center' and 'intercept' are missing or zero"
                 )

    expect_warning(new("ArmaSpec", ar = 0.5, ma = 2, mean = 3),
                   "The model is not invertible")
    expect_warning(new("ArmaSpec", ar = 2, ma = 0.5, mean = 3),
                   "The AR polynomial is not stable")
    
})
