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

    armaacf(list(ar = phi, ma = theta, sigma2 = sigma2), lag.max = 20, compare = TRUE)


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

    ## Fisher information for ARMA

## BD spec
## arma(2,2)
phi22 <- c(0.8, 0.1) 
theta22 <- -c(1.2, -0.6)
expect_equal(.FisherInfo(-phi22, theta22), InformationMatrixARMA(phi22, -theta22), check.attributes = FALSE)

phi21 <- c(0.8, 0.1) 
theta21 <- 0.6
## arma(2,1)
expect_equal(.FisherInfo(-phi21, theta21), InformationMatrixARMA(phi21, -theta21), check.attributes = FALSE)
## arma(1,2)
expect_equal(.FisherInfo(theta21, -phi21), InformationMatrixARMA(-theta21, phi21), check.attributes = FALSE)
## ar(2)
expect_equal(.FisherInfo(-phi21), InformationMatrixARMA(phi21), check.attributes = FALSE)
## ma(2)
expect_equal(.FisherInfo(theta = phi21), InformationMatrixARMA(theta = -phi21), check.attributes = FALSE)


phi11 <- 0.8 
theta11 <- 0.5
## arma(1,1)
expect_equal(.FisherInfo(-phi11, theta11), InformationMatrixARMA(phi11, -theta11), check.attributes = FALSE)
## ar(1)
expect_equal(.FisherInfo(-phi11), InformationMatrixARMA(phi11), check.attributes = FALSE)
## ma(1)
expect_equal(.FisherInfo(theta = theta11), InformationMatrixARMA(theta = -theta11), check.attributes = FALSE)

## ARMA(0,0);   ##  note: FitARMA::InformationMatrixARMA()  returns  numeric(0)
expect_equal(.FisherInfo(), matrix(nrow = 0, ncol = 0), , check.attributes = FALSE)
})


expect_equal(ltToeplitz(1:3), matrix(c(1,2,3, 0,1,2, 0,0,1), nrow = 3))
expect_equal(utToeplitz(1:3), matrix(c(1,2,3, 0,1,2, 0,0,1), nrow = 3, byrow = TRUE))

test_that("ARMA information matrix in armacalc.R is ok", {
## TODO: if you stop including .FisherInfoSarma_rbind in the package, remove corresponding
##       tests
expect_error(.FisherInfoSarma(c(-0.8, 0.1), 0.5, 0.8, 0.2)) # no nseasons but seas. comp. present
expect_error(.FisherInfoSarma_rbind(c(-0.8, 0.1), 0.5, 0.8, 0.2))

a <- .FisherInfoSarma(c(-0.8, 0.1), 0.5, 0.8, 0.2, nseasons = 4)
b <- .FisherInfoSarma_rbind(c(-0.8, 0.1), 0.5, 0.8, 0.2, nseasons = 4)
expect_equal(a,b)

## the non-seasonal part of the above
a <- .FisherInfoSarma(c(-0.8, 0.1), 0.5)
b <- .FisherInfoSarma_rbind(c(-0.8, 0.1), 0.5)
c <- .FisherInfo(c(-0.8, 0.1), 0.5)
expect_equal(a,b)
expect_equal(a,c, check.attributes = FALSE)
## this is uses BJ convention, negate coef's (the above use SP convention): 
d <- InformationMatrixARMA(-c(-0.8, 0.1), -0.5)
expect_equal(a,d, check.attributes = FALSE)
})

test_that("functions in armacalc.R work ok", {
expect_true(TRUE)
FisherInformation(ArmaModel(ma = 0.9, sigma2 = 1))
print(spectrum(ArmaModel(ma = 0.9, sigma2 = 1)))
spectrum(ArmaModel(ma = c(-1, 0.6), sigma2 = 1))
spectrum(ArmaModel(ar = 0.9, sigma2 = 1))
spectrum(ArmaModel(ar = c(1.5, -0.75), sigma2 = 1))
spectrum(ArmaModel(ar = 0.5, ma = -0.8, sigma2 = 1))
spectrum(new("SarimaModel", ar = 0.5, sar = 0.9, nseasons = 12, sigma2 = 1))
spectrum(new("SarimaModel", ma = -0.4, sma = -0.9, nseasons = 12, sigma2 = 1))

sarima1b <- new("SarimaModel", ar = 0.9, ma = 0.1, sar = 0.5, sma = 0.9, nseasons = 12, sigma2 = 1)
plot(spectrum(sarima1b))
show(spectrum(sarima1b, freq = 0:11/12))
FisherInformation(sarima1b)
set.seed(1234)
gwn <- ts(rnorm(1:128), frequency = 4)
sp.gwn <- spectrum(gwn)
sp.gwn
plot(sp.gwn)
print(spectrum(gwn), sort = TRUE)
print(spectrum(gwn), sort = FALSE)
print(spectrum(gwn), sort = "max")

fit0 <- arima(AirPassengers, order = c(0,1,1), seasonal = list(order = c(0,1,1), period = 12))
FisherInformation(fit0)
spectrum(fit0)
spectrum(as.SarimaModel(fit0))

print(spectrum(fit0), n = 1024)

a <- new("Spectrum", ar = -0.9)
tmp <- a()
print(a)
plot(a)
expect_error(plot(a, standardize = FALSE),
             "sigma2 is NA but must be a positive number when standardize = FALSE")
show(a)

b <- new("Spectrum", ar = -0.9, sigma2 = 1)
plot(b, standardize = FALSE) # now ok, sigma2 is set

## environment(a)
## parent.env(environment(a))

## white noise
sp.wn <- spectrum(ArmaModel(sigma2 = 2))
sp.wn
print(sp.wn)
print(sp.wn, standardize=FALSE)
show(sp.wn)

sp.wn2 <- spectrum(ArmaModel()) # sigma2 is NA here
print(sp.wn2, standardize = TRUE) # ok
expect_error(print(sp.wn2, standardize = FALSE))
})
