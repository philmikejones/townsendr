#' tr_list_geographies
#'
#' @param year A census year
#'
#' @return A list of tibbles of available census geographies
#' @export
#'
#' @examples
#' tr_list_geographies(2011)
tr_list_geographies <- function(year) {

  stop("this function needs breaking down further for testing")

  tr_check_year(year)

  geographies <- lapply(
    townsendr:::nomis_ids$id[townsendr:::nomis_ids$year == year],
    nomisr::nomis_get_metadata, "geography", "TYPE"
  )

  if (length(geographies) == 0L) {
    message("No results for specified year")
  }
  geographies_length <- length(geographies)  # for filter()

  # Remove any geographies that aren't present in all returned tables
  df_check <- lapply(geographies, is.data.frame)
  if (!all(unlist(df_check))) {
    stop("Results returned malformed. Check year")
  }
  geographies <- do.call(rbind, geographies)

  if (nrow(geographies) < geographies_length) {
    stop("Results returned malformed. Check year")
  }

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

  if (geographies_n_groups != nrow(geographies)) {
    stop("Cannot obtain geographies. Check year")
  }

  geographies

}
