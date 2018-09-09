
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
    nomis_id$id[nomis_id$year == year],
    nomis_get_metadata, "geography", "TYPE"
  )

  geographies

}
