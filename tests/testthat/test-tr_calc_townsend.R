context("tr_get_nomis_data()")

dat = tr_get_nomis_data(year = 2011, geography = "TYPE499")

test_that("correct inputs return a list of tibbles", {
  expect_true(is.list(dat))

  test = lapply(dat, tibble::is_tibble)
  lapply(test, expect_true)
})


context("tr_bind_data()")

test_that("incorrect input errors", {
  tr_data = list("dat1", "dat2", "dat3")
  expect_error(
    tr_bind_data(tr_data),
    msg = "tr_data supplied to tr_prep_data() is not a list of 4 data frames"
  )

  tr_data = c("dat1", "dat2", "dat3", "dat4")
  expect_error(
    tr_bind_data(tr_data),
    msg = "tr_data supplied to tr_prep_data() is not a list of 4 data frames"
  )

  tr_data = list("dat1", "dat2", "dat3", "dat4")
  expect_error(
    tr_bind_data(tr_data),
    msg = "tr_data supplied to tr_prep_data() is not a list of 4 data frames"
  )
})

test_that("correct input returns data frame", {
  expect_s3_class(tr_bind_data(dat), c("tbl_df", "data.frame"))
})
