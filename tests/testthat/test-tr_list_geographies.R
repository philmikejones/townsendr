context("Test tr_list_geographies")

test_that("check year", {
  expect_error(tr_list_geographies(2012))
  expect_error(tr_list_geographies(NULL))
})

test_that("check year is correct", {
  expect_silent(tr_list_geographies(2011))
})

test = tr_list_geographies(2011)

test_that("Ouput is a data frame", {
  expect_is(tr_list_geog)
})
