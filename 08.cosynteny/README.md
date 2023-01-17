## co synteny analysis

```
python generate_MCScanX_input.py --gb your_input.gb --protein_fasta output.fasta --gff output.gff

python .\generate_MCScanX_input.py --gb .\co_synteny\MG921615.gb --protein_fasta .\co_synteny\MCScanX_input\MG921615.fasta --gff .\co_synteny\MCScanX_input\MG921615.gff

python .\generate_MCScanX_input.py --gb .\co_synteny\NC_030484.gb --protein_fasta .\co_synteny\MCScanX_input\NC_030484.fasta --gff .\co_synteny\MCScanX_input\NC_030484.gff

python .\generate_MCScanX_input.py --gb .\co_synteny\NC_037023.gb --protein_fasta .\co_synteny\MCScanX_input\NC_037023.fasta --gff .\co_synteny\MCScanX_input\NC_037023.gff

python .\generate_MCScanX_input.py --gb .\co_synteny\NC_039975.gb --protein_fasta .\co_synteny\MCScanX_input\NC_039975.fasta --gff .\co_synteny\MCScanX_input\NC_039975.gff

python .\generate_MCScanX_input.py --gb .\co_synteny\MK603511.gb --protein_fasta .\co_synteny\MCScanX_input\MK603511.fasta --gff .\co_synteny\MCScanX_input\MK603511.gff


cat .\co_synteny\MCScanX_input\*.fasta > cp.fasta
cat .\co_synteny\MCScanX_input\*.gff > cp.gff

# conda install blast

makeblastdb -in cp.fasta -dbtype prot -parse_seqids -out cp_fasta.db/pde_ptr
blastp -query cp.fasta -out cp.blast -db cp_fasta.db/pde_ptr -outfmt 6 -evalue 1e-5

~/biotools/MCScanX-master/MCScanX cp
```

visualize results using online tool SynVisio https://synvisio.github.io/#/
