#' tr_list_geographies
#'
#' @param year A census year
#'
#' @return A list of tibbles of available census geographies
#' @export
#'
#' @examples
#' tr_list_geographies(2011)
tr_list_geographies = function(year) {

  geographies = lapply(
    townsendr:::nomis_ids$id[townsendr:::nomis_ids$year == year],
    nomisr::nomis_get_metadata, "geography", "TYPE"
  )

  geographies_length = length(geographies)  # for filter()

  geographies = do.call(rbind, geographies)

  geographies =
    geographies %>%
    dplyr::group_by(id) %>%
    dplyr::filter(dplyr::n() == geographies_length) %>%
    dplyr::ungroup() %>%
    dplyr::filter(!duplicated(.))

  geographies

}

test = tr_list_geographies(2011)
