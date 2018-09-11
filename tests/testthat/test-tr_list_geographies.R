context("tr_list_geographies()")

test_that("tr_list_geographies() returns correctly", {

  skip_on_cran()

  test = tr_list_geographies(2011)
  expect_true(tibble::is_tibble(test))

})
