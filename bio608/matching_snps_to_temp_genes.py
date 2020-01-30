'''match genes containing non-synonymous SNPs (SnpEff output) to
"heat sensitivity" gene database from phenotype ontology "temperature sensitive growth"
https://www.yeastgenome.org/observable/APO:0000147'''

#create list for heat sensitive genes
with open('/home/small/Documents/Biol608_project/heat_sensitivity_annotations.txt', 'r') as hsg:
	gene_list=[]
	for i in hsg:
		try:
			gene = i.strip().split()[0]
			gene_list.append(gene)
		except:
			pass
			#print i
#filtering heat sensitive genes containing high impact SNPs
out = open('/home/small/Documents/Biol608_project/ComparisonTempGenes_Snps.out', "a")
with open ('/home/small/Documents/Biol608_project/snpEff_genes.txt', "r") as snpeff:
	count0=0
	count=0
	count2=0
	count3=0
	for index1, l in enumerate(snpeff):
		count0+=1
		gene_name=l.split("\t")[0]
		if '%s' % gene_name in gene_list:
			count += 1
			out.write(l)
		else:
			count3+=1
		#print "test2", l
		count2+=1

print 'All genes count:', index1
print 'Lines tested count:', count0
print 'Lines of Temperature genes countin both:', count
print 'weird lines count', count2
print 'weird lines count2', count3
