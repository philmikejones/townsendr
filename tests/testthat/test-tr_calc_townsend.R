context("Test tr_calc_townsend")

test_that("Missing year returns an error", {
  expect_error(tr_calc_townsend(), "Census year is not specified")
})

test_that("Non census year returns an error", {
  expect_error(tr_calc_townsend(year = 2018L), "not a census year")
})

test_that("Missing geography returns an error", {
  expect_error(tr_calc_townsend(year = 2011L), "Geography is not specified")
})
