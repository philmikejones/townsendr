context("tr_check_year()")

test_that("Incorrect input returns an error", {
  expect_error(tr_check_year(), "year is not specified")
  expect_error(tr_check_year("twenty-eleven", "year is not a number"))
  expect_error(tr_check_year(year = 2018L), "not a supported census year")
})

test_that("Correct years return silently", {
  expect_silent(tr_check_year(year = 2011L))
  expect_silent(tr_check_year(year = 2001L))
})


context("tr_check_geography()")

test_that("incorrect input returns an error", {
  expect_error(
    tr_check_geography(geography = NULL),
    "geography is not specified"
  )
  expect_error(
    tr_check_geography(geography = "regions"),
    "geography is not specified correctly"
  )
})
