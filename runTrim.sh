#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=bgmp                  #REQUIRED: which partition to use
#SBATCH --cpus-per-task=6                #optional: number of cpus, default is 1
#SBATCH --time=6:00:00               
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB per cpu
#SBATCH --mail-user=alaberge@uoregon.edu     #optional: if you'd like email
#SBATCH --job-name=trim            #optional: job name
#SBATCH --output=LOG/trim_%j.out       #optional: file to store stdout from job, %j adds the assigned jobID
#SBATCH --error=LOG/trim_%j.err        #optional: file to store stderr from job, %j adds the assigned jobID


cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult

trimmomatic PE -threads 6  3.1GB_SRR25630380_1_noAdapt.fastq.gz 3.1GB_SRR25630380_2_noAdapt.fastq.gz \
    -baseout 3.1GB_SRR25630380_noAdapt.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35 

cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm

trimmomatic PE -threads 6 6GB_SRR25630298_1_noAdapt.fastq.gz 6GB_RR25630298_2_noAdapt.fastq.gz \
    -baseout 6GB_SRR25630298_noAdapt.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35