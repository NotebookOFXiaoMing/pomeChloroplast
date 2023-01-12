input_folder = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/02.all_complete_results/"
output_folder = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/02.all_complete_results_rename/"

import glob
from Bio import SeqIO
for fasta_file in glob.glob(input_folder + "*_cp/*_cp.fasta"):
    output_fasta = fasta_file.split("\\")[-1]
    seq_id = fasta_file.split("\\")[-2]
    fw = open(output_folder+output_fasta,'w')
    for rec in SeqIO.parse(fasta_file,'fasta'):
        fw.write(">%s\n%s\n"%(seq_id,str(rec.seq)))
        
    fw.close()
