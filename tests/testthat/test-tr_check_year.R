context("tr_check_year()")

test_that("Missing year returns an error", {
  expect_error(tr_check_year(), "Census year is not specified")
})

test_that("Non census year returns an error", {
  expect_error(tr_check_year(year = 2018L), "not a census year")
})

test_that("non-integer year returns an error", {
  expect_error(tr_check_year("twenty-eleven", "year is not a number"))
})
