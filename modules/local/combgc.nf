process COMBGC {
    tag "comBGC"

    conda (params.enable_conda ? "conda-forge::python=3.8.3" : null)
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/biopython:1.75' :
        'quay.io/biocontainers/biopython:1.75' }"

    input:
    path antismash_dir
    path deepbgc_dir
    path gecco_dir
    path out_dir

    output:
    path "${out_dir}/combgc_summary.tsv" , emit: tsv

    script: // This script is bundled with the pipeline, in nf-core/funcscan/bin/
    def antismash_dir = antismash_dir ? "--antismash $antismash_dir": ""
    def deepbgc_dir = deepbgc_dir ? "--deepbgc $deepbgc_dir": ""
    def gecco_dir = gecco_dir ? "--gecco $gecco_dir": ""
    def out_dir = out_dir ? "--outdir $out_dir": ""
    """
    comBGC.py \\
        $antismash_dir \\
        $deepbgc_dir \\
        $gecco_dir \\
        $out_dir
    """
}
