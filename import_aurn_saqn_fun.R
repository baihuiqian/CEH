source("./fun/get_openair_site_fun.R")
import.glg<-function(g, bbox, y){ # g : which network , bbox lat lon, y, year
  # check 1 
  print(g)
  print(bbox)
  print(y)
  
  data.aurn<-function(group, d,y){
    site<-site.ll(group, d)
    # check 2
      print(site)# test
    df<-left_join(site%>% select(code)%>%
                    map_dfr(function(x){importAURN(x, year = y)}),
                                    site, 
                  by = c("code","site"))%>%unique()  
    # check 2 
   print(head(df)) 
    return(df)
  }
  
  data.saqn<-function(group, d,y){
    site<-site.ll(group, d)
    # check 3
    print(site)
    df<-left_join(site%>% select(code)%>%
                    map_dfr(function(x){importSAQN(x, year = y)}),
                                    site, 
                  by = c("code","site"))%>%unique()  
    # check 3 
    print(head(df))
    return(df)
  }
  
  df1<-data.aurn(g[1],bbox,y)
  df2<-data.saqn(g[2],bbox,y)
  df<-rbind(df1,df2)
  return(df)
}

#groups<-c("aurn", "saqn")
#glg_bbox<-c(-4.3932004964769344,-4.071716789669683, 55.7812791449368,55.92964126998787)


#test<-import.glg(groups, glg_bbox,2017)
#saveRDS(test, "./output/test.rds")
