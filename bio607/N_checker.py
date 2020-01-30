import glob
from Bio import SeqIO

files = glob.glob('/Users/Corinn/Documents/CAU/biol608/assemblies/para/strains/DBVPG4650/assembly/*.fa')

for file in files:
	print file
	for seq in SeqIO.parse(file, 'fasta'):
		if 'N' == seq.seq[-1]:
			print "yeah"
