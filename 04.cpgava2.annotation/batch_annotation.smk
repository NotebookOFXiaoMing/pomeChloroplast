SAMPLES,CPS = glob_wildcards("02.all_complete_results/{sample}/{cp}.fasta")

print(len(SAMPLES))

import subprocess

for sample in SAMPLES:
    cmd = ['singularity','exec','cpgavas2_0.03.sif','run-cpgavas2','-pid',
    sample,'-in',"02.all_complete_results/"+sample+"/"+sample+".fasta",'-db','3','-ref','sequence.gb']
    print(' '.join(cmd))
    subprocess.run(cmd)
