```
conda activate chloroplast
conda install mafft
# mafft-7.508
cat 02.all_complete_results_rename/*.fasta > all_100_cp.fa
mafft --thread 8 all_100_cp.fa > all_100_cp_aligned.fa
iqtree2 -s all_100_cp_aligned.fa -bb 1000
```
