#' tr_calc_townsend
#'
#' Calculate Townsend Material Deprivation scores for the specified geography.
#' Geographies are specified using the Nomis API format, and can be found using
#' tr_list_geographies()
#'
#' @param year a census year (2011, 2001, 1991, 1981)
#' @param geography the geography you wish to calculate Townsend scores for
#'
#' @return A tibble with census year, geography code, geography name, and results
#' @export
#'
#' @examples
#' tr_calc_townsend(2011, "TYPE480")
tr_calc_townsend <- function(year = NULL, geography = NULL) {

  # Check and clean year input
  tr_check_year(year)
  year <- as.integer(year)


  # Check and clean geography input
  if (is.null(geography)) {
    stop("Geography is not specified")
  }

}
