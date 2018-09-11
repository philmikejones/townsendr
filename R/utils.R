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
## https://github.com/STAT545-UBC/Discussion/issues/451#issuecomment-264598618
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


## Check geography input as argument to various function
tr_check_geography <- function(geography = NULL) {

  if (is.null(geography)) {
    stop("geography is not specified")
  }

  geography <- as.character(geography)

  if (!grepl("TYPE[0-9].+", geography)) {
    stop(
      "geography is not specified correctly.
    List geographies with tr_list_geographies()
    Specify geography as an `id`"
    )
  }

}


## Download required data from nomis
tr_get_nomis_data <- function(year = NULL, geography = NULL) {

  tr_check_year(year)
  year <- as.integer(year)

  tr_check_geography(geography)
  geography <- as.character(geography)

  nomis_ids <- nomis_ids[nomis_ids$year == year, ]

  tr_data <- lapply(nomis_ids$id, function(id) {
    nomisr::nomis_get_data(
      id = id,
      geography = geography,
      measures = 20301,
    )
  })

  tr_data

}

# car <- nomisr::nomis_get_data(
#   id = nomis_ids$id[nomis_ids$year == year & nomis_ids$name == "car"],
#   geography = geography,
#   measures = 20301,
#   select = c(
#     "GEOGRAPHY_CODE", "GEOGRAPHY_NAME", "CELL_NAME", "OBS_VALUE",
#     "RURAL_URBAN_NAME"
#   )
# )
#
# car <-
#   car %>%
#   dplyr::filter(
#     RURAL_URBAN_NAME == "Total",
#     CELL_NAME == "No cars or vans in household"
#   ) %>%
#   dplyr::mutate(CELL_NAME = "car") %>%
#   dplyr::select(GEOGRAPHY_CODE, GEOGRAPHY_NAME, CELL_NAME, OBS_VALUE)
#
#
# persons_per_room <- nomisr::nomis_get_data(
#   id = nomis_ids$id[nomis_ids$year == year &
#                       nomis_ids$name == "persons_per_room"],
#   geography = geography,
#   measures = 20301,
#   select = c(
#     "GEOGRAPHY_CODE", "GEOGRAPHY_NAME", "C_PPROOMHUK11_NAME", "OBS_VALUE",
#     "RURAL_URBAN_NAME"
#   )
# )
#
# persons_per_room <-
#   persons_per_room %>%
#   dplyr::filter(RURAL_URBAN_NAME == "Total") %>%
#   dplyr::filter(
#     stringr::str_detect(
#       C_PPROOMHUK11_NAME,
#       "Over 1.0 and up to 1.5 persons per room|Over 1.5 persons per room"
#     )
#   ) %>%
#   dplyr::group_by(GEOGRAPHY_CODE, GEOGRAPHY_NAME) %>%
#   dplyr::summarise_if(is.numeric, sum) %>%
#   dplyr::ungroup() %>%
#   dplyr::mutate(CELL_NAME = "persons_per_room") %>%
#   dplyr::select(GEOGRAPHY_CODE, GEOGRAPHY_NAME, CELL_NAME, OBS_VALUE)
#
#
# tenure <- nomisr::nomis_get_data(
#   id = nomis_ids$id[nomis_ids$year == year & nomis_ids$name == "tenure"],
#   geography = geography,
#   measures = 20301,
#   select = c(
#     "GEOGRAPHY_CODE", "GEOGRAPHY_NAME", "CELL_NAME", "OBS_VALUE",
#     "RURAL_URBAN_NAME"
#   )
# )
#
# tenure <-
#   tenure %>%
#   dplyr::filter(RURAL_URBAN_NAME == "Total") %>%
#   dplyr::filter(
#     CELL_NAME == "Social rented" |
#       CELL_NAME == "Private rented" |
#       CELL_NAME == "Living rent free"
#   ) %>%
#   dplyr::group_by(GEOGRAPHY_CODE, GEOGRAPHY_NAME) %>%
#   dplyr::summarise_if(is.numeric, sum) %>%
#   dplyr::ungroup() %>%
#   dplyr::mutate(CELL_NAME = "tenure") %>%
#   dplyr::select(GEOGRAPHY_CODE, GEOGRAPHY_NAME, CELL_NAME, OBS_VALUE)
#
#
# unemployed <- nomisr::nomis_get_data(
#   id = nomis_ids$id[nomis_ids$year == year & nomis_ids$name == "unemployed"],
#   geography = geography,
#   measures = 20301,select = c(
#     "GEOGRAPHY_CODE", "GEOGRAPHY_NAME", "CELL_NAME", "OBS_VALUE",
#     "RURAL_URBAN_NAME"
#   )
# )
#
# unemployed <-
#   unemployed %>%
#   dplyr::filter(RURAL_URBAN_NAME == "Total") %>%
#   dplyr::filter(CELL_NAME == "Economically active: Unemployed") %>%
#   dplyr::mutate(CELL_NAME = "unemployed") %>%
#   dplyr::select(GEOGRAPHY_CODE, GEOGRAPHY_NAME, CELL_NAME, OBS_VALUE)
