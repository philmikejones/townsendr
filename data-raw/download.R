library("dplyr")
library("stringr")
library("nomisr")

nomis_id = data.frame(
  id   = c("NM_541_1", "NM_556_1", "NM_619_1", "NM_621_1"),
  name = c("persons_per_room", "unemployed", "car", "tenure"),
  stringsAsFactors = FALSE
)

# geographies look the same
nomis_get_metadata("NM_541_1", "geography", "TYPE")
nomis_get_metadata("NM_556_1", "geography", "TYPE")
nomis_get_metadata("NM_619_1", "geography", "TYPE")
nomis_get_metadata("NM_621_1", "geography", "TYPE")

# measures are 20100 = value; 20301 = percent
# all are the same
nomis_get_metadata("NM_541_1", "measures")
nomis_get_metadata("NM_556_1", "measures")
nomis_get_metadata("NM_619_1", "measures")
nomis_get_metadata("NM_621_1", "measures")

nomis_get_metadata("NM_541_1", "C_PPROOMHUK11")

nomis_get_data("NM_556_1", geography = "TYPE480")  # region
