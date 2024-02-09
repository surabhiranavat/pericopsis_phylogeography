##Concatenate alignments from Choi et al and 14 Pericopsis plastomes from OH
##using awk in terminal, first change the ? to N without changing ATGC- and excluding the header line
# awk '!/^>/{gsub(/[^CTAG-]/, "N")}1' ChoiAlign77CDS_Dataset_4_183genera_25pcGapstrip.fasta > ChoiAlign77CDS_Dataset_4_183genera_25pcGapstrip_replacedN.fasta

##Now in R, install package DECIPHER (ES Wright, 2015, BMC Bioinformatics)
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DECIPHER")

library(DECIPHER)

setwd("/Users/sranavat/Downloads")

##Read the first multiple sequence alignment
fasta1<-readDNAStringSet(filepath = "14PlastomesPericopsis_77CDSconcatMAFFT.fasta", format = "fasta")
fasta1
##Read the second multiple sequence alignment
fasta2<-readDNAStringSet(filepath = "ChoiAlign77CDS_Dataset_4_183genera_25pcGapstrip_replacedN.fasta", format = "fasta")
fasta2

##Combine the two multiple seq alignments with AlignProfiles
combined_alignment_choi_pericopsis <- AlignProfiles(fasta1, fasta2)

##Output the combined aligment file with WriteXSringSet
writeXStringSet(combined_alignment_choi_pericopsis, file="combined_choi_pericopsis.fasta")
