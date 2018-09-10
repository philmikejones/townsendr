context("Test tr_calc_townsend")

test_that("Missing geography returns an error", {
  expect_error(tr_calc_townsend(year = 2011L), "Geography is not specified")
})
