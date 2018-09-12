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

dat = tr_bind_data(dat)

test_that("correct input returns data frame", {
  expect_s3_class(dat, c("tbl_df", "data.frame"))
})


context("tr_label_data()")

test_that("incorrect input errors", {
  expect_error(
    tr_label_data(c("dat1", "dat2")), "not a data frame"
  )
})

dat = tr_label_data(dat)
test_that("correct input is correctly labelled", {
  expect_true(all.equal(
    colnames(dat), c(
      "geography_code", "geography_name", "CELL_NAME", "OBS_VALUE"
    )
  ))
})
