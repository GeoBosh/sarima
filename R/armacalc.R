## Do not edit this file manually.
## It has been automatically generated from *.org sources.

armaccf_xe <- function(model, lag.max = 1){
    phi <- model$ar
    theta <- model$ma
        ## 2017-10-16 accept also model$sigma2
        ##     todo: eventually remove model$sigmasq
    sigmasq <- model$sigmasq
    if(is.null(sigmasq))
        sigmasq <- model$sigma2

    p <- length(phi)
    q <- length(theta)

    lag.max <- max(lag.max, max(p,q))

    Rxe <- numeric(lag.max + 1)
    Rxe[1] <- sigmasq
    for(lag in seq(length = q)){ # TODO: this seems to assume p>q  !!!
        ind <- lag + 1
        minkp <- min(lag,p)
        Rxe[ind] <- sum(phi[1:minkp] * Rxe[lag:(lag - minkp + 1)]) + theta[lag] * sigmasq
    }

    if(p > q){  ## q, ..., min(p, lag.max) but this is always p, see above
        for(lag in (q + 1):p){
            ind <- lag + 1
            Rxe[ind] <- sum(phi[1:lag] * Rxe[lag:1])
        }
    }

    if(lag.max > p){
        for(lag in (p + 1):lag.max){
            ind <- lag + 1
            Rxe[ind] <- sum(phi[1:p] * Rxe[lag:(lag - p + 1)])
        }
    }

    term0 <- Rxe[1] + sum(theta * Rxe[ seq(from = 2, length = q)] )

    list(Rxe = Rxe, term0 = term0)
}

armaacf <- function(model, lag.max, compare = FALSE){
    xe <- armaccf_xe(model, lag.max)
    Rxe <- xe$Rxe
    term0 <- xe$term0

    phi <- model$ar
    p <- length(phi)

    acrf <- ARMAacf(model$ar, model$ma, lag.max)
    R0 <-  term0  / (1 - sum( phi * acrf[seq(from = 2, length = p)]))
    res <- acrf * R0

    if(compare){
        ## 2017-10-16 accept also model$sigma2
        ##     todo: eventually remove model$sigmasq
        sigma2 <- model$sigmasq
        if(is.null(sigma2))
            sigma2 <- model$sigma2
        res2 <- tacvfARMA(model$ar, - model$ma, lag.max, sigma2)
        ## zap small (relative to maximum before differencing) differences
        zappeddif <- zapsmall(c(max(res, res2), res - res2))[-1]

        ## this checks that the autocorrelations from ARMAacf and tacvfARMA are the same
        ## if(any(res2/res2[1] != acrf))
        ##     browser()

        cbind(native = res, tacvfARMA = res2, difference = zappeddif)
    }else
        res
}

ar2Pacf <- function(phi){
    if((p <- length(phi)) <= 1L)
        return(phi)
    
    for(k in (p - 1L):1L){
        bk <- phi[k + 1L]  # TODO: check |bk| < 1
        phi[1L:k] <- (phi[1L:k] + bk * phi[k:1L]) / (1 - bk^2)
    }
    phi
}

.isInvertibleFilter <- function(phi){
    if((p <- length(phi)) == 0)
        return(TRUE)

    if(p > 1){
        for(k in (p - 1L):1L){
            bk <- phi[k + 1L]
            if(abs(bk) >= 1)
                return(FALSE)
            phi[1L:k] <- (phi[1L:k] + bk * phi[k:1L]) / (1 - bk^2)
        }
    }
    abs(phi[1]) < 1
}

pacf2Ar <- function(parcor){
    p <- length(parcor)
    if(p <= 1L)
        return(parcor)
    
    ## p >= 2
    phi <- parcor # TODO: as.vector(parcor) ?
    for(k in 1L:(p - 1L))
        phi[1L:k] <- phi[1L:k] - phi[k + 1L] * phi[k:1L]
    phi
}

pacf2ArWithJacobian <- function(parcor, asis = TRUE){
    p <- length(parcor)
    J <- diag(p)
    phi <- parcor

    if(p >= 2)
        for(k in 1L:(p - 1L)){
            ## derivatives - row i contains d phi_i/d beta_j, j = 1, ...
            ## TODO: write tests
            ## 2017-12-21 was (last term change):
            ##     J[1L:k, 1L:k] <- J[1L:k, 1L:k] - phi[k + 1L] * J[1L:k, k:1L]
            J[1L:k, 1L:k] <- J[1L:k, 1L:k] - phi[k + 1L] * J[k:1L, 1L:k]

            ## this should be done before updating phi[]:
            J[1L:k, k + 1L] <- - phi[k:1L]

            ## 2017-12-21 this was before the assignments to J[]:
            phi[1L:k] <- phi[1L:k] - phi[k + 1L] * phi[k:1L]
        }

    ## TODO: think about a consistent scheme for naming:
    if(asis)
        list(phi = phi, J = J)
    else
        list(phi = - phi, J = - J)
}

hessian2vcov <- function(hessian, n, J){
   ## Y = JX; vcov(X) = (hessian * n)^(-1) 
   ## vcov(Y) = J vcov(X) J' = J (hessian * n)^(-1) J'
   J %*% solve(hessian * n) %*% t(J)
}

dbind <- function(...){
    blocks <- plain_list(...)
    if(length(blocks) == 0)
        return(matrix(0, 0, 0))
                                  # d is a 2 by n matrix
    d <- sapply(blocks, function(x){if(is.matrix(x)) dim(x) else c(length(x), 1)})

    res <- matrix(0, nrow = sum(d[1, ]), ncol = sum(d[2, ]))
    m <- n <- 0
    for(i in seq_along(blocks)){
        ## should work if d[1, i] = 0 and/or d[2,i] = 0
        res[m + seq_len(d[1, i]), n + seq_len(d[2, i])] <- blocks[[i]]
         m <- m + d[1, i]
        n <- n + d[2, i]
    }

    res
}

diag_bind <- function(...){
    blocks <- list()
    d <- rapply(list(...), function(x){ 
                               ## 2020-02-22 was: res <<- c(blocks, list(x))
                               blocks <<- c(blocks, list(x))
                               if(is.matrix(x)) dim(x) else c(length(x), 1)
                           }
               )
    d <- matrix(d, nrow = 2)

    res <- matrix(0, nrow = sum(d[1, ]), ncol = sum(d[2, ]))
    m <- n <- 0
    for(i in seq_along(blocks)){
        ## should work if d[1, i] = 0 and/or d[2,i] = 0, as well
        res[m + seq_len(d[1, i]), n + seq_len(d[2, i])] <- blocks[[i]]
        m <- m + d[1, i]
        n <- n + d[2, i]
    }

    res
}

plain_list <- function(...){  # , .drop.null = FALSE
    object <- list(...)

    res <- list()
    rapply(object, function(x){ res <<- c(res, list(x)); NULL }, how = "list")
        # if(.drop.null)
        #     res[!sapply(res,is.null)]
        # else
    res
}

ltToeplitz <- function(x){
    m <- toeplitz(x)
    m[row(m) - col(m) < 0] <- 0
    m
}

utToeplitz <- function(x){
    m <- toeplitz(x)
    m[row(m) - col(m) > 0] <- 0
    m
}

## ARMA, SP convention for signs
.FisherInfo <- function(phi = numeric(0), theta = numeric(0)){
    n <- length(phi)
    m <- length(theta)
    q <- max(n, m)

    if(n > 0){
        if(n < m)
            phi <- c(phi, rep(0, m - n))
        A1 <- ltToeplitz(c(1, phi[-q]))
        A2 <- ltToeplitz(rev(phi))
        Rxx <- solve(A1 %*% t(A1) - A2 %*% t(A2))
        if(m == 0)
            return(Rxx)
        
    }

    if(m > 0){
        if(m < n)
            theta <- c(theta, rep(0, n - m))
        C1 <- ltToeplitz(c(1, theta[-q]))
        C2 <- ltToeplitz(rev(theta))
        Rzz <- solve(C1 %*% t(C1) - C2 %*% t(C2))
        if(n == 0)
            return(Rzz)
    }
    
    if(m == 0 && n == 0)
        return(matrix(nrow = 0, ncol = 0))

    Rzx <- solve(A1 %*% t(C1) - C2 %*% t(A2))

    rbind( cbind(Rxx[1:n, 1:n, drop = FALSE], -t(Rzx[1:m, 1:n, drop = FALSE])),
           cbind(-Rzx[1:m, 1:n, drop = FALSE], Rzz[1:m, 1:m, drop = FALSE])    )
}



## seasonal ARMA, SP convention for signs
.calF2 <- function(alpha, alphatilde, s){
    p <- length(alpha)
    P <- length(alphatilde)
    if(p == 0)
        return(matrix(nrow = 0, ncol = P))
    else if(P == 0)
        return(matrix(nrow = p, ncol = 0))

    ## psi_i psi_{1-p}, ..., psi_{-1}, psi_{0}, psi_1, ... psi_{Ps + p}
    psi <- numeric(p + P * s + p)
    psi[(1-p):(-1) + p ] <- 0 # for clarity
    psi[0 + p] <- 1
    for(i in 1:((P * s) + p)){
        psi[i + p] <- - sum(alpha * psi[(i + p - 1):(i + p - p)])
    }

    ## g_{1-p}, ..., g_0, g_1, ..., g_{p-1}
    g <- numeric(2 * p + 1)
    baseind <- (1:P) * s + p
    for(i in (1-p):(p-1)){
        g[i+p] <- sum(alphatilde * psi[baseind + i])
    }

    ## G
    G <- matrix(0, nrow = p, ncol = p)
    ind <- 0:(1 - p) + p # for 1st column
    G[ , 1] <- g[ind]
    if(p > 1){
        for(j in 2:p){
            ind <- ind + 1
            curcol <- g[ind]
            for(i in 1:(j - 1)){
                curcol <- curcol + alpha[i] * g[ind - i]
            }
            G[ , j] <- curcol
        }
    }

    ## (I + G)^(-1) => 1st column is H0 = (h_0, h_{-1}, ..., h_{1-p})
    I <- diag(nrow(G))
    H0 <- solve(I + G)[ , 1]
    
    ## use h0 to compute H1 = (h_1, ..., h_{Ps - p})
    ## H = c(H0, H1), h_i is in H[i+p] !!!
    H <- c(rev(H0), numeric(P * s - 1))
    for(i in (p + 1):length(H)){
        H[i] <- -sum(H[(i - 1):(i - p)]  * alpha)
    }

    ## F_2
    ind <- .col(c(p, P)) * s - .row(c(p, P)) + p # '+ p' since h_i is in H[i+p]
    res <- matrix(H[ind], nrow = p, ncol = P) # ncol is redundant but makes the  intent more clear
    res
}

## ARMA, SP convention for signs
.FisherInfoSarma <- function(phi = numeric(0), theta = numeric(0), sphi = numeric(0), 
                             stheta = numeric(0), nseasons = NA_real_){
    if(!.isInvertibleFilter(-phi)) # -phi since '-' convention there, but "-" in .isInvertibleFilter
        stop("phi is not causal")
    if(!.isInvertibleFilter(-sphi))
        stop("sphi is not causal")
    if(!.isInvertibleFilter(-theta))
        stop("theta is not invertible")
    if(!.isInvertibleFilter(-stheta))
        stop("stheta is not invertible")

    p <- length(phi)
    q <- length(theta)
    P <- length(sphi)
    Q <- length(stheta)
    if(is.na(nseasons) && (P > 0 || Q > 0))
        stop("When there are seasonal components argument 'nseasons' is mandatory")



    res <- matrix(0, nrow = p + P + q + Q, ncol = p + P + q + Q)

    wrk <- .FisherInfo(phi, theta)

    if(p > 0){
        res[1:p, 1:p] <- wrk[1:p, 1:p]
        if(q > 0){
            res[1:p, (p+P+1):(p+P+q)] <- wrk[1:p, (p+1):(p+q)]
            res[(p+P+1):(p+P+q), 1:p] <- wrk[(p+1):(p+q), 1:p]
        }
    }
    if(q > 0)
        res[(p+P+1):(p+P+q), (p+P+1):(p+P+q)] <- wrk[(p+1):(p+q), (p+1):(p+q)]

    wrk <- .FisherInfo(sphi, stheta)
    if(P > 0){
        res[(p+1):(p+P), (p+1):(p+P)] <- wrk[1:P, 1:P]
        if(Q > 0){
            res[(p+1):(p+P), (p+P+q+1):(p+P+q+Q)] <- wrk[1:P, (P+1):(P+Q)]
            res[(p+P+q+1):(p+P+q+Q), (p+1):(p+P)] <- wrk[(P+1):(P+Q), 1:P]
        }
    }
    if(Q > 0)
        res[(p+P+q+1):(p+P+q+Q), (p+P+q+1):(p+P+q+Q)] <- wrk[(P+1):(P+Q), (P+1):(P+Q)]

    ## F0_a  <- .FisherInfo(phi) # .calF0(phi)
    ## F0_b  <- .FisherInfo(theta) # .calF0(theta)
    ## F0_A  <- .FisherInfo(sphi) # .calF0(sphi)
    ## F0_B  <- .FisherInfo(stheta) # .calF0(stheta)
    ## 
    ## F1_ab <- .FisherInfo(phi, theta) # .calF1(phi, theta)
    ## F1_AB <- .FisherInfo # .calF1(sphi, stheta)
    
    F2_aA <- .calF2(phi, sphi, nseasons)
    F2_aB <- .calF2(phi, stheta, nseasons)
    F2_bA <- .calF2(theta, sphi, nseasons)
    F2_bB <- .calF2(theta, stheta, nseasons)

    if(length(F2_aA) > 0){
        res[1:p, (p+1):(p+P)] <- F2_aA
        res[(p+1):(p+P), 1:p] <- t(F2_aA)
    }
    
    if(length(F2_aB) > 0){
        res[1:p, (p+P+q+1):(p+P+q+Q)] <- -F2_aB
        res[(p+P+q+1):(p+P+q+Q), 1:p] <- -t(F2_aB)
    }
    
    if(length(F2_bA) > 0){
        res[(p+1):(p+P), (p+P+1):(p+P+q)] <- -t(F2_bA)
        res[(p+P+1):(p+P+q), (p+1):(p+P)] <- -F2_bA
    }
    
    if(length(F2_bB) > 0){
        res[(p+P+1):(p+P+q), (p+P+q+1):(p+P+q+Q)] <- F2_bB
        res[(p+P+q+1):(p+P+q+Q), (p+P+1):(p+P+q)] <- t(F2_bB)
    }
    
    ## rbind(
    ##     cbind(   F0_a,      F2_aA,   -F1_ab,  -F2_aB),
    ##     cbind( t(F2_aA),    F0_A,  -t(F2_bA), -F1_AB),
    ##     cbind(-t(F1_ab),   -F2_bA,    F0_b,    F2_bB),
    ##     cbind(-t(F2_aB), -t(F1_AB), t(F2_bB),  F0_B )  )

    rownames(res) <- colnames(res) <- 
        paste0(c(rep("phi_", length(phi)), rep("Phi_", length(sphi)),
                 rep("theta_", length(theta)), rep("Theta_", length(stheta))),
               c(seq_len(length(phi)), seq_len(length(sphi)),
                 seq_len(length(theta)), seq_len(length(stheta))) )
    attr(res, "nseasons") <- nseasons

    res
}

## as above but more manageable
.FisherInfoSarma_rbind <- function(phi = numeric(0), theta = numeric(0), sphi = numeric(0), 
                             stheta = numeric(0), nseasons = NA_real_){
    p <- length(phi)
    q <- length(theta)
    P <- length(sphi)
    Q <- length(stheta)
    if(is.na(nseasons) && (P > 0 || Q > 0))
        stop("When there are seasonal components argument 'nseasons' is mandatory")

    res <- matrix(0, nrow = p + P + q + Q, ncol = p + P + q + Q)

    wrk <- .FisherInfo(phi, theta)

    F0_a  <- if(p > 0)    
                 wrk[1:p, 1:p] # .FisherInfo(phi) # .calF0(phi)
             else
                 matrix(nrow = 0, ncol = 0)
    F0_b  <- if(q > 0)
                 wrk[(p+1):(p+q), (p+1):(p+q)]  # .FisherInfo(theta) # .calF0(theta)
             else
                 matrix(nrow = 0, ncol = 0)

    F1_ab <- if(p == 0 || q == 0)
                 matrix(nrow = p, ncol = q)
             else # note the '-'! (in cbind() this is negated again
                 - wrk[(p+1):(p+q), 1:p] # .FisherInfo(phi, theta) # .calF1(phi, theta)
    
    wrk2 <- .FisherInfo(sphi, stheta)

    F0_A  <- if(P > 0)    
                 wrk2[1:P, 1:P] #  .FisherInfo(sphi) # .calF0(sphi)
             else
                 matrix(nrow = 0, ncol = 0)
    F0_B  <- if(Q > 0)
                 wrk2[(P+1):(P+Q), (P+1):(P+Q)]  # .FisherInfo(stheta) # .calF0(stheta)
             else
                 matrix(nrow = 0, ncol = 0)

    F1_AB <- if(P == 0 || Q == 0)
                 matrix(nrow = P, ncol = Q)
             else # note the '-'! (in cbind() this is negated again
                 - wrk2[(P+1):(P+Q), 1:P] # .FisherInfo # .calF1(sphi, stheta)
    
    F2_aA <- .calF2(phi, sphi, nseasons)
    F2_aB <- .calF2(phi, stheta, nseasons)
    F2_bA <- .calF2(theta, sphi, nseasons)
    F2_bB <- .calF2(theta, stheta, nseasons)

    res <- rbind(
        cbind(   F0_a,      F2_aA,   -F1_ab,  -F2_aB),
        cbind( t(F2_aA),    F0_A,  -t(F2_bA), -F1_AB),
        cbind(-t(F1_ab),   -F2_bA,    F0_b,    F2_bB),
        cbind(-t(F2_aB), -t(F1_AB), t(F2_bB),  F0_B )  )

    rownames(res) <- colnames(res) <- 
        paste0(c(rep("phi_", length(phi)), rep("Phi_", length(sphi)),
                 rep("theta_", length(theta)), rep("Theta_", length(stheta))),
               c(seq_len(length(phi)), seq_len(length(sphi)),
                 seq_len(length(theta)), seq_len(length(stheta))) )
    attr(res, "nseasons") <- nseasons

    res
}

FisherInformation <- function(model, ...)
    UseMethod("FisherInformation")

FisherInformation.Arima <- function(model, ...){
    order <- model$arma
    p <- order[1]
    q <- order[2]
    P <- order[3]
    Q <- order[4]
    nseasons <- order[5]
    d <- order[6]
    D <- order[7]

    ## TODO: include the mean (named 'intercept' in Arima objects)
    co <- coef(model)
    ar <- co[seq_len(p)]
    ma <- co[p + seq_len(q)]
    sar <- co[p + q + seq_len(P)]
    sma <- co[p + q + P + seq_len(Q)]
    ## SP convention
    .FisherInfoSarma(-ar, ma, -sar, sma, nseasons)
}

FisherInformation.ArmaModel <- function(model, ...){
    co <- modelCoef(model, "SP")  # no seasonal components here
    .FisherInfoSarma(co$ar, co$ma)
}

setMethod("FisherInformation", "ArmaModel", FisherInformation.ArmaModel)

FisherInformation.SarimaModel <- function(model, ...){
         # TODO: this expands the polynomials. Is this on purpose?
         #       Doesn't seem intuitive.
         #     co <- modelCoef(model, "SP") 
     co <- modelCoef(model) # manually convert the ar-type coef to "SP":
    .FisherInfoSarma(-co$ar, co$ma, -co$sar, co$sma, nseasons = co$nseasons)
}

setMethod("FisherInformation", "SarimaModel", FisherInformation.SarimaModel)

spectrum <- function(x, standardize = TRUE, ...){
    UseMethod("spectrum")
}

spectrum.default <- function(x, standardize = TRUE, raw = TRUE, taper = 0.1, 
                                demean = FALSE, detrend = TRUE, ...){
    xname <- deparse(substitute(x))

    if(raw){ # completely raw unless user has requested otherwise
        if(missing(taper))   taper   <- 0
        if(missing(demean))  demean  <- TRUE
        if(missing(detrend)) detrend <- FALSE
    }

    if(standardize){
        x <- (x - mean(x)) / sd(x)
        demean <- FALSE
    }
    res <- stats::spectrum(x, plot = FALSE, taper = taper, demean = demean, 
                                            detrend = detrend, ...)

    if(standardize) # stats::spectrum sets it but x is manipulated above in this case
        res$series <- xname
    
    res$standardized <- standardize
    res$nseasons <- frequency(x)
    res$freq.range <- c(-1, 1) * frequency(x) %/% 2 
    class(res) <- c("genspec", class(res))

    res
}

.local_maxima <- function(x){
    ## TODO: currently not handling ties properly;  NA's not considered
    n <- length(x)
    c(x[1] >= x[2],
      (x[2:(n - 1)] >= x[1:(n - 2)]) & (x[2:(n-1)] >= x[3:n]),
      x[n] >= x[n-1] )
}

.local_minima <- function(x){
    ## TODO: currently not handling ties properly;  NA's not considered
    n <- length(x)
    c(x[1] <= x[2],
      (x[2:(n - 1)] <= x[1:(n - 2)]) & (x[2:(n-1)] <= x[3:n]),
      x[n] <= x[n-1] )
}

format.genspec <- function (x, n.head = length(x$freq), sort = TRUE, ...){
    stopifnot(length(sort) == 1)

    n.ind1 <- numeric(0)
    mat <- if(is.logical(sort)){
               if(sort){
                   ind <- order(x$spec, decreasing = TRUE)
                   cbind(freq = x$freq[ind], spec = x$spec[ind])
               }else{
                   cbind(freq = x$freq, spec = x$spec)
               }
           }else if(is.character(sort) && sort == "max"){
               maxima_flags <- .local_maxima(x$spec)
               max_freq <- x$freq[maxima_flags]
               max_spec <- x$spec[maxima_flags]
               ind1 <- order(max_spec, decreasing = TRUE)
               max_freq <- max_freq[ind1]
               max_spec <- max_spec[ind1]
               n.ind1 <- length(ind1)

               rest_freq <- x$freq[!maxima_flags]
               rest_spec <- x$spec[!maxima_flags]
               ind2 <- order(rest_spec, decreasing = TRUE)
               rest_freq <- rest_freq[ind2]
               rest_spec <- rest_spec[ind2]

               cbind(freq = c(max_freq, rest_freq), spec = c(max_spec, rest_spec))
           }else
               stop("invalid value of argument 'sort'")
    
    frac <- mat[ , "spec"] / sum(mat[ , "spec"])
    cum.frac <- cumsum(frac)
    mat <- cbind(mat, "% Total" = frac, "Cum. %" = cum.frac)
    if(length(n.ind1) > 0){
        ranks <- c(1:n.ind1, rep(NA, nrow(mat) - n.ind1))
        mat <- cbind(mat, ranks = ranks)
    }
    sort.method <- if(isTRUE(sort))
                       "decreasing magnitudes"
                   else if(identical(sort, FALSE))
                       "none"
                   else
                       "local maxima first"
    tab <- "    "	       
    c(paste0("Estimated spectral density"),
      paste0(tab, "series: ", x$series),
      paste0(tab, "method: ", x$method),
      paste0(tab, "nseasons: ", x$nseasons),
      paste0(tab, "frequency range: (", x$freq.range[1], ",", x$freq.range[2], "]"),
      "",
      paste0(tab, "sort method for the table: ", sort.method),
      "",
      paste0(tab, capture.output(print(head(mat, n.head), ...)))
      )
}

print.genspec <- function (x, n.head = min(length(x$spec), 6), sort = TRUE, ...) {
    cat(format(x, n.head = n.head, sort = sort, ...), sep = "\n")
    if(length(list(...)) == 0 && missing(n.head) && missing(sort) )
        plot(x)
    invisible(x)
}

spectrum.function <- function(x, standardize = TRUE, param = list(), ...){
    e <- new.env(parent = environment(x))
    e$standardize <- standardize
    e$.fun <- x
    environment(e$.fun) <- e

    for(nam in names(param))
        e[[nam]] <- param[[nam]]
    freq <- standardize <- .fun <- NULL ## otherwise 'R CMD check' may complain

    f <- as.function(alist(freq = , .fun(freq)), envir = e) # , standardize = standardize
    
    new("Spectrum", f, call = sys.call(), model = x)
}

## BD convention
.spdArma <- function(ar = numeric(0), ma = numeric(0), freq, sigma2, standardize){
    p <- length(ar)
    q <- length(ma)
    m <- max(p,q)

    if(missing(freq)){
        n <- max(512, p, q)  # TODO: arbitrary constant here: 512
        freq <- seq(0, 0.5, length.out = n)
    }else
        n <- length(freq)

    if(standardize) # cancels out when dividing by acvf[0] below
        sigma2 <- 1
    else if(is.na(sigma2))
        stop("sigma2 is NA but must be a positive number when standardize = FALSE")

    if(m == 0)
        return( list(freq = freq, spec = rep(sigma2, n), ar = ar, ma = ma, sigma2 = sigma2) )
    
    tbl <- (2 * (1:m)) %o% freq  # (m,n)
    co <- cospi(tbl)
    si <- sinpi(tbl)

    numer <- denom <- 1
    if(p > 0)
        denom <- (1 - drop(ar %*% co[1:p, ]))^2 + (drop(ar %*% si[1:p, ]))^2
    if(q > 0)
        numer <- (1 + drop(ma %*% co[1:q, ]))^2 + (drop(ma %*% si[1:q, ]))^2

    spec <- numer / denom

    spec <- if(standardize)
                ## sigma2 doesn't matter in this case
                spec / autocovariances(ArmaModel(ar = ar, ma = ma, sigma2 = 1), maxlag = 0)[]
            else
                spec <- sigma2 * spec

    list(freq = freq, spec = spec, ar = ar, ma = ma, sigma2 = sigma2)
}

spectrum.ArmaModel <- function(x, standardize = TRUE, ...){
    co <- modelCoef(x, "BD")  # no seasonal components here
    # wrk <- .spdArma(co$ar, co$ma, sigma2 = x@sigma2, standardize = standardize, ...)
    # new("Spectrum", freq = wrk$freq, spec = wrk$spec, model = x)
    new("ArmaSpectrum", ar = co$ar, ma = co$ma, sigma2 = sigmaSq(x), model = x)
}

setMethod("spectrum", "ArmaModel", spectrum.ArmaModel)

spectrum.SarimaModel <- function(x, standardize = TRUE, ...){
    ## co <- modelCoef(x, "ArmaModel") 
    pall <- modelPoly(x)
    ar <- -coef(pall$arpoly * pall$sarpoly)[-1] # BD convention
    ma <-  coef(pall$mapoly * pall$smapoly)[-1]
    # wrk <- .spdArma(co$ar, co$ma, sigma2 = x@sigma2, standardize = standardize, ...)
    # new("Spectrum", freq = wrk$freq, spec = wrk$spec, model = x)

    new("ArmaSpectrum", ar = ar, ma = ma, sigma2 = x@sigma2, model = x)
}

setMethod("spectrum", "SarimaModel", spectrum.SarimaModel)

## Arima is produced by stats::arima() and others
spectrum.Arima <- function(x, standardize = TRUE, ...){
    obj <- as.SarimaModel(x)
    # co <- modelCoef(obj) 
    pall <- modelPoly(obj)
    ar <- -coef(pall$arpoly * pall$sarpoly)[-1] # BD convention
    ma <-  coef(pall$mapoly * pall$smapoly)[-1]
    # wrk <- .spdArma(ar, ma, sigma2 = x$sigma2, standardize = standardize)
    # new("Spectrum", freq = wrk$freq, spec = wrk$spec, model = x)
    new("ArmaSpectrum", ar = ar, ma = ma, sigma2 = x$sigma2, model = x)
}

setMethod("spectrum", "ArmaModel", spectrum.ArmaModel)
