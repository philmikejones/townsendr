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
  expect_true(isTRUE(all.equal(
    colnames(dat), c(
      "geography_code", "geography_name", "CELL_NAME", "OBS_VALUE"
    )
  )))
})


context("tr_shape_data()")

test_that("incorrect input errors", {
  expect_error(
    tr_shape_data(c("dat1", "dat2")),
    msg = "tr_data supplied to tr_shape_data"
  )
})

dat = tr_shape_data(dat)
test_that("correct input is correctly processed", {
  expect_true(isTRUE(all.equal(
    colnames(dat), c(
      "geography_code", "geography_name", "car", "persons_per_room",
      "tenure", "unemployed"
    )
  )))

  expect_true(is.numeric(dat$car))
  expect_true(is.numeric(dat$persons_per_room))
  expect_true(is.numeric(dat$tenure))
  expect_true(is.numeric(dat$unemployed))
})


context("tr_calc_z()")

test_that("incorrect input errors", {
  expect_error(
    tr_calc_z(c("dat1", "dat2")),
    msg = "tr_data supplied to tr_calc_z()"
  )
})

dat = tr_calc_z(dat)
test_that("correct input returns z scores", {
  expect_true(isTRUE(all.equal(
    colnames(dat), c(
      "geography_code", "geography_name", "townsend"
    )
  )))

  expect_true(is.numeric(dat$townsend))
})
