library(ggplot2)
library(dplyr)
library(tidyverse)
setwd('~/path/to/VCF')

csv <- read.csv('file.csv', header = TRUE, sep = '\t')

#plot TajD and pi (scaling pi against a second y-axis)
divstat <- ggplot(csv,aes(x=csv$Start)) 
+ geom_line(aes(y=SequenceDiversityStatistics,TajimaD,color='Tajimas D'),size=1)
+ geom_line(aes(y=SequenceDiversityStatistics,TajimaPi/0.1,color='Nucleotide Diversity'),size=1)
+ scale_y_continuous(sec.axis=sec.axis(~.*(0.1),name='Nucleotide Diversity'))
+ ggtitle(expression(paste('Sequence Diversity Statistics of',italic('Zt09_chr11_00525'),'+/-10Kb')))
+ xlab('Tajimas D')
+ theme(text=element_text(family='sans', size=16, face = 'bold'))
+ scale_color_manual(values =c('Tajimas D'= 'royalblue1', 'Nucleotide Diversity' = 'olivedrab'), guide=FALSE)
#labs(color='Statistics')

ggsave('~/path/to/divstats.png', divstat, width = 270, height = 100, units = 'mm', dpi = 300)

#plot SNP density for gene using vcf file
gene<-'gene_name'
filevcf <- paste('/path/to/VCF/file', gene, '.sorted.vcf', sep = '')
snps <- read.table(filevcf, sep='\t', header = FALSE, blank.lines.skip = TRUE, comment.char = '#')
colnames(snps) <- c('chr', 'start', 'id', 'refallele', 'altallele', 'qual', 'filter', 'info', 'format')

snpsplot <- ggplot(snps, aes(x=start)) + geom_histogram(aes(x=start), binwidth = 1e2)
+ ggtitle(expression(paste('SNP Density along', italic('gene'), 'region')))
+ xlab('Genomic position')
+ scale_x_continuous(limits = c(1596000,1614000))
+ ylab('SNP density')
+ theme(text = element_text(size = 20))

ggsave(paste('~/path/to/', gene, 'snp_density.png', sep = ''), snpsplot, width = 270, height = 100, units = 'mm', dpi = 300)

  