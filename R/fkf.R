## dummy function to avoid removing the FKF code from the package.
##
## to enable FKF, comment out this function and the entry for FKF in
## NAMESPACE. Also, add FKF to Imports in DESCRIPTION.
##
## TODO: if GKF is put on CRAN, it could be used instead.

fkf <- function(...){
    stop("FKF methods are not currently available\n since package FKF was archived from CRAN.")
}
