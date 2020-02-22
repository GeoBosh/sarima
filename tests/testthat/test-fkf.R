test_that("temporary disable FKF, see fkf.R", {
    expect_error(fkf(), "FKF methods are not currently available")
})
