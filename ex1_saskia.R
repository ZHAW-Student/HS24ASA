# ASA I ####
# load packages
library(readr)
library(tidyr)
library(sf)
library(ggplot2)
library(leaflet)

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
leaflet(linguistic_sf_4326) +
  addMarkers() 

ggplot() + 
  geom_sf(data = linguistic_sf_2056)
