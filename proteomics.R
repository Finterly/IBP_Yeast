library(tidyverse)
library(openxlsx)

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
for(i in 1:length(sheetNames))
{
  assign(sheetNames[i],readWorkbook(proteomics_data,sheet = i))
}

data_frame_list = list(S1 = S1_all_6perc_vs_all_YPD, S2 = S2_ANC_6pers_vs_YPD, S3 = S3_77_6pers_vs_YPD, 
                    S4 = S4_78_6pers_vs_YPD, S5 = S5_79_6perc_vs_YPD, S6 = S6_86_6perc_vs_YPD,
                    S7 = S7_87_6perc_vs_YPD, S8_88_6perc_vs_YPD)

data_frame_list = lapply(data_frame_list, function(df) {
  df$Significant = as.factor(!(is.na(df$Significant)))
  df
})