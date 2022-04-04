library(ggplot2)
library(ggsignif)

inplanta_pyc <- as.data.frame(read.csv('/path/to/file.csv',header=T, sep = ','))

#rename dataframe columns
levels(inplanta_pyc$Treatment)<-c(levels(inplanta_pyc$Treatment),'strain_name')
inplanta_pyc$Treatment[inplanta_pyc$Treatment=='Treatment']<-'strain_name'

#subsetting by strain
strain <- subset.data.frame(inplanta_pyc,Treatment == 'strain', select = c(Treatment,pycnidiaPerCm2Leaf))

#combine strains (x2) into single treatment or strain type (pooling strains)
Wildtype_complement <- rbind(strain1,strain2)

#combine treatments into dataframe
pyc <-as.data.frame(rbind(Wildtype, mock, Wildtype_complement, Zp_complement, Zt89160_mutant))

#reordering data/ making sure levels are correct
class(pyc$Treatment)
levels(pyc$Treatment)
pyc$Treatment <- factor(pyc$Treatment)
pyc$Treatment = factor(pyc$Treatment, levels(pyc$Treatment)[c(1,8,3,6,2,7,4,5)])
levels(pyc$Treatment)
levels(pyc$Treatment)[index] <- 'treatment'

ggplot(data = pyc, aes(y = pyc$pycnidiaPerCm2Leaf, x = pyc$Treatment, fill = pyc$Treatment)) 
+ geom_boxplot() 
+ geom_signif(comparisons = list(c('Wildtype','Mock'),
                                 c('Wildtype', 'Wt complement'),
                                 c('Wildtype', 'ΔZt89160'),
                                 map_signif_level=T,
                                 y_position = c(40,42,44))) 
+ ggtitle(expression('Virulence Phenotyping for '*italic(gene)*' in Obelisk')) 
+ xlab('Treatment')
+ ylab('Pycnidia Density (pycnidia per Cm^2 of leaf)')
+ theme(axis.text.x=element_text(angle=45))
+ scale_fill_discrete(name=NULL, labels=c('strains or treatments'))

#Stat test = wilcoxon rank sum test or mann-whitney u test, comparing independent samples (treatment) to wildtype
#1) all obs from both groups are independent
#2) responses are ordinal
#3) under h0, distributions are equal
#4) under h1, distributions are not equal

x = pyc$pycnidiaPerCm2Leaf[which(pyc$Treatment=='treatment')] # or 'strain'
y = pyc$pycnidiaPerCm2Leaf[which(pyc$Treatment=='Wildtype')]

#mu = 0 tests if the difference in medians is 0 (no difference)

treatmentnum_object<- wilcox.test(x,y,data = pycnidia, alternative=c(two.sided),
                                  mu=0,paired=FALE,exact=NULL,correct=TRUE,
                                  conf.int=TRUE,conf.level=0.95)

#create dataframes from stat values
P_values_objects<-as.numeric(c(treatment1$p.value, treatment2$p.value)) 
values<-data.frame(objects,row.names=c('treatment1 vs Wt','treatment2 vs Wt'),
                   check.rows = TRUE)

write.csv(values,'file.csv')












