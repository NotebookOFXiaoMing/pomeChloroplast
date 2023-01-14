```
conda activate chloroplast
conda install mafft
# mafft-7.508
cat 02.all_complete_results_rename/*.fasta > all_100_cp.fa
mafft --thread 8 all_100_cp.fa > all_100_cp_aligned.fa
iqtree2 -s all_100_cp_aligned.fa -bb 1000
```

convert fasta to aln

```
java -jar ~/biotools/ALTER-master/alter-lib/target/ALTER-1.3.4-jar-with-dependencies.jar -i all_100_cp_aligned.fa -ia -o all_100_cp_aligned.aln -of ALN -oo Linux -op MEGA
```

convert aln to vcf http://lindenb.github.io/jvarkit/MsaToVcf.html


```
import re
aln_file = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/all_100_cp_aligned.aln"
full_seq = {}
for line in open(aln_file,'r'):
    elements = [element.strip() for element in line.split()]
    if len(elements) == 2 and "*" not in line:
        full_seq[elements[0]] = full_seq.get(elements[0],'') + elements[1]
    if "*" in line or len(re.sub('^                  ','',line.rstrip("\n"))) == 60:
        full_seq['v1'] = full_seq.get('v1','') + re.sub('^                  ','',line.rstrip("\n"))
        
fw01 = {}
for x in full_seq.keys():
    fw01[x] = []
for i in range(len(full_seq['Ch_BHYSZ_cp'])):
    for x in full_seq.keys():
        fw01[x].append(full_seq[x][i])
        
import pandas as pd
pd.DataFrame(fw01).to_csv('abc.csv',index=False)
```
