library(tidyverse)
library(openxlsx)
library(ggplot2)
library(GGally)

getwd()

# Reading in excel workbook
proteomics_data = loadWorkbook('results_yeast_analysis.xlsx')

# Renaming sheets to removes spaces in names
sheetNames = sheets(proteomics_data)
sheetNames = lapply(sheetNames, trimws) # Trimming away trailing space

newSheetNames = c()
for (sheetName in sheetNames) {
  sheetName = gsub(" ", "_", sheetName)
  newSheetNames[sheetName] = sheetName 
}
sheetNames = newSheetNames

# Assigning each sheet to a dataframe
for(i in 1:length(sheetNames)){
  assign(sheetNames[i],readWorkbook(proteomics_data,sheet = i))
}


# Create list of out dataframes (except for GO_BP_analysis)
data_frame_list = list(S1 = S1_all_6perc_vs_all_YPD, S2 = S2_ANC_6pers_vs_YPD, S3 = S3_77_6pers_vs_YPD, 
                       S4 = S4_78_6pers_vs_YPD, S5 = S5_79_6perc_vs_YPD, S6 = S6_86_6perc_vs_YPD,
                       S7 = S7_87_6perc_vs_YPD, S8_88_6perc_vs_YPD)

# Changes Significance column to boolean in all data frames
data_frame_list = lapply(data_frame_list, function(df) {
  df$Significant = as.factor(!(is.na(df$Significant)))
  df
})

# Basic statistics plots
for (i in 1:8){
  data = get(sheetNames[i])
  dataCut = data[,c(1,2,20,27)]
  graphName = paste("ggpairs", sheetNames[i], sep = "_")
  png(graphName, width = 600, height = 600)
  ggpairs(dataCut)+ggtitle(graphName)
  dev.off()
}

# up-regulation proteins in each clone
for (i in 1:8){
  data = get(sheetNames[i])
  subsetName = paste("upregulatedProtein", sheetNames[i], sep = "_")
  dataUp = filter(data, (data$Significant=="+" & data$log2.fold.change>0))
  dataUp = data.frame(dataUp[,c(1, 5)])
  if((length(dataUp$Significant))!=0){
    dataUp$Significant = "up"
  }
  assign(subsetName, dataUp)
}

upregulatedProtein_S2_ANC_6pers_vs_YPD  #96
upregulatedProtein_S3_77_6pers_vs_YPD   #null
upregulatedProtein_S4_78_6pers_vs_YPD   #97
upregulatedProtein_S5_79_6perc_vs_YPD   #null
upregulatedProtein_S6_86_6perc_vs_YPD   #59
upregulatedProtein_S7_87_6perc_vs_YPD   #34
upregulatedProtein_S8_88_6perc_vs_YPD   #93

#down-regulation proteins in each clone
for (i in 1:8){
  data = get(sheetNames[i])
  subsetName = paste("downregulatedProtein", sheetNames[i], sep = "_")
  dataDown = filter(data, (data$Significant=="+" & data$log2.fold.change<0))
  dataDown = data.frame(dataDown[,c(1, 5)])
  if((length(dataDown$Significant))!=0){
    dataDown$Significant = "down"
  }
  assign(subsetName, dataDown)
}

downregulatedProtein_S2_ANC_6pers_vs_YPD  #33
downregulatedProtein_S3_77_6pers_vs_YPD   #null
downregulatedProtein_S4_78_6pers_vs_YPD   #31
downregulatedProtein_S5_79_6perc_vs_YPD   #null
downregulatedProtein_S6_86_6perc_vs_YPD   #10
downregulatedProtein_S7_87_6perc_vs_YPD   #7
downregulatedProtein_S8_88_6perc_vs_YPD   #19



##combine up/down regulated proteins 
for (i in 1:8){
  listNameUpregulated = paste("upregulatedProtein", sheetNames[i], sep = "_")
  dataUpregulated = get(listNameUpregulated)
  listNameDownregulated = paste("downregulatedProtein", sheetNames[i], sep = "_")
  dataDownregulated = get(listNameDownregulated)
  significantProtein = NULL
  significantProtein = rbind(dataUpregulated,dataDownregulated)
  subsetName = paste("significantProtein", sheetNames[i], sep = "_")
  assign(subsetName, significantProtein)
}

significantProtein_S2_ANC_6pers_vs_YPD  #129
significantProtein_S3_77_6pers_vs_YPD   #null
significantProtein_S4_78_6pers_vs_YPD   #128
significantProtein_S5_79_6perc_vs_YPD   #null
significantProtein_S6_86_6perc_vs_YPD   #69
significantProtein_S7_87_6perc_vs_YPD   #41
significantProtein_S8_88_6perc_vs_YPD   #112


#compare each evolved's significant proteins against ancester
for (i in 3:8){
  listReacterName = paste("significantProtein", sheetNames[i], sep = "_")
  reacterName = get(listReacterName)
  listSharedSignificantProtein = paste("sharedSignificantProtein", sheetNames[i], sep = "_")
  listUniqueSignificantProtein = paste("uniqueSignificantProtein", sheetNames[i], sep = "_")
  if((length(reacterName$Majority.protein.IDs))!=0){
    sharedSignificantProtein = intersect(significantProtein_S2_ANC_6pers_vs_YPD, reacterName)
    uniqueSignificantProtein = setdiff(significantProtein_S2_ANC_6pers_vs_YPD, reacterName)
    assign(listSharedSignificantProtein, sharedSignificantProtein)
    assign(listUniqueSignificantProtein, uniqueSignificantProtein)
  }
}

sharedSignificantProtein_S4_78_6pers_vs_YPD  #77 (67+10)
sharedSignificantProtein_S6_86_6perc_vs_YPD  #58 (54+4)
sharedSignificantProtein_S7_87_6perc_vs_YPD  #34 (32+2)
sharedSignificantProtein_S8_88_6perc_vs_YPD  #79 (70+9)
uniqueSignificantProtein_S4_78_6pers_vs_YPD  #52 (29+23)
uniqueSignificantProtein_S6_86_6perc_vs_YPD  #71 (42+29)
uniqueSignificantProtein_S7_87_6perc_vs_YPD  #95 (64+31)
uniqueSignificantProtein_S8_88_6perc_vs_YPD  #50 (26+24)

##co-shared significant proteins (evolved vs ancester)
cosharedSignificantProtein_fermentor3 = sharedSignificantProtein_S4_78_6pers_vs_YPD
uniqueSignificantProtein_fermentor3 = uniqueSignificantProtein_S4_78_6pers_vs_YPD

cosharedSignificantProtein_fermentor4 = intersect(sharedSignificantProtein_S6_86_6perc_vs_YPD,
                                                  sharedSignificantProtein_S7_87_6perc_vs_YPD, 
                                                  sharedSignificantProtein_S8_88_6perc_vs_YPD)
significantProtein_fermentor4 = rbind(significantProtein_S6_86_6perc_vs_YPD, significantProtein_S7_87_6perc_vs_YPD, significantProtein_S8_88_6perc_vs_YPD)
uniqueSignificantProtein_fermentor4 = setdiff(significantProtein_fermentor4, cosharedSignificantProtein_fermentor4)
uniqueSignificantProtein_fermentor4[order(c("up", "down"))]
uniqueSignificantProtein_fermentor4[c("Significant", "Majority.protein.IDs")]


cosharedSignificantProtein_fermentor3 #77 (67+10)
cosharedSignificantProtein_fermentor4 #31 (30+1)
cosharedSignificantProtein_total      #30 (29+1)

uniqueSignificantProtein_fermentor3  #52 (29+23)
uniqueSignificantProtein_fermentor4  #99 (86+13)
#setdiff(cosharedSignificantProtein, cosharedSignificantProtein_fermentor4) #difference
### fermentor3 has all significant protein in fermentor4, except upregulated P14065 



#export data as excel
write.xlsx((cosharedSignificantProtein_fermentor3),"cosharedSignificantProtein_fermentor3.xlsx")
write.xlsx((cosharedSignificantProtein_fermentor4),"cosharedSignificantProtein_fermentor4.xlsx")
write.xlsx((uniqueSignificantProtein_fermentor3),"uniqueSignificantProtein_fermentor3")
write.xlsx((uniqueSignificantProtein_fermentor4),"uniqueSignificantProtein_fermentor4")



