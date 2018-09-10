
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
    nomisr::nomis_get_metadata, "geography", "TYPE"
  )

  geographies_length = length(geographies)  # for filter()

  geographies = do.call(rbind, geographies)

  ids = table(geographies$id)
  # ids[1] = 3
  ids = ids[ids == geographies_length]
  ids = attr(ids, "dimnames")

  geographies = geographies[ids %in% geographies$id, ]

  geographies


}

tr_list_geographies(2011)
