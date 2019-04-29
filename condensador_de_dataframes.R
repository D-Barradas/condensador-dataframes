library(dplyr)
library(reshape2)
#library(ggplot2)
#library(ggthemes)
directorio_parent <- "/home/didier/Documentos/Proyecto_GO_cancer/GoIsingCancer/badukmovies-pro-collection"
setwd(directorio_parent)
char <- "_tactics.txt"
for ( lista_de_folder_nivel1 in list.dirs(recursive = T,full.names = F)){
  #print (paste(directorio_parent,lista_de_folder_nivel1, sep = "/"))
  df_folders <- data.frame()
  directorio_trabajo <- paste(directorio_parent,lista_de_folder_nivel1, sep = "/")
  setwd(directorio_trabajo)
  for ( lista_de_files in list.files( )){
    if ( grepl(char,lista_de_files)){ ### equivalente a "char" in x
       #print (lista_de_files)
       df_temp <- read.csv(lista_de_files,sep = "\t",header = T)
       df_folders <- merge(df_folders,df_temp,all=TRUE)
    }
  }
  if ( nrow(df_folders) != 0 ){ 
  df_condensed <- aggregate(. ~ move, df_folders, sum)
  dataframeid <- paste("data_frame_folder",lista_de_folder_nivel1,"csv",sep = ".")
  dataframeid <- gsub("/","_",dataframeid)
  
  print (dataframeid)
  
  write.csv(df_condensed,file = dataframeid)
  }
}