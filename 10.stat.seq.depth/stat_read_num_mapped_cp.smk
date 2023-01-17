SAMPLES, = glob_wildcards("map.reads.to.cp/{sample}/check.sam")

print(SAMPLES)

rule all:
    input:
        expand("map.reads.to.cp/{sample}/check.sorted.bam.bai",sample=SAMPLES),
        expand("map.reads.to.cp/{sample}/{sample}_reads_num.csv",sample=SAMPLES)

rule samtools_sorted:
    input:
        "map.reads.to.cp/{sample}/check.sam"
    output:
        "map.reads.to.cp/{sample}/check.sorted.bam"
    threads:
        2
    shell:
        """
        samtools sort -@ {threads} -o {output} {input}
        """

rule samtools_index:
    input:
        rules.samtools_sorted.output
    output:
        "map.reads.to.cp/{sample}/check.sorted.bam.bai"
    threads:
        2
    shell:
        """
        samtools index {input}
        """

rule count_reads_number:
    input:
        rules.samtools_sorted.output
    output:
        "map.reads.to.cp/{sample}/{sample}_reads_num.csv"
    threads:
        1
    params:
        "{sample}" + "_cp"
    shell:
        """
        python stat_read_num_mapped_cp.py --input_bam {input} --chr_id {params} --output_file {output}
        """