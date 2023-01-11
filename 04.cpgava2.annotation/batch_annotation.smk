SAMPLES,CPS = glob_wildcards("02.all_complete_results/{sample}/{cp}.fasta")

print(len(SAMPLES))

import subprocess

for sample in SAMPLES:
    cmd = ['singularity','exec','cpgavas2_0.03.sif','run-cpgavas2','-pid',
    sample,'-in',"02.all_complete_results/"+sample+"/"+sample+".fasta",'-db','3','-ref','sequence.gb']
    print(' '.join(cmd))
    subprocess.run(cmd)
    
    
    
import glob

for gb_file in glob.glob("/tmp/dir_*/*_cp.gbf"):
    cmd = ['cp',gb_file,'03.all_annotations']
    print(' '.join(cmd))
    subprocess.run(cmd)
    
input_folder = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/03.all_annotations/"
output_folder = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/04.all_annotations_edited"

from Bio import SeqIO

for gb_file in glob.glob(input_folder + "*.gbf"):
    output_gb = gb_file.split("\\")[-1]
    fw = open(output_folder + "/" + output_gb,'w')
    for rec in SeqIO.parse(gb_file,'gb'):
        rec.annotations['source'] = ref.annotations['source']
        rec.annotations['organism'] = ref.annotations['organism']
        rec.annotations['taxonomy'] = ref.annotations['taxonomy']
        rec.description = 'Punica granatum chloroplast, complete genome'
    
    for feature in rec.features:
        if feature.type == "source":
            feature.qualifiers['organism'] = ['Punica granatum']
            feature.qualifiers['db_xref'] = ["taxon:22663"]
    
    SeqIO.write(rec,fw,'gb')
