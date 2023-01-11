

SRR,FRR = glob_wildcards("00.fastp.filtered.fq/" + "{srr}_clean_{frr}.fastq.gz")

print(SRR)
print(len(SRR))

rule all:
    input:
        expand("01.assemble.results/" + "{srr}_cp/get_org.log.txt",srr=SRR)

rule assemble_cp:
    input:
        read01 = "00.fastp.filtered.fq/" + "{srr}_clean_1.fastq.gz",
        read02 = "00.fastp.filtered.fq/" + "{srr}_clean_2.fastq.gz"
    output:
        "01.assemble.results/" + "{srr}_cp/get_org.log.txt"
    threads:
        8
    params:
        output_folder = "01.assemble.results/" + "{srr}_cp"
    shell:
        """
        get_organelle_from_reads.py -1 {input.read01} -2 {input.read02} \
        -o {params.output_folder} -R 15 -k 85,105 -F embplant_pt -t {threads} \
        --overwrite
        """
