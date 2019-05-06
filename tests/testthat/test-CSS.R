library(sarima)
context("Fitting models using css")

test_that("the css method works OK for 'stationary' fits", {
    ## airpassengers data
    air.sarima <- sarima(log(AirPassengers) ~ 0 | i(1) + si(12,1) +
                             ma(1, c(-0.3)) + sma(12,1, c(-0.1)),
                         ss.method = "css")
    co.a.s <- coef(air.sarima)
    air.arima <- arima(log(AirPassengers), order = c(0, 1, 1),
                       seasonal = list(order = c(0, 1, 1), period = 12),
                       include.mean = FALSE, method = "CSS")
    co.a.a <- coef(air.arima)
    expect_lt(max(abs(co.a.s - co.a.a)), 0.05)
    ## lake huron data
    huron.sarima <- sarima(LakeHuron ~ 1 + t | ar(2), ss.method = "css")
    co.h.s <- coef(huron.sarima)
    huron.arima <- arima(LakeHuron, order = c(2,0,0),
                         xreg = time(LakeHuron) - 1920,
                         method = "CSS")
    co.h.a <- coef(huron.arima)

    expect_lt(max(abs(co.h.s[c("ar1", "ar2")] - co.h.a[c("ar1", "ar2")])), 0.02)

    ## TO GEORGI: Should I be concerned that these don't match exactly for
    ##     stationary cases?
    ##   We actually obtain closer estimates to ML methods
    ##   I think this is due to the relatively small number of observations (144)
})

test_that("the css method works OK for 'nonstationary' fits", {
    ## airplanes data
    air.u.sarima <- try(sarima(log(AirPassengers) ~ 0 | ma(1, c(-0.3), fixed = TRUE) +
                              sma(12,1, c(-0.1), fixed = TRUE) +
                              uar(13, c(rep(0,12), 1), fixed = 13, atanh.tr = TRUE),
                           ss.method = "css") )
    if(!inherits(air.u.sarima, "try-error")){
        air.u.arima <- arima(log(AirPassengers), order = c(13, 0, 1),
                         seasonal = list(order = c(0,0,1), period = 12),
                         fixed = c(rep(NA, 12), -1, 0.3, 0.1),
                         include.mean = FALSE, method = "CSS",
                         transform.pars = FALSE)
        ## TODO: on i386 optimx sometimes gives NaN's, for now don't compare in that case:
        expect_lt(abs(air.u.sarima$sigma2 - air.u.arima$sigma2), 1e-5)
    }
    ## simmed data
    set.seed(85)
    x1 <- arima.sim(model = list(order = c(1, 1, 0),
                                 seasonal = c(0, 1, 0),
                                 period = 12,
                                 ar = 0.5, sd = 0.1),
                    n = 5000)

    sim.u.sarima <- sarima(x1 ~ 0 | uar(13, c(rep(0,12), 1), fixed = 13, atanh.tr = TRUE) +
                               ar(1, 0.5, fixed = TRUE), ss.method = "css")
    sim.u.arima <- arima(x1 - 0.5 * lag(x1), order = c(13, 0, 0),
                         fixed = c(rep(NA, 12), -1),
                         include.mean = FALSE, method = "CSS",
                         transform.pars = FALSE)
    expect_lt(abs(sim.u.sarima$sigma2 - sim.u.arima$sigma2), 1.5e-4)
})

test_that("the two-stage estimation method works OK", {
    ## airplanes data
    air.u.sarima <- try( sarima(log(AirPassengers) ~ 0 | ma(1, c(-0.3), fixed = TRUE) +
                                    sma(12,1, c(-0.1), fixed = TRUE) +
                                    uar(13, c(rep(0,12), 1), fixed = 13, atanh.tr = TRUE),
                                ss.method = "css")
                        )
    ## TODO: on i386 optimx sometimes gives NaN's, for now don't compare in that case:
    if(!inherits(air.u.sarima, "try-error")){
        air.stat.sarima <- sarima(residuals(air.u.sarima) ~ 0 | ma(1) + sma(12,1),
                              ss.method = "sarima")
        air.u.arima <- arima(log(AirPassengers), order = c(13, 0, 1),
                         seasonal = list(order = c(0,0,1), period = 12),
                         fixed = c(rep(NA, 12), -1, 0.3, 0.1),
                         include.mean = FALSE, method = "CSS",
                         transform.pars = FALSE)
       air.stat.arima <- arima(residuals(air.u.arima), order = c(0, 0, 1),
                         seasonal = list(order = c(0,0,1), period = 12),
                         include.mean = FALSE, method = "ML")

        expect_lt(abs(air.stat.sarima$loglik - air.stat.arima$loglik), 0.4)
    }

###### JAMIE: 24/08/2018 I've removed this to speed up tests!
#    ## simmed data - ARIMA(1,1,0)(0,1,0)
#    set.seed(85)
#    x1 <- arima.sim(model = list(order = c(1, 1, 0),
#                                 seasonal = c(0, 1, 0),
#                                 period = 12,
#                                 ar = 0.5, sd = 0.1),
#                    n = 5000)
#    sim1.u.sarima <- sarima(x1 ~ 0 | uar(13, c(rep(0,12), 1), fixed = 13, atanh.tr = TRUE) +
#                               ar(1, 0.5, fixed = TRUE), ss.method = "css")
#    sim1.stat.sarima <- sarima(residuals(sim1.u.sarima) ~ 0 | ar(1),
#                              ss.method = "sarima")
#    sim1.u.arima <- arima(x1 - 0.5 * lag(x1), order = c(13, 0, 0),
#                         fixed = c(rep(NA, 12), -1),
#                         include.mean = FALSE, method = "css",
#                         transform.pars = FALSE)
#    sim1.stat.arima <- arima(residuals(sim1.u.arima), order = c(1, 0, 0),
#                            include.mean = FALSE, method = "ML")
#
#    expect_lt(abs(sim1.stat.sarima$loglik - sim1.stat.arima$loglik), 3)
#
    ## simmed data - ARIMA(2,0,1)(0,1,0)
    set.seed(85)
    x2 <- arima.sim(model = list(order = c(2, 0, 1),
                                 seasonal = c(0, 1, 0),
                                 period = 12,
                                 ar = c(0.5, 0.3), ma = c(0.2),  sd = 0.3), 
                    n = 2500)
    sim2.u.sarima <- sarima(x2 ~ 0 | uar(12, c(rep(0,11), -1), fixed = 12, atanh.tr = TRUE) +
                                ar(2, c(0.5, 0.3), fixed = TRUE) + ma(1, 0.2, fixed = TRUE),
                            ss.method = "css")
    sim2.stat.sarima <- sarima(residuals(sim2.u.sarima) ~ 0 | ar(2) + ma(1),
                               ss.method = "sarima")
    sim2.u.arima <- arima(x2 - 0.5 * lag(x2) - 0.3*lag(x2, 2),
                          order = c(12, 0, 1), fixed = c(rep(NA, 11), 1, -0.2),
                          include.mean = FALSE, method = "CSS",
                          transform.pars = FALSE)
    sim2.stat.arima <- arima(residuals(sim2.u.arima), order = c(2, 0, 1),
                             include.mean = FALSE, method = "ML")
    
    expect_lt(abs(sim2.stat.sarima$loglik - sim2.stat.arima$loglik), 3)
})
