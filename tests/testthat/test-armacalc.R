test_that("functions in armacalc.R work ok", {
    ## armaacf
    ##     TODO: this is a copy of an example in armaccf_xe.Rd.
    ##           Need a real test.
    z <- sqrt(sunspot.year)
    n <- length(z)
    p <- 9
    q <- 0
    ML <- 5
    out <- arima(z, order = c(p, 0, q))

    phi <- theta <- numeric(0)
    if (p > 0) phi <- coef(out)[1:p]
    if (q > 0) theta <- coef(out)[(p+1):(p+q)]
    zm <- coef(out)[p+q+1]
    sigma2 <- out$sigma2

    armaacf(list(ar = phi, ma = theta, sigma2 = sigma2), lag.max = 20)
    armaacf(list(          ma = 0.5, sigma2 = sigma2), lag.max = 20)

    ## pacf2Ar, ar2Pacf, pacf2ArWithJacobian
    expect_identical(pacf2Ar(numeric(0)), numeric(0))
    expect_identical(pacf2Ar(0.5), 0.5)
    arA <- pacf2Ar(c(0.5,0.5))

    expect_identical(ar2Pacf(numeric(0)), numeric(0))
    expect_identical(ar2Pacf(0.5), 0.5)
    ar2Pacf(arA)
    ## expect_equal(ar2Pacf(arA), c(0.5,0.5))

    pacf2ArWithJacobian(c(0.5,0.5))
    pacf2ArWithJacobian(c(0.5,0.5), asis = FALSE)


    ## dbind
    expect_equal(dbind(), matrix(0, 0, 0))
    expect_equal(dbind(1,2,3), diag(c(1,2,3)))

    ## diag_bind
    expect_equal(diag_bind(1,2,3), diag(c(1,2,3)))
    diag_bind(1, matrix(2, nrow = 2, ncol = 2), 3)

    ## plain_list
    li <- plain_list(1, list(2, list(3)), list(4, list(5, list(6))))
    expect_equal(length(li), 6)
    expect_equal(li, as.list(1:6))

})
