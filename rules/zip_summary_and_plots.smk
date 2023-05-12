rule zip_summary_and_plots:
    input: 
        summary=rules.create_summary_and_plots.output.summary,
        boxplot=rules.create_summary_and_plots.output.boxplot,
    output: 
        package_files="final-analysis/{name}.analysis.tar",
    params:
        column=config["columnname"]
    threads: 2
    resources: mem_mb=2048, time_min=120
    singularity: config["container"]
    shell:
        """
        mkdir -p final-analysis
        tar -cvf {output.package_files} {input.summary} {input.boxplot}
        """
