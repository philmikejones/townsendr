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
#' tr_calc_townsend(2011, "TYPE499")
tr_calc_townsend <- function(year = NULL, geography = NULL) {

  # Check and clean year input
  tr_check_year(year)
  year <- as.integer(year)


  # check and clean geography input
  tr_check_geography(geography)
  geography <- as.character(geography)

  tr_data <- tr_get_nomis_data(year = year, geography = geography)
  tr_data <- tr_bind_data(tr_data)
  tr_data <- tr_label_data(tr_data)
  tr_data <- tr_shape_data(tr_data)
  tr_data <- tr_calc_z(tr_data)

  tr_data

}
