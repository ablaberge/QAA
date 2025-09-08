#!/bin/bash

#SBATCH --account=bgmp                    #REQUIRED: which account to use
#SBATCH --partition=bgmp                  #REQUIRED: which partition to use
#SBATCH --cpus-per-task=8                #optional: number of cpus, default is 1
#SBATCH --time=6:00:00               
#SBATCH --mem=20GB                        #optional: amount of memory, default is 4GB per cpu
#SBATCH --mail-user=alaberge@uoregon.edu     #optional: if you'd like email
#SBATCH --job-name=star            #optional: job name
#SBATCH --output=LOG/star_%j.out       #optional: file to store stdout from job, %j adds the assigned jobID
#SBATCH --error=LOG/star_%j.err        #optional: file to store stderr from job, %j adds the assigned jobID

conda activate QAA 

cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome



STAR --runThreadN 8 \
    --runMode genomeGenerate \
    --genomeDir /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/Campylomormyrus_compressirostris.dna.STAR_2.7.11b \
    --genomeFastaFiles /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/campylomormyrus.fasta \
    --sjdbGTFfile /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/campylomormyrus.gtf \
    --genomeSAindexNbases 13 --limitGenomeGenerateRAM 19000000000

STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/6GB_SRR25630298_noAdapt_1P.fastq.gz /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/6GB_SRR25630298_noAdapt_2P.fastq.gz \
    --genomeDir /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/Campylomormyrus_compressirostris.dna.STAR_2.7.11b \
    --outFileNamePrefix /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/cco_SRR25630298_trimmed

STAR --runThreadN 8 --runMode alignReads \
    --outFilterMultimapNmax 3 \
    --outSAMunmapped Within KeepPairs \
    --alignIntronMax 1000000 --alignMatesGapMax 1000000 \
    --readFilesCommand zcat \
    --readFilesIn /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/3.1GB_SRR25630380_noAdapt_1P.fastq.gz /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/3.1GB_SRR25630380_noAdapt_2P.fastq.gz \
    --genomeDir /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/refGenome/Campylomormyrus_compressirostris.dna.STAR_2.7.11b \
    --outFileNamePrefix /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trimmed


