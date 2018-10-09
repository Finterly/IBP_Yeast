#Hello!

install.packages("readxl")
library(readxl)

setwd("/Users/Yibing/Desktop/Leuven/Leuven 2.1/Integrated Bioinformatics Project")
getwd()

##Set dataframe of yeast protein data
sheet_name = array(c("S2 ANC 6pers vs YPD", "S3 77 6pers vs YPD ", "S4 78 6pers vs YPD", 
               "S5 79 6perc vs YPD", "S6 86 6perc vs YPD", "S7 87 6perc vs YPD ", "S8 88 6perc vs YPD"))
for (i in 2:8){
  nam = paste("data_S", i, sep = "")
  data_i = read_xlsx(path = "results_yeast_analysis.xlsx", 
                    sheet = sheet_name[i-1])
  data_i$Strain_name = paste("S", i, sep = "")
  assign(nam, data_i)
}

data = rbind(data_S2, data_S3, data_S4, data_S5, data_S6, data_S7, data_S8)

##Set dataframe of SNPs in evolved clones
sheet_name = array(c("SNP_Reactor1", "SNP_Reactor2", "SNP_Reactor3", "SNP_Reactor4", "SNP_Reactor5", "SNP_Reactor6",
         "INDEL_Reactor1", "INDEL_Reactor2", "INDEL_Reactor3", "INDEL_Reactor4", "INDEL_Reactor5", "INDEL_Reactor6"))
for (i in 1:12){
  nam = paste("data_SNP_clone_", sheet_name[i], sep = "")
  data_i = read_xls(path = "List of SNPs and Indels identified in evolved clones by whole-genome sequencing.xls", 
                    sheet = sheet_name[i])
  data_i$Reacter = sheet_name[i]
  assign(nam, data_i)
}
#number of variables are different in each sheet. CANNOT combine. further data investigation later.

##Set dataframe of SNPs in evolved population
sheet_name = array(c("reactor1pop_SNP", "reactor2pop_SNP", "reactor3pop_SNP", "reactor4pop_SNP", "reactor5pop_SNP", "reactor6pop_SNP", 
                     "reactor1pop_indel", "reactor2pop_indel", "reactor3pop_indel", "reactor4pop_indel", "reactor5pop_indel", "reactor6pop_indel"))
for (i in 1:12){
  nam = paste("data_SNP_pop_", sheet_name[i], sep = "")
  data_i = read_xls(path = "List of SNPs and Indels identified in evolved populations by whole-genome sequencing.xls", 
                    sheet = sheet_name[i])
  data_i$Reacter = sheet_name[i]
  assign(nam, data_i)
}
#number of variables are different in each sheet. CANNOT combine. further data investigation later.

