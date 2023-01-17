import click
import pysam
import statistics

@click.command()
@click.option("--input_bam",help="The path of your bam file.")
@click.option("--chr_id",help="The chromosome id")
@click.option("--output_file",help="The path of your output file.")

def count_read_num_mapped_cp(input_bam,output_file,chr_id):
    """count the number of reads mapped to chloroplast genome"""
    i = 0
    read_len = []
    for read in pysam.AlignmentFile(input_bam).fetch(chr_id):
        if read.is_mapped and read.is_read1 and read.mate_is_mapped:
            i += 1
            if i % 10000 == 0:
                read_len.append(read.query_length)
                
    with open(output_file,'w') as fw:
        fw.write("%s,%d,%d\n"%(chr_id,i,statistics.mean(read_len)))
        
        
if __name__ == '__main__':
    count_read_num_mapped_cp()
    print("Congratulations!")