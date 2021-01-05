Packages <- c("raster", "ncdf4", "rgdal", "tidyverse", "leaflet", "mapview","openair","xts")
lapply(Packages, library, character.only = TRUE)


## import data----
# nc average
import.nc<-function(path,name,vname,prj){
  ncfname <- paste(path, name, ".nc", sep="")
  tmpin <- raster(ncfname, varname = vname)
  projection(tmpin)<-prj
  return(tmpin)
}
ncpath<-"./data/"
wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
uemep_no2<-import.nc(ncpath, "no2_ymean_Glasgow_250m","no2_concentration", "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")



uemep_no2_wgs84 = projectRaster(uemep_no2, crs = wgs84, method = "ngb")

emep_no2<-import.nc(ncpath, "SURF_ug_NO2_ymean","SURF_ug_NO2",wgs84)

emep_no2_gla<-crop(emep_no2, uemep_no2_wgs84)

#ncpath<-"./data/"
uemep_nox<-import.nc(ncpath, "nox_ymean_Glasgow_250m","nox_concentration", "+proj=utm +zone=30 +datum=WGS84 +units=m +no_defs")

#ncpath<-"./data/"
wgs84 = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"
uemep_nox_wgs84 = projectRaster(uemep_nox, crs = wgs84, method = "ngb")

emep_no<-import.nc(ncpath, "no_ymean_emep_uk","SURF_ug_NO",wgs84)
emep_nox<-emep_no2+emep_no/30.01*46.0055  # as no2 
emep_nox_gla<-crop(emep_nox, uemep_nox_wgs84)

uemep_no_wgs84<-(uemep_nox_wgs84-uemep_no2_wgs84)/46.0055*30.01
emep_no_gla<-crop(emep_no, uemep_no_wgs84)