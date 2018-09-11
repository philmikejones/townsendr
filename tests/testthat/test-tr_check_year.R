context("tr_check_year()")

test_that("Incorrect input returns an error", {
  expect_error(tr_check_year(), "year is not specified")
  expect_error(tr_check_year("twenty-eleven", "year is not a number"))
  expect_error(tr_check_year(year = 2018L), "not a census year")
})
