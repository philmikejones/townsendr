tr_check_year <- function(year = NULL) {

  if (is.null(year)) {
    stop("year is not specified")
  }

  year <- suppressWarnings(as.integer(year))  # check for errors next

  if (is.na(year)) {
    stop("year is not a number")
  }

  if (year != 2011L && year != 2001L && year != 1991 && year != 1981) {
    stop("year is not a census year")
  }

}
