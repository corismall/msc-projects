import glob

files = glob.glob('/Users/Corinn/Documents/CAU/biol608/project_assemblies/Sp*.fa')

for file in files:
	path_split = file.split("/")
	strain = path_split[-1].split(".fa")[0]
	old_fasta = open(file, "r")
	old_fastaR = old_fasta.readlines()
	new_fasta = open("/Users/Corinn/Documents/CAU/biol608/project_assemblies/" + strain + ".fa", "w")

	for line in old_fastaR:
		if ">" in line:
			split1 = line.split("_")[0]
			#if "_" in split1:
				#split1.replace("_", ".")
			#scaffold = split1.split(".")[0]
			new_line = split1 + "\n"

			print new_line

			new_fasta.write(new_line)

		else:
			new_fasta.write(line)
			pass

	old_fasta.close()
	new_fasta.close()
	print("done")
