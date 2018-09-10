nomis_ids = data.frame(
  id   = c("NM_541_1", "NM_556_1", "NM_619_1", "NM_621_1"),
  year = c(2011L, 2011L, 2011L, 2011L),
  name = c("persons_per_room", "unemployed", "tenure", "car"),
  stringsAsFactors = FALSE
)

usethis::use_data(nomis_ids, internal = TRUE, overwrite = TRUE)
