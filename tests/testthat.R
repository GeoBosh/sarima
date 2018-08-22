## Sys.setenv(R_TESTS="")
library(testthat)
library(sarima)

## splitting for TravisCI with valgrind:
test_check("sarima")
