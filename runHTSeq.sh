#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=bgmp                  #REQUIRED: which partition to use
#SBATCH --cpus-per-task=6                #optional: number of cpus, default is 1
#SBATCH --time=6:00:00               
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB per cpu
#SBATCH --mail-user=alaberge@uoregon.edu     #optional: if you'd like email
#SBATCH --job-name=htseq            #optional: job name
#SBATCH --output=LOG/htseq_%j.out       #optional: file to store stdout from job, %j adds the assigned jobID
#SBATCH --error=LOG/htseq_%j.err        #optional: file to store stderr from job, %j adds the assigned jobID

conda activate QAA

htseq-count --stranded=yes /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trimmedAligned.out.sam \
    /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/campylomormyrus.gtf \
    > /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trimmedAligned.counts.foward.tsv

htseq-count --stranded=reverse /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trimmedAligned.out.sam \
    /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/campylomormyrus.gtf \
    > /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trimmedAligned.counts.reverse.tsv

htseq-count --stranded=yes /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trimmedAligned.out.sam \
    /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/campylomormyrus.gtf \
    > /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trimmedAligned.counts.foward.tsv

htseq-count --stranded=reverse /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trimmedAligned.out.sam \
    /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/campylomormyrus.gtf \
    > /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trimmedAligned.counts.reverse.tsv