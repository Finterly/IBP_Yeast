library(openxlsx)
library(tidyverse)

setwd("PATH TO WORKING DIRECTORY")

# Reading in excel workbook
mutation_clones_data = loadWorkbook('snps_indels_clones.xlsx') # Replace this with the apporpiate file

# Getting sheet names
sheetNames = sheets(mutation_clones_data)

# Assigning each sheet to a dataframe (starts at 2nd row to lose ploidy header)
for(i in 1:length(sheetNames)){
  assign(sheetNames[i],readWorkbook(mutation_clones_data,sheet = i, startRow = 2))
}

# Counting number of SNPs per chromosome
# Reactor 1
num_SNPs_Reactor1_per_Chr = table(SNP_Reactor1$Chr)
write.table(num_SNPs_Reactor1_per_Chr, "num_snps_reactor1_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Reactor 2
num_SNPs_Reactor2_per_Chr = table(SNP_Reactor2$Chr)
write.table(num_SNPs_Reactor2_per_Chr, "num_snps_reactor2_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Reactor 3
num_SNPs_Reactor3_per_Chr = table(SNP_Reactor3$Chr)
write.table(num_SNPs_Reactor3_per_Chr, "num_snps_reactor3_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Reactor 4
num_SNPs_Reactor4_per_Chr = table(SNP_Reactor4$Chr)
write.table(num_SNPs_Reactor4_per_Chr, "num_snps_reactor4_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Reactor 5
num_SNPs_Reactor5_per_Chr = table(SNP_Reactor5$Chr)
write.table(num_SNPs_Reactor5_per_Chr, "num_snps_reactor5_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Reactor 6
num_SNPs_Reactor6_per_Chr = table(SNP_Reactor6$Chr)
write.table(num_SNPs_Reactor6_per_Chr, "num_snps_reactor6_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Counting number of indels per chromosome
# Reactor 3
num_indels_Reactor3_per_Chr = table(INDEL_Reactor3$Chr)
write.table(num_indels_Reactor3_per_Chr, "num_indels_reactor3_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Reactor 4
num_indels_Reactor4_per_Chr = table(INDEL_Reactor4$Chr)
write.table(num_indels_Reactor4_per_Chr, "num_indels_reactor4_per_chr.txt", quote=F, row.names = F, sep ="\t")

# Combine diploid reactors
names(SNP_Reactor3) = c("Chr", "Pos", "Gene", "Ref", "Alt", "40.1", "40.2", "40.3", "100.1","100.2", "100.3", "200.1", "200.2", "200.3")
names(SNP_Reactor4) = c("Chr", "Pos", "Gene", "Ref", "Alt", "40.1", "40.2", "40.3", "100.1","100.2", "100.3", "200.1", "200.2", "200.3")

SNP_Reactor3_and_4 = rbind(SNP_Reactor3, SNP_Reactor4)
SNP_Reactor3_and_4 = SNP_Reactor3_and_4[order(SNP_Reactor3_and_4$Chr, SNP_Reactor3_and_4$Pos),] #Sort by Chr and Pos

tmp = subset(SNP_Reactor3_and_4, select = c("Chr", "Pos", "Gene"))
frequent_SNP_hits_reactor3_and_4 = tmp[duplicated(tmp)|duplicated(tmp, fromLast = T),]

table(SNP_Reactor3_and_4$Chr)

# Generating gene lists for GO characterisation
SNP_reactor3_genelist = subset(SNP_Reactor3, Gene != "INTERGENIC", select = Gene)
SNP_reactor3_genelist = unique(reactor3_genelist) # remove duplicates
write.table(SNP_reactor3_genelist, "snps_reactor3_genelist", sep = "\t", quote = F, row.names = F, col.names = F)
