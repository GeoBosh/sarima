## TODO: need proper tests here
test_that("functions in sarima.R work ok", {
    ## define a seasonal ARIMA model
    m1 <- new("SarimaModel", iorder = 1, siorder = 1, ma = -0.3, sma = -0.1, nseasons = 12)
    expect_output(summary(m1))
    
    model0 <- modelCoef(m1, "ArmaModel")
    model1 <- as(model0, "list")

    modelCoef(m1, "SarimaFilter")
    modelCoef(m1, "ArmaFilter")
    modelCoef(new("SarimaModel", iorder = 1, siorder = 1, nseasons = 12), "ArFilter")
    modelCoef(new("SarimaModel", ma = -0.3, sma = -0.1, nseasons = 12), "MaFilter")

    modelCoef(new("SarimaModel", iorder = 1, siorder = 1, nseasons = 12), "ArModel")
    modelCoef(new("SarimaModel", ma = -0.3, sma = -0.1, nseasons = 12), "MaModel")
    
    modelCoef(m1, "ArmaModel")
    expect_error(modelCoef(m1, "ArFilter"))
    expect_error(modelCoef(m1, "MaFilter"))

    ap.1 <- xarmaFilter(model1, x = AirPassengers, whiten = TRUE)
    ap.2 <- xarmaFilter(model1, x = AirPassengers, eps = ap.1, whiten = FALSE)
    ap <- AirPassengers
    ap[-(1:13)] <- 0 # check that the filter doesn't use x, except for initial values.
    ap.2a <- xarmaFilter(model1, x = ap, eps = ap.1, whiten = FALSE)
    ap.2a - ap.2 ## indeed = 0
    ##ap.3 <- xarmaFilter(model1, x = list(init = AirPassengers[1:13]), eps = ap.1, whiten = TRUE)
    
    ## now set some non-zero initial values for eps
    eps1 <- numeric(length(AirPassengers))
    eps1[1:13] <- rnorm(13)
    ap.A <- xarmaFilter(model1, x = AirPassengers, eps = eps1, whiten = TRUE)
    ap.Ainv <- xarmaFilter(model1, x = ap, eps = ap.A, whiten = FALSE)
    AirPassengers - ap.Ainv # = 0
    
    ## compare with sarima.f (an old function)
    ## compute predictions starting at from = 14
    pred1 <- sarima.f(past = AirPassengers[1:13], n = 131, ar = model1$ar, ma = model1$ma)
    pred2 <- xarmaFilter(model1, x = ap, whiten = FALSE)
    pred2 <- pred2[-(1:13)]
    all(pred1 == pred2) ##TRUE
    expect_true(all(pred1 == pred2))

    set.seed(1234)
    moA <- sim_sarima(n=144, model = list(ar=c(1.2,-0.8), ma=0.4, sar=0.3, sma=0.7,
                               iorder=1, siorder=1, nseasons=12))
    set.seed(1234)
    moB <- sim_sarima(n=144, model = list(ar=c(1.2,-0.8), ma=0.4, sar=0.3, sma=0.7,
                               iorder=1, siorder=1, nseasons=12, sigma2 = 1))
    expect_equal(moA, moB)

    fun.forecast(ar = 0.5, n = 10)

})
