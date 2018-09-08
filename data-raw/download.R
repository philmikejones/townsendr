library("dplyr")
library("stringr")
library("nomisr")

nomis_id = data.frame(
  id   = c("NM_541_1", "NM_556_1", "NM_621_1", "NM_619_1"),
  name = c("persons_per_room", "unemployed", "car", "tenure"),
  stringsAsFactors = FALSE
)

nomis_geography = data.frame(
  id        = c("TYPE464"),
  geography = c("district"),
  stringsAsFactors = FALSE
)

nomis_measure = data.frame(
  measures    = c(20100),
  description = c("value"),
  stringsAsFactors = FALSE
)
