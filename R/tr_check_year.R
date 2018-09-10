#' tr_check_year
#'
#' Check a census year input
#'
#' @param year an input that can be converted to an integer year
#'
#' @return Returns silently or, if an incorrect year is specified, an error
#'
#' @examples
#' tr_check_year(2011)  # returns silently
#' tr_check_year(2012)  # returns an error
tr_check_year <- function(year) {

  if (is.null(year)) {
    stop("Census year is not specified")
  }

  year <- as.integer(year)

  if (year != 2011L && year != 2001L && year != 1991 && year != 1981) {
    stop("Year is not a census year")
  }

}
