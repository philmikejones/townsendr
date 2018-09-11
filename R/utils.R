#' @importFrom tibble tibble
#' @keywords internal
"_PACKAGE"


#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL


## quiets concerns of R CMD check re: the .'s that appear in pipelines
## See: https://github.com/STAT545-UBC/Discussion/issues/451#issuecomment-264598618
## I've add 'id' as this is also a global that the user does not have access to
if(getRversion() >= "2.15.1")  utils::globalVariables(c(".", "id"))


## tr_check_year function tests year input for multiple functions
tr_check_year <- function(year = NULL) {

  if (is.null(year)) {
    stop("year is not specified")
  }

  year <- suppressWarnings(as.integer(year))  # check for errors next

  if (is.na(year)) {
    stop("year is not a number")
  }

  if (year != 2011L && year != 2001L) {
    stop("year is not a supported census year")
  }

}
