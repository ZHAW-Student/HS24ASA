library("readr")
library("sf")
library("dplyr")
library("tmap")
library("ggplot2")
library("terra")
library("lubridate")

lingu<- read_csv("linguistics.csv")
lingu$n_fangt_s_Iis_aa_schmelze_per <-100/lingu$n_tot*lingu$n_fangt_s_Iis_aa_schmelze
lingu$n_fangt_s_Iis_afa_schmelze_per <-100/lingu$n_tot*lingu$n_fangt_s_Iis_afa_schmelze
lingu$n_schmilzt_s_Iis_per <-100/lingu$n_tot*lingu$n_schmilzt_s_Iis
