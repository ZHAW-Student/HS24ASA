# ASA I ####
# load packages
library(readr)
library(tidyr)
library(sf)
library(ggplot2)
library(leaflet)
library(spatstat)
library(dplyr)

# load data
linguistic <- read_delim("linguistics.csv")

# compute percentage
linguistic$perc_fangt_s_Iis_aa_schmelze <- (100/linguistic$n_tot)*linguistic$n_fangt_s_Iis_aa_schmelze
linguistic$perc_fangt_s_Iis_afa_schmelze <- (100/linguistic$n_tot)*linguistic$n_fangt_s_Iis_afa_schmelze
linguistic$perc_schmilzt_s_Iis <- (100/linguistic$n_tot)*linguistic$n_schmilzt_s_Iis
linguistic
 
# convert to sf, set and change crs
linguistic_sf <- st_as_sf(linguistic, coords = c("long", "lat"))
linguistic_sf <- st_set_crs(linguistic_sf, 21781)
linguistic_sf_2056 <- st_transform(linguistic_sf, 2056)
linguistic_sf_4326 <- st_transform(linguistic_sf, 4326)

# plot graduaded symbols
ggplot(linguistic_sf_2056) + 
  geom_sf(aes(color = perc_schmilzt_s_Iis))

# plot dominant variant
ggplot(linguistic_sf_2056) + 
  geom_sf(color = linguistic_sf_2056$dominant) +
  theme(legend.position = "bottom")

# compute nearest neighbor index
ling_dom1 <- filter(linguistic_sf_2056, dominant == 1)
ling_dom2 <- filter(linguistic_sf_2056, dominant == 2)
ling_dom3 <- filter(linguistic_sf_2056, dominant == 3)

coords_dom1 <- st_coordinates(ling_dom1)
nndist(coords_dom1)
coords_dom2 <- st_coordinates(ling_dom2)
nndist(coords_dom2)
coords_dom3 <- st_coordinates(ling_dom3)
nndist(coords_dom3)
