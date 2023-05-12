configfile: "config/config.yaml"
include: "rules/create_summary_and_plots.smk"
include: "rules/zip_summary_and_plots.smk"

FILENAMES = glob_wildcards('inputs/{name}.csv')
FILENAMES = FILENAMES.name

rule all:
    input:
        expand("outputs/{name}.summary.csv", name=FILENAMES),
        expand("outputs/{name}.png", name=FILENAMES),
        expand("final-analysis/{name}.analysis.tar", name=FILENAMES)