nomis_ids = tibble::tibble(
  id   = "NM_621_1",
  year = 2011L,
  name = "car"
)

nomis_ids = rbind(
  nomis_ids,
  c("NM_541_1", 2011L, "persons_per_room"),
  c("NM_619_1", 2011L, "tenure"),
  c("NM_556_1", 2011L, "unemployed")
)

nomis_ids =
  rbind(
    nomis_ids,
    c("NM_1679_1", 2001L, "car"),
    c("NM_1675_1", 2001L, "persons_per_room"),
    c("NM_1626_1", 2001L, "tenure"),
    c("NM_1651_1", 2001L, "unemployed")
  )

usethis::use_data(nomis_ids, internal = TRUE, overwrite = TRUE)
