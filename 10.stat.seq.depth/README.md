```
import glob
import subprocess

for fq in glob.glob("huoyan_14_variety/*.fq.gz"):
     if fq.split("/")[-1] not in [fq1.split("/")[-1] for fq1 in glob.glob("01.raw/*.fq.gz")]:
             cmd = ['cp',fq,'01.raw']
             print(' '.join(cmd))
             subprocess.run(cmd)
```

map total reads to cp

```
SAMPLES, = glob_wildcards("organelle_assembly/all_complete_results_rename/{sample}_cp.fasta")

print(SAMPLES)

rule all:
    input:
        expand("map.reads.to.cp/{sample}/check.sam",sample=SAMPLES)


rule bowtie2_map:
    input:
        cp_fasta = "organelle_assembly/all_complete_results_rename/{sample}_cp.fasta",
        R1 = "01.raw/{sample}_1.fq.gz",
        R2 = "01.raw/{sample}_2.fq.gz"
    output:
        "map.reads.to.cp/{sample}/check.sam"

    params:
        "map.reads.to.cp/{sample}"
    threads:
        4
    resources:
        mem = 8000
    shell:
        """
        evaluate_assembly_using_mapping.py -f {input.cp_fasta} -1 {input.R1} -2 {input.R2} -o {params} -t {threads} --draw
        """
```

```
#!/bin/bash

#SBATCH --job-name="map_cp"
#SBATCH --mail-user=mingyan24@126.com
#SBATCH --mail-type=END,FAIL

source activate chloroplast
snakemake --cluster "sbatch --output=/mnt/shared/scratch/myan/private/pome_WGS/slurm.out/%j.out \
--error=/mnt/shared/scratch/myan/private/pome_WGS/slurm.out/%j.out --cpus-per-task={threads} \
--mail-type=FAIL --mail-user=mingyan24@126.com --mem={resources.mem}" \
--jobs 12 -s map_reads_to_cp.smk
```

```
sbatch run_map_reads_to_cp.sh
```
