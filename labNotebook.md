## PS2 - Quality trimming

#### Wed Sep 3

- Overall goal of this assignment:
    - process electric organ and/or skeletal muscle RNA-seq reads for a future differential gene expression analysis
        - quality assessment 
        - read trimming 

- My two libraries:
    - SRR25630298    
        - PE, 150 bp RL
        - Size: 6.0 GB
        - Species: Campylomormyrus compressirostris x Campylomormyrus rhynchophorus (comrhy)
        - Tissue: electric organ (eo)
        - Sample: comrhy63
        - Age: 6cm 
        - [PRJNA1005245](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1005245)
        - [link to sra](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR25630298&display=metadata) 
        
    - SRR25630380 
        - PE, 150 bp RL
        - Size: 3.1 GB
        - Species: Campylomormyrus compressirostris x Campylomormyrus rhynchophorus (comrhy)
        - Tissue: electric organ (eo)
        - Sample: comrhy112
        - Age: adult 
        - BioSample number: SAMN36981991
        - [PRJNA1005244](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1005244)
        - [link to SRA](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR25630380&display=metadata)

- Naming convention for data: ``` Species_sample_tissue_age/size_sample#_readnumber.fastq.gz```
- Downloaded, gzipped, and renamed data:
    ```
    prefetch SRR25630380
    fasterq-dump --split-files SRR25630380/SRR25630380.sra
    # spots read      : 32,853,814
    # reads read      : 65,707,628
    # reads written   : 65,707,628
    prefetch SRR25630298
    fasterq-dump --split-files SRR25630298/SRR25630298.sra
    # spots read      : 64,192,480
    # reads read      : 128,384,960
    # reads written   : 128,384,960

    pigz *.fastq
    mkdir comrhy_112_EO_adult
    mkdir comrhy_63_EO_6cm
    mv SRR25630298_1.fastq.gz comrhy_63_EO_6cm/6GB_SRR25630298_1.fastq.gz
    mv SRR25630298_2.fastq.gz comrhy_63_EO_6cm/6GB_SRR25630298_2.fastq.gz
    mv SRR25630380_1.fastq.gz comrhy_112_EO_adult/3.1GB_SRR25630380_1.fastq.gz
    mv SRR25630380_2.fastq.gz comrhy_112_EO_adult/3.1GB_SRR25630380_2.fastq.gz
   
    ```

 - Made a new conda env called "QAA":

    ```
    conda create -n QAA
    conda activate QAA
    ```

- Installed:
    - FastQC (v 0.12.1)
    ```conda install fastqc=0.12.1```
    - Trimmomatic (v 0.39)
    ```conda install trimmomatic=0.39```
    - Cutadapt (v 5.0)
        ```conda install cutadapt=5.0```
        - encountered an error trying to install this with conda
        - tried to use pip instead but ended up w/ version 5.1 
        - made a new env and installed cutadapt first w/ conda, it worked this time
        - takeaway from this bug: cutadapt is really sensitive to python versions

    - SRA toolkit (v 3.2.1)
        - had some trouble remembering the exact name so here it is for future reference:
        ```conda install bioconda::sra-tools```
        - also discovered a handy command to get version of a package:
        ```conda list [package]```

- Ran fastqc 

    ```
    cd comrhy_112_EO_adult/
    fastqc -t 6 *.fastq.gz
    ```
    - Output:
    application/gzip
    application/gzip
    Started analysis of 3.1GB_SRR25630380_1.fastq.gz
    Started analysis of 3.1GB_SRR25630380_2.fastq.gz
    Approx 5% complete for 3.1GB_SRR25630380_1.fastq.gz
    Approx 5% complete for 3.1GB_SRR25630380_2.fastq.gz
    Approx 10% complete for 3.1GB_SRR25630380_1.fastq.gz
    ....
    Approx 95% complete for 3.1GB_SRR25630380_1.fastq.gz
    Approx 95% complete for 3.1GB_SRR25630380_2.fastq.gz
    Analysis complete for 3.1GB_SRR25630380_1.fastq.gz
    Analysis complete for 3.1GB_SRR25630380_2.fastq.gz

    ```
    cd comrhy_63_EO_6cm/
    fastqc -t 6 *.fastq.gz
    ```

    - Output:
    application/gzip
    application/gzip
    Started analysis of 6GB_RR25630298_2.fastq.gz
    Started analysis of 6GB_SRR25630298_1.fastq.gz
    Approx 5% complete for 6GB_SRR25630298_1.fastq.gz
    Approx 5% complete for 6GB_RR25630298_2.fastq.gz
    Approx 10% complete for 6GB_SRR25630298_1.fastq.gz
    Approx 10% complete for 6GB_RR25630298_2.fastq.gz
    ...


#### Sat Sep 6

- Extracted per base qual plots and per base N content plots from fastqc using:

    ``` 
    unzip -l [filename.zip]
    unzip [filname.zip] [path/to/file/in/zip/archive.txt]
    ```

- Ran cutadapt to remove adapters 

    ```
    cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -j 6 -o 6GB_SRR25630298_1_noAdapt.fastq.gz -p 6GB_RR25630298_2_noAdapt.fastq.gz 6GB_SRR25630298_1.fastq.gz 6GB_RR25630298_2.fastq.gz
    ```
     - [Output](cutAdapt_6GB.out)

    ```
    cutadapt -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT -j 6 -o 3.1GB_SRR25630380_1_noAdapt.fastq.gz -p 3.1GB_SRR25630380_2_noAdapt.fastq.gz 3.1GB_SRR25630380_1.fastq.gz 3.1GB_SRR25630380_2.fastq.gz
    ```
    - [Output](cutAdapt_3.1GB.out)

- Ran trimmomatic: 

    -  [manual](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf)
    
    ```
    cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult

    trimmomatic PE -threads 6  3.1GB_SRR25630380_1_noAdapt.fastq.gz 3.1GB_SRR25630380_2_noAdapt.fastq.gz -baseout 3.1GB_SRR25630380_noAdapt.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35 

    cd /projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm

    trimmomatic PE -threads 6 6GB_SRR25630298_1_noAdapt.fastq.gz 6GB_RR25630298_2_noAdapt.fastq.gz -baseout 6GB_SRR25630298_noAdapt.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:5:15 MINLEN:35
    ```

    - [output](trimmomatic.out)

- Installed a bunch more stuff into my QAA conda env:

    - STAR (v2.7.11b)
    ``` conda install star```
    - Picard (v2.18) ~ need this version for it to work with v2.7.11b STAR output
    ```conda install picard=2.18```
    - SAMtools(v1.22.1)
    ```conda install samtools```
    - NumPy (v2.3.2)
    ```conda install numpy```
    - MatplotLib (v3.10.6)  ```conda install matplotlib```
        - Had some major issues trying to install this due to a previous interuptted download causing a corrupt cache package
        - The fix (after much troubleshooting) was manually deleting the cached packages 
            - Beware: error messages may be long and you may not see all the problematic packages in your terminal 
    - HTSeq (v2.0.9) ```conda install htseq```

- Tried to download reference genome using wget and curl (even with a user agent) to no avail
    - Copied files from talapas instead
    ```
    projects/bgmp/shared/Bi623/PS2/campylomormyrus.fasta
    projects/bgmp/shared/Bi623/PS2/campylomormyrus.gff
    ```

- Aligned to ref using STAR
    - Encountered a warning on first run:
    ```
    !!!!! WARNING: --genomeSAindexNbases 14 is too large for the genome size=862592683, which may cause seg-fault at the mapping step. Re-run genome generation with recommended --genomeSAindexNbases 13
    ```
    - Tried rerunning with recommended flag
    - Having problems, I think that using the gff problem (even with reccomended flag) is causing me problems 
    - installed gffread (v0.12.7) with conda to convert gff --> gtf ```conda install gffread```
    - converted to gtf ``` gffread -T input.gff -o output.gtf```
    - ** HELPFUL FUTURE INFO **
        - STAR acts weird when it doesn't have enough memory (and it needs A LOT)
        - if you're getting weird errors (namely missing index files), rerun with the following parameter:
            ``` --limitGenomeGenerateRAM [max RAM] ```
    - Ran successfully with adjusted params!
        - [output](star.out)

- Coordinate-sorted SAM files for picard (input must be sorted this way)
    - Used samtools for sorting
    ```samtools sort -o output.bam input.sam```
     




