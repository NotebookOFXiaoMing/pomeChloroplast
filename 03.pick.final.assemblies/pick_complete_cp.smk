SAMPLES, = glob_wildcards("01.assemble.results/{sample}/embplant_pt.K105.complete.graph1.1.path_sequence.fasta")

print(SAMPLES)
print(len(SAMPLES))


rule all:
    input:
        expand("02.all_complete_results/{sample}/{sample}.fasta",sample=SAMPLES)

rule pick_and_rename:
    input:
        "01.assemble.results/{sample}/embplant_pt.K105.complete.graph1.1.path_sequence.fasta"
    output:
        "02.all_complete_results/{sample}/{sample}.fasta"
    shell:
        """
        cp {input} {output}
        """
