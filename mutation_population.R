library(tidyverse)
library(openxlsx)
library(ggplot2)
library(reshape2)

getwd()

# Reading in excel workbook
mutation_pop_data = loadWorkbook('snps_indels_pops.xlsx') 

# Getting sheet names
sheetNames = sheets(mutation_pop_data)

# Assigning each sheet to a dataframe (starts at 2nd row to lose ploidy header)
for(i in 1:length(sheetNames)){
  assign(sheetNames[i],readWorkbook(mutation_pop_data,sheet = i, startRow = 1, colNames = TRUE))
}

#chrName = c("chrI", "chrII", "chrIII", "chrIV", "chrV", "chrVI", "chrVII", "chrVIII", "chrXI", "chrX", "chrXI", "chrXII", "chrXIII", "chrXIV", "chrXV", "chrXVI")

gene = melt(dataFrame, "Gene")
ggplot(gene, aes(variable, value, group=Gene, color = Gene)) +
  #geom_line() + 
  geom_point() + 
  labs(x = "Number of Generations", y = "???") +
  labs(color = NULL) +
  theme(legend.position = "bottom")

# ggplot SNPs/indels
for (i in 1:12){
  dataFrame = get(sheetNames[i])[6:dim(get(sheetNames[i]))[2]]
  gene = melt(dataFrame, "Gene")
  plotName = paste(sheetNames[i], "png", sep = ".")
  png(plotName)
  plot = ggplot(gene, aes(variable, value, group=Gene, color = Gene)) +
    #geom_line() + 
    geom_point() + 
    labs(x = "Number of Generations", y = "???", title = sheetNames[i], color = NULL) +
    labs(color = NULL) +
    theme(legend.position = "bottom")
  print(plot)
  dev.off()
}

###SNP-6??? INDEL-2????