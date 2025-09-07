#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=bgmp                  #REQUIRED: which partition to use
#SBATCH --cpus-per-task=6                #optional: number of cpus, default is 1
#SBATCH --time=6:00:00               
#SBATCH --mem=20GB                        #optional: amount of memory, default is 4GB per cpu
#SBATCH --mail-user=alaberge@uoregon.edu     #optional: if you'd like email
#SBATCH --job-name=picard            #optional: job name
#SBATCH --output=LOG/picard_%j.out       #optional: file to store stdout from job, %j adds the assigned jobID
#SBATCH --error=LOG/picard_%j.err        #optional: file to store stderr from job, %j adds the assigned jobID

conda activate QAA

picard MarkDuplicates INPUT=/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trim_align_sort.bam \
    OUTPUT=/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/picard_out/cco_SRR25630298_marked_dups.bam \
    METRICS_FILE=/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/picard_out/SRR25630298_marked_dups_metrics.txt \
    REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=LENIENT

picard MarkDuplicates INPUT=/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trim_align_sort.bam \
    OUTPUT=/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/picard_out/cco_SRR25630380_marked_dups.bam \
    METRICS_FILE=/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/picard_out/SRR25630380_marked_dups_metrics.txt \
    REMOVE_DUPLICATES=TRUE VALIDATION_STRINGENCY=LENIENT

samtools view -h -o /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/picard_out/cco_SRR25630380_marked_dups.sam \
    /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/picard_out/cco_SRR25630380_marked_dups.bam 

samtools view -h -o projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/picard_out/cco_SRR25630298_marked_dups.sam\
    /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/picard_out/cco_SRR25630298_marked_dups.bam