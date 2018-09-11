#' tr_list_geographies
#'
#' List the available census geographies. Returns a
#' [tibble][tibble::tibble-package] with one row per available geography.
#'
#' @param year A census year. Currently the 2011 and 2001 censuses are supported
#'
#' @return A [tibble][tibble::tibble-package] of available census geographies
#' @export
#'
#' @examples
#' \dontrun{
#' tr_list_geographies(2011)
#' }
tr_list_geographies <- function(year = NULL) {

  tr_check_year(year)

  geographies <- lapply(
    nomis_ids$id[nomis_ids$year == year],
    nomisr::nomis_get_metadata, "geography", "TYPE"
  )

  geographies_length <- length(geographies)  # for filter()

  geographies <- do.call(rbind, geographies)

  # Remove any geographies that aren't present in all returned tables
  geographies_n_groups <-
    geographies %>%
    dplyr::group_by(id) %>%
    dplyr::n_groups()

  geographies <-
    geographies %>%
    dplyr::group_by(id) %>%
    dplyr::filter(dplyr::n() == geographies_length) %>%
    dplyr::ungroup() %>%
    dplyr::filter(!duplicated(.))

  geographies

}
