test_that("functions in utils.R work ok", {
    expect_equal(.stats.format.perc(0.54321, 2), "54 %")
    expect_equal(.stats.format.perc(0.54321, 3), "54.3 %")
    expect_equal(.stats.format.perc(0.54321, 4), "54.32 %")
    expect_equal(.stats.format.perc(0.54321, 5), "54.321 %")

    expect_equal(.capturePrint(1:4), "[1] 1 2 3 4")

    mo <- lm(dist ~ speed, data = cars)
    expect_equal(diagOfVcov(mo), diag(vcov(mo)))
})
