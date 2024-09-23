library("readr")
library("sf")
library("dplyr")
library("tmap")
library("ggplot2")
library("terra")
library("lubridate")
library("leaflet")
library("spatstat")

lingu<- read_csv("Session_1/linguistics.csv")
lingu$n_fangt_s_Iis_aa_schmelze_per <-100/lingu$n_tot*lingu$n_fangt_s_Iis_aa_schmelze
lingu$n_fangt_s_Iis_afa_schmelze_per <-100/lingu$n_tot*lingu$n_fangt_s_Iis_afa_schmelze
lingu$n_schmilzt_s_Iis_per <-100/lingu$n_tot*lingu$n_schmilzt_s_Iis


lingu_sf <- st_as_sf(lingu,coords = c("long", "lat"),crs = 21781)
lingu_sf_wgs <-st_transform(lingu_sf, crs=4326)


st_layers("Session_1/swiss_cantons_boundaries.gpkg")#see all contents of geopackage
boundaries_2056<- st_read("Session_1/swiss_cantons_boundaries.gpkg")
boundaries_wgs <-st_transform(boundaries_2056, crs=4326)

ggplot()+
  geom_sf(data=boundaries_wgs, aes(fill="white"))+
  geom_sf(data=lingu_sf_wgs, aes(color=n_fangt_s_Iis_aa_schmelze_per))+
  theme(legend.position="none")

cols<- c("1" ="red", "2"="blue","3"= "green", "4"="yellow")

ggplot()+
  geom_sf(data=boundaries_wgs, aes(fill="white"))+
  geom_sf(data=lingu_sf_wgs, aes(color=factor(dominant)))+
  scale_colour_manual(values = cols)+
  theme(legend.position="none")

#wildschwein_BE_sf[wildschwein_BE_sf$TierName == "Sabi", ]

lingu_cord_var1 <-st_coordinates(lingu_sf_wgs[lingu_sf_wgs$dominant == "1",])  
lingu_cord_var2 <-st_coordinates(lingu_sf_wgs[lingu_sf_wgs$dominant == "2",]) 
lingu_cord_var3 <-st_coordinates(lingu_sf_wgs[lingu_sf_wgs$dominant == "3",]) 
lingu_cord_var4 <-st_coordinates(lingu_sf_wgs[lingu_sf_wgs$dominant == "4",])

dist_var_1 <-mean(nndist(lingu_cord_var1))
dist_var_2 <-mean(nndist(lingu_cord_var2))
dist_var_3 <-mean(nndist(lingu_cord_var3))
dist_var_4 <-mean(nndist(lingu_cord_var4))

bbox_var_1 <- st_bbox(lingu_sf_wgs[lingu_sf_wgs$dominant == "1",]) |> 
  st_as_sfc() |> 
  st_area()
bbox_var_2 <- st_bbox(lingu_sf_wgs[lingu_sf_wgs$dominant == "2",])|> 
  st_as_sfc() |> 
  st_area()
bbox_var_3 <- st_bbox(lingu_sf_wgs[lingu_sf_wgs$dominant == "3",])|> 
  st_as_sfc() |> 
  st_area()
bbox_var_4 <- 0 #cause its one coordinate duh

nni1 <- dist_var_1/(1/sqrt(181/bbox_var_1))
nni2 <- dist_var_2/(1/sqrt(141/bbox_var_2))
nni3 <- dist_var_3/(1/sqrt(13/bbox_var_3))
nni4 <- dist_var_4/(1/sqrt(1/bbox_var_4))


#alternative one bbox
bbox_var <- st_bbox(lingu_sf_wgs) |> 
  st_as_sfc() |> 
  st_area()

nni1_ <- dist_var_1/(1/sqrt(181/bbox_var))
nni2_ <- dist_var_2/(1/sqrt(141/bbox_var))
nni3_ <- dist_var_3/(1/sqrt(13/bbox_var))
nni4_ <- dist_var_4/(1/sqrt(1/bbox_var))


#no matter what variant there is always some clustering