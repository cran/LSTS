test_that("LS.whittle works", {
  lsw <- LS.whittle(
    series = malleco, start = c(1, 1, 1, 1),
    order = c(p = 1, q = 0), ar.order = 1, sd.order = 1, N = 180, n.ahead = 10
  )
  expect_equal(round(lsw$coef, 4), c(1.9793, -0.7406, 0.2225, -0.1004))
})
