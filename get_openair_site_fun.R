# This function is to extract sites based on 
# monitroing network
# location :lat lon 


#site.ll<-function(s, a, b, c, d){ # s = "kcl", a, b, c, d are long, long, lat lat
#  df<-importMeta(source = s, all = F)%>%
#    filter(longitude >=a& longitude<=b&latitude >=c&latitude <=d)%>%
##    select(site,code,latitude, longitude)%>%
#    mutate(site = as.character(site), code = as.character(code))%>%
##    mutate(source = s)
#  return(as.data.frame(df))
#}
library(tidyverse)
library(openair)

site.ll<-function(s, d){ # s = "kcl", a, b, c, d are long, long, lat lat (d1,d2,d3,d4)
  df<-importMeta(source = s, all = F)%>%
    filter(longitude >=d[1]& longitude<=d[2]&latitude >=d[3]&latitude <=d[4])%>%
    select(site,code,latitude, longitude, site_type)%>%
    mutate(site = as.character(site), code = as.character(code) )%>%
    mutate(source = s)
  return(as.data.frame(df))
}


#meta_london_kcl<-site.ll("kcl",-0.60,0.33, 51.25,51.74)
#meta_london_aurn<-site.ll("aurn",-0.60,0.33, 51.25,51.74)
#meta_london_aqe<-site.ll("aqe",-0.60,0.33, 51.25,51.74)
#meta_london_europe<-site.ll("europe",-0.60,0.33, 51.25,51.74)

#df<-rbind(meta_london_kcl,meta_london_aurn,meta_london_aqe, meta_london_europe)

site.ll.kerb<-function(s, a, b, c, d){ # s = "kcl", a, b, c, d are long, long, lat lat
  df<-importMeta(source = s, all = T)%>%
    filter(longitude >=a& longitude<=b&latitude >=c&latitude <=d)%>%
    filter(site.type == "Kerbside")%>%
    select(site,code,latitude, longitude)%>%
    mutate(site = as.character(site), code = as.character(code))%>%
    mutate(source = s)
  return(as.data.frame(df))
}
