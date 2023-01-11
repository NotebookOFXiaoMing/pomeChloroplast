SRR,FRR = glob_wildcards("00.raw.fq/" + "{srr}_{frr}.fastq.gz")

#print(SRR,FRR)

rule all:
    input:
        expand("00.fastp.report/" + "{srr}.html",srr=SRR),


rule a_runfastp:
    input:
        read01 = "00.raw.fq/" + "{srr}_1.fastq.gz",
        read02 = "00.raw.fq/" + "{srr}_2.fastq.gz"

    output:
        read01 = "00.fastp.filtered.fq/" + "{srr}_clean_1.fastq.gz",
        read02 = "00.fastp.filtered.fq/" + "{srr}_clean_2.fastq.gz",
        html = "00.fastp.report/" + "{srr}.html",
        json = "00.fastp.report/" + "{srr}.json"

    threads:
        8
    resources:
        mem = 8000
    params:
        "-q 20 --cut_front --cut_tail -l 30"
    shell:
        """
        fastp -i {input.read01} -I {input.read02} -o {output.read01} \
        -O {output.read02} -w {threads} -h {output.html} -j {output.json} \
        {params}
        """
