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

sam to sorted bam and count the number of reads and the number of base pair aand samtools depth

```
python stat_read_num_mapped_cp.py --input_bam map.reads.to.cp/Ch_TSH/check.sorted.bam --chr_id Ch_TSH_cp --output_file map.reads.to.cp/Ch_TSH/Ch_TSH_reads_num.csv

snakemake -s stat_read_num_mapped_cp.smk --cores 8 -p

cat map.reads.to.cp/*/*.csv > reads_and_base.csv
cat map.reads.to.cp/*/*.depth > reads.depth
```

```
df01<-read.csv("D:/Bioinformatics_Intro/organelle-assembly/pome_cp/reads_and_base.csv",
               header = FALSE)
head(df01)
range(df01$V2)
mean(df01$V2)
min(df01$V2)*300/1000000
max(df01$V2)*300/1000000
sum(df01$V2*300)/1000000

library(readr)
df02<-read_delim("D:/Bioinformatics_Intro/organelle-assembly/pome_cp/reads.depth",
                 col_names = FALSE)
head(df02)
library(tidyverse)
df02 %>% 
  group_by(X1) %>% 
  summarise(mean_depth=mean(X3)) %>% pull(mean_depth) %>% 
  range()

df02 %>% 
  group_by(X1) %>% 
  summarise(mean_depth=mean(X3)) %>% 
  pull(mean_depth) %>% 
  mean()
  
  pdf(file = "depth_boxplot.pdf",
    width=10,height = 4)
df02 %>% 
  ggplot(aes(X1,X3))+
  geom_boxplot(outlier.shape = NA)
dev.off()
```
