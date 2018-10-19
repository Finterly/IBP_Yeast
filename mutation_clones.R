library(openxlsx)

# Reading in excel workbook
mutation_clones_data = loadWorkbook('snps_indels_clones.xlsx') # Replace this with the apporpiate file

# Renaming sheets to removes spaces in names
sheetNames = sheets(mutation_clones_data)

# Assigning each sheet to a dataframe
for(i in 1:length(sheetNames)){
  assign(sheetNames[i],readWorkbook(mutation_clones_data,sheet = i, startRow = 2))
}
