#' tr_check_year
#'
#' Check a census year input. This is an internal function for checking user
#' inputs.
#'
#' @param year an input that can be converted to an integer year
#'
#' @return Returns silently or, if an incorrect year is specified, an error
#'
#' @examples
#' tr_check_year(2011)             # returns silently
#' tr_check_year(2012)             # returns an error
#' tr_check_year("2011")           # returns silently
#' tr_check_year("twenty eleven")  # returns an error
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
