library(openxlsx)

# Reading in excel workbook
mutation_clones_data = loadWorkbook('snps_indels_clones.xlsx') # Replace this with the apporpiate file

# Getting sheet names
sheetNames = sheets(mutation_clones_data)

# Assigning each sheet to a dataframe (starts at 2nd row to lose ploidy header)
for(i in 1:length(sheetNames)){
  assign(sheetNames[i],readWorkbook(mutation_clones_data,sheet = i, startRow = 2))
}
