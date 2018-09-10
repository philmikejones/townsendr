
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

  load("R/sysdata.rda")

  geographies = lapply(
    nomis_ids$id[nomis_ids$year == year],
    nomisr::nomis_get_metadata, "geography", "TYPE"
  )

  geographies_length = length(geographies)  # for filter()

  geographies = do.call(rbind, geographies)

  ids = table(geographies$id)
  ids = ids[ids == geographies_length]
  ids = attr(ids, "dimnames")
  ids = unlist(ids)
  ids = as.vector(test)

  geographies = geographies[geographies$id == ids, ]
  geographies = unique(geographies)

  geographies

}

test = tr_list_geographies(2011)
