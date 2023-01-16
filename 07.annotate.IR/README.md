Inverted repeat regions were annotated using online tool GeSeq. https://chlorobox.mpimp-golm.mpg.de/geseq.html

we got gff format files and then calculated the length of LSC, SSC, and IRs

```
from BCBio import GFF
from Bio import SeqIO
from Bio.SeqUtils import GC

in_gff = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/GeSeqJob-20230104-110542_GLOBAL_multi-GFF3.gff3"
fasta_folder = "D:/Bioinformatics_Intro/organelle-assembly/pome_cp/all_complete_results_rename/"

df_dict = {'seq_id':[],
           'seq_len':[],
          'LSC_len':[],
          'SSC_len':[],
          'IR_len':[],
          'seq_GC':[],
          'LSC_GC':[],
          'SSC_GC':[],
          'IR_GC':[]}
          
for rec in GFF.parse(in_gff):
    cp_seq = SeqIO.to_dict(SeqIO.parse(fasta_folder + rec.id + ".fasta",'fasta'))[rec.id].seq
    df_dict['seq_id'].append(rec.id)
    df_dict['seq_len'].append(len(cp_seq))
    df_dict['seq_GC'].append(round(GC(cp_seq),2))
    for feature in rec.features:
        if 'Note' in feature.qualifiers.keys() and feature.qualifiers['Note'][0] == 'small_single_copy_(SSC)':
            df_dict['SSC_GC'].append(round(GC(feature.extract(cp_seq)),2)),
            df_dict['SSC_len'].append(len(feature.extract(cp_seq)))
        if 'Note' in feature.qualifiers.keys() and feature.qualifiers['Note'][0] == 'large_single_copy_(LSC)':
            df_dict['LSC_GC'].append(round(GC(feature.extract(cp_seq)),2)),
            df_dict['LSC_len'].append(len(feature.extract(cp_seq)))
        if 'Note' in feature.qualifiers.keys() and feature.qualifiers['Note'][0] == 'inverted_repeat_A_(IRA)':
            df_dict['IR_GC'].append(round(GC(feature.extract(cp_seq)),2)),
            df_dict['IR_len'].append(len(feature.extract(cp_seq)))
            
            
import pandas as pd

pd.DataFrame(df_dict).to_csv("pome_cp_len.csv",index=False)
```

```
df<-read.csv("D:/Bioinformatics_Intro/organelle-assembly/pome_cp/pome_cp_len.csv")
colnames(df)
table(df$seq_len)
range(df$seq_len)
mean(df$seq_len)
table(df$LSC_len)
mean(df$LSC_len)
table(df$SSC_len)
mean(df$SSC_len)
table(df$IR_len)

table(df$LSC_GC)
mean(df$LSC_GC)
table(df$SSC_GC)
mean(df$SSC_GC)
table(df$IR_GC)
mean(df$IR_GC)

table(df$seq_GC)
mean(df$seq_GC)

```
