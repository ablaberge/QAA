#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=bgmp                  #REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                #optional: number of cpus, default is 1
#SBATCH --time=6:00:00               
#SBATCH --mem=16GB                        #optional: amount of memory, default is 4GB per cpu
#SBATCH --mail-user=alaberge@uoregon.edu     #optional: if you'd like email
#SBATCH --job-name=plot            #optional: job name
#SBATCH --output=LOG/plot_%j.out       #optional: file to store stdout from job, %j adds the assigned jobID
#SBATCH --error=LOG/plot_%j.err        #optional: file to store stderr from job, %j adds the assigned jobID

cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult

zcat 3.1GB_SRR25630380_noAdapt_1P.fastq.gz |  grep -A1 -e "^@"| grep -v -e "@" | grep -v -e "--" | \
    awk '{print length ($0)}' | sort -n | uniq -c | \
    sed -E 's/([0-9]+) ([0-9]+)/\1\t\2/' > 3.1GB_SRR25630380_noAdapt_1P_counts.tsv

echo 3.1GB_SRR25630380_noAdapt_1P_counts.tsv is created!

zcat 3.1GB_SRR25630380_noAdapt_2P.fastq.gz |  grep -A1 -e "^@"| grep -v -e "@" | grep -v -e "--" | \
    awk '{print length ($0)}' | sort -n | uniq -c | \
    sed -E 's/([0-9]+) ([0-9]+)/\1\t\2/' > 3.1GB_SRR25630380_noAdapt_2P_counts.tsv

echo 3.1GB_SRR25630380_noAdapt_2P_counts.tsv is created!

./plotReadLenDist.py --r1  3.1GB_SRR25630380_noAdapt_1P_counts.tsv --r2  3.1GB_SRR25630380_noAdapt_2P_counts.tsv \
    --output 3.1GB_SRR25630380_noAdapt_read_len_dist.png

echo First plot is created!

cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm

zcat 6GB_SRR25630298_noAdapt_1P.fastq.gz |  grep -A1 -e "^@"| grep -v -e "@" | grep -v -e "--" | \
    awk '{print length ($0)}' | sort -n | uniq -c | \
    sed -E 's/([0-9]+) ([0-9]+)/\1\t\2/' > 6GB_SRR25630298_noAdapt_1P_counts.tsv

echo 6GB_SRR25630298_noAdapt_1P_counts.tsv is created!

zcat 6GB_SRR25630298_noAdapt_2P.fastq.gz |  grep -A1 -e "^@"| grep -v -e "@" | grep -v -e "--" | \
    awk '{print length ($0)}' | sort -n | uniq -c | \
    sed -E 's/([0-9]+) ([0-9]+)/\1\t\2/' > 6GB_SRR25630298_noAdapt_2P_counts.tsv

echo 6GB_SRR25630298_noAdapt_2P_counts.tsv is created!

./plotReadLenDist.py --r1  6GB_SRR25630298_noAdapt_1P_counts.tsv --r2 6GB_SRR25630298_noAdapt_2P_counts.tsv \
    --output 6GB_SRR25630298_noAdapt_read_len_dist.png

echo Second plot is created! All done!