## Sys.setenv(R_TESTS="")
library(testthat)
library(sarima)

## splitting for TravisCI with valgrind:
test_check("sarima", filter = "^[aAf]")
test_check("sarima", filter = "^sarima_")
test_check("sarima", filter = "^sarima$")
test_check("sarima", filter = "^sarima-")

