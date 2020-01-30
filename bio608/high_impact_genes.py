'''Counts number of high impact genes above a given threshold/filters matched
 SnpEff genes that contain 10+ SNPs'''

import pandas as pd, csv, numpy as np

data=pd.read_csv('/home/small/Documents/Biol608_project/ComparisonTempGenes_Snps.out', delimiter= '\t', sep=',')
df=pd.DataFrame(data)
#print data
datafil=(data.loc[data['Variants impact HIGH'] >= 10])
print datafil
print len(datafil)
