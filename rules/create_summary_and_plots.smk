rule create_summary_and_plots:
    input: "inputs/{name}.csv"
    output: 
        summary="outputs/{name}.summary.csv",
        boxplot="outputs/{name}.png",
    params:
        column=config["columnname"]
    threads: 2
    resources: mem_mb=2048, time_min=120
    singularity: config["container"]
    shell:
        """
        mkdir -p outputs
        Rscript /usr/local/src/myscripts/myscript.R  {input} {params.column}
        mv inputs/{wildcards.name}.summary.csv outputs/{wildcards.name}.summary.csv
        mv inputs/{wildcards.name}.png outputs/{wildcards.name}.png
        """
