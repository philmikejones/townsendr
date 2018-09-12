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
## added 'id' as this is also a global that the user does not have access to
if (getRversion() >= "2.15.1") {
  utils::globalVariables(c(
    ".", "id", "CELL_NAME", "OBS_VALUE",
    "GEOGRAPHY_CODE", "geography_code",
    "GEOGRAPHY_NAME", "geography_name",
    "car", "persons_per_room", "tenure", "unemployed"
  ))
}


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


tr_bind_data <- function(tr_data) {

  if (length(tr_data) != 4L) {
    stop("tr_data supplied to tr_prep_data() is not a list of 4 data frames")
  }

  if (!is.list(tr_data)) {
    stop("tr_data supplied to tr_prep_data() is not a list of 4 data frames")
  }

  for (i in seq_along(tr_data)) {
    if (!(is.data.frame(i) | tibble::is_tibble(i))) {
      stop("tr_data supplied to tr_prep_data() is not a list of 4 data frames")
    }
  }

  tr_data <- lapply(tr_data, function(x) {

    # nomis api returns urban/rural data; just want total
    x <- x[x$RURAL_URBAN_NAME == "Total", ]

    # normally 'CELL_NAME' is returned; persons_per_room returns this column
    # as 'C_PPROOMHUK11_NAME'; rename it for consistency
    colnames(x) = sub("C_PPROOMHUK11_NAME", "CELL_NAME", colnames(x))

    x <- x[, c("GEOGRAPHY_CODE", "GEOGRAPHY_NAME", "CELL_NAME", "OBS_VALUE")]

    x

  })

  tr_data <- do.call(rbind, tr_data)

  tr_data

}


tr_label_data <- function(tr_data) {

  if (!(tibble::is_tibble(tr_data) | is.data.frame(tr_data))) {
    stop("tr_data supplied to tr_label_data() is not a data frame")
  }

  # Remove the England and Wales total row, if present
  tr_data <- tr_data[tr_data$GEOGRAPHY_NAME != "England and Wales", ]

  tr_data <-
    tr_data %>%
    dplyr::mutate(
      CELL_NAME = dplyr::if_else(
        CELL_NAME == "No cars or vans in household",
        "car", CELL_NAME
      ),

      CELL_NAME = dplyr::if_else(
        CELL_NAME == "Over 1.0 and up to 1.5 persons per room",
        "persons_per_room", CELL_NAME
      ),
      CELL_NAME = dplyr::if_else(
        CELL_NAME == "Over 1.5 persons per room",
        "persons_per_room", CELL_NAME
      ),

      CELL_NAME = dplyr::if_else(
        CELL_NAME == "Social rented", "tenure", CELL_NAME
      ),
      CELL_NAME = dplyr::if_else(
        CELL_NAME == "Private rented", "tenure", CELL_NAME
      ),
      CELL_NAME = dplyr::if_else(
        CELL_NAME == "Living rent free", "tenure", CELL_NAME
      ),

      CELL_NAME = dplyr::if_else(
        CELL_NAME == "Economically active: Unemployed", "unemployed", CELL_NAME
      )

    )

  tr_data <-
    tr_data %>%
    dplyr::mutate(
      geography_code = GEOGRAPHY_CODE,
      geography_name = GEOGRAPHY_NAME
    )

  tr_data

}


tr_shape_data <- function(tr_data) {

  if (!(tibble::is_tibble(tr_data) | is.data.frame(tr_data))) {
    stop("tr_data supplied to tr_label_data() is not a data frame")
  }

  tr_data <-
    tr_data %>%
    dplyr::filter(
      CELL_NAME == "car" | CELL_NAME == "persons_per_room" |
        CELL_NAME == "tenure" | CELL_NAME == "unemployed"
    ) %>%
    dplyr::group_by(geography_code, geography_name, CELL_NAME) %>%
    dplyr::summarise_if(is.numeric, sum) %>%
    dplyr::ungroup() %>%
    tidyr::spread(key = CELL_NAME, value = OBS_VALUE)

  tr_data

}


tr_calc_z <- function(tr_data) {

  if (!(tibble::is_tibble(tr_data) | is.data.frame(tr_data))) {
    stop("tr_data supplied to tr_label_data() is not a data frame")
  }

  tr_data[, c("car", "persons_per_room", "tenure", "unemployed")] <-
    lapply(
      tr_data[, c("car", "persons_per_room", "tenure", "unemployed")],
      function(x) {
        x <- scale(x, center = TRUE, scale = TRUE)
      })

  tr_data <-
    tr_data %>%
    dplyr::mutate(townsend = car + persons_per_room + tenure + unemployed) %>%
    dplyr::select(-car, -persons_per_room, -tenure, -unemployed)

  tr_data

}
