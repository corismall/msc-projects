'''creation of function that iterates thru fasta file and creates each scaffold
into 1 line from multiple lines'''

import os, itertools

def fasta_iter(fasta_name) :
	fh = open(fasta_name)
	fa_iter = (x[1] for x in itertools.groupby(fh, lambda line: line[0] == ">"))
	for header in fa_iter:
		header = header.next()[1:].strip()
		sequence = "".join(s.strip() for s in fa_iter.next())
		yield header, sequence

out = open("/Users/Corinn/Documents/CAU/biol608/DBVPG4650_script/DBVPG4650_new_filtered.fa", 'w')

it = fasta_iter("DBVPG4650_new.fa") #it is the single-lined fasta

'''counting the length of each scaffold and only including scaffolds longer than
1000 bp into the new folder'''

for (header,sequence) in it :
	print header
	if len(sequence) > 1000:
		out.write(">" + header + "\n" + sequence + "\n")

out.close()
