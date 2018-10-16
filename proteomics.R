library(tidyverse)
library(openxlsx)

# Reading in excel workbook
proteomics_data <- loadWorkbook('results_yeast_analysis.xlsx')

# Renaming sheets to removes spaces in names
sheetNames <- sheets(proteomics_data)
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

