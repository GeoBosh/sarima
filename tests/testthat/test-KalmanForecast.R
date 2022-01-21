library(sarima)
context("test that forecasting Kalman functions work OK")

data("sunspots")

train <- window(sunspots, start = 1749, end = 1919 + 11/12)
test <- window(sunspots, start = 1920, end = 1983 + 11/12)

fit <- sarima(train ~ 1 | ar(3) + sar(3, 4) + sma(12,1))

test_that("the forecast function works as in arima", {
    sar.twelvestep <- sarima_KalmanForecast(n.ahead = 12, mod = fit$model)
    ar.twelvestep <- KalmanForecast(n.ahead = 12, mod = fit$model)
    
    expect_equal(ar.twelvestep$pred, sar.twelvestep$pred, 1e-6)
    expect_equal(ar.twelvestep$var, sar.twelvestep$var, 1e-6)
})

test_that("the updating forecast function works OK", {
    sar.forecasts <- sarima_KalmanForeUp(test, n.ahead = 12, mod = fit$model)

    ar.forecasts <- NULL
    mod = fit$model
    for(i in seq_along(test)){
        x0 <- sarima_KalmanForecast(n.ahead = 12, mod = mod)
        ar.forecasts$pred <- c(ar.forecasts$pred, list(x0$pred))
        ar.forecasts$var <- c(ar.forecasts$var, list(x0$var))
        x0 <- sarima_KalmanRun(test[i], mod = mod, update = TRUE)
        mod <- attr(x0, "mod")
    }
    
    expect_equal(unlist(ar.forecasts$pred), unlist(sar.forecasts$pred), 1e-6)
    expect_equal(unlist(ar.forecasts$var), unlist(sar.forecasts$var), 1e-6)
})
