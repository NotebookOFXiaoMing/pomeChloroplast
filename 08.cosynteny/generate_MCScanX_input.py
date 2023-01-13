import click
from Bio import SeqIO

@click.command()
@click.option('--gb',help="The path of your genbank file.")
@click.option('--protein_fasta',help="The path of output protein fasta.")
@click.option('--gff',help="The path of output gff")


def generate_MCScanX_input(gb,protein_fasta,gff):
    """output protein fasta and simple gff."""
    fw01 = open(protein_fasta,'w')
    fw02 = open(gff,'w')
    seq_ids = []
    for rec in SeqIO.parse(gb,'gb'):
        for feature in rec.features:
            if feature.type == "CDS" and feature.qualifiers['gene'][0] != 'rps12':
                protein_seq = feature.extract(rec.seq).translate()
                seq_id = feature.qualifiers['gene'][0]
                if seq_id not in seq_ids:
                    seq_ids.append(seq_id)
                    fw01.write(">%s\n%s\n"%(seq_id,str(protein_seq).replace("*","")))
                    
                    start = feature.location.start + 1
                    
                    end = feature.location.end
                    
                    chromosome = rec.annotations['organism'].replace(' ','_')
                    
                    fw02.write("%s\t%s\t%d\t%d\n"%(chromosome,seq_id,start,end))
                    
    fw01.close();fw02.close()
    
    click.echo(f"Well done, you got { protein_fasta } and { gff }!")
        
if __name__ == '__main__':
    generate_MCScanX_input()