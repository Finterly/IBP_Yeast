library(tidyverse)
library(openxlsx)

proteomics_data <- loadWorkbook('results_yeast_analysis.xlsx')
sheetNames <- sheets(proteomics_data)
for(i in 1:length(sheetNames))
{
  assign(sheetNames[i],readWorkbook(proteomics_data,sheet = i))
}
