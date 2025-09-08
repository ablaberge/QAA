#!/usr/bin/env python

import bioinfo
import matplotlib.pyplot as plt
import gzip



output: str = "/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data" 

def populate_list(file: str, readLength: int) -> tuple[dict, float]:
    """Populates a list with the sum of all quality scores in each corresponding read position"""
    qualList: dict = {} # key = read pos, value = summed qual scores @ that pos 
    line_num = 0
    with gzip.open(file,"rt", encoding='utf-8') as fh:
        for line in fh:
            line = line.strip()
            if line_num % 4 == 3:
                for pos,char in enumerate(line):
                    if pos in qualList:
                        qualList[pos] += bioinfo.convert_phred(char)
                    else:
                        qualList[pos] = bioinfo.convert_phred(char)
            line_num += 1
    print(line_num-1)
    num_records = line_num/4
    return qualList,num_records

def makeQualDist(file:str, readLength:int):
    qualList, numRecords = populate_list(file, readLength)
    print("# Base Pair\tMean Quality Score")
    for key in qualList:
        qualList[key] = qualList[key]/numRecords
        print(f"{key}\t{qualList[key]:.2f}")
    plt.scatter(list(qualList.keys()),list(qualList.values()))
    plt.xlabel("Position in Read")
    plt.ylabel("Mean Quality Score")
    filename = file.split('/')[len(file.split('/'))-1]
    plt.title(f"Mean Quality Scores of Reads in {filename}")
    plt.savefig(f"{output}/{filename}_qual.png")
    plt.cla()


# makeQualDist("/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/6GB_RR25630298_2.fastq.gz", 150)
# print("1st plot done")
makeQualDist("/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/6GB_SRR25630298_1.fastq.gz", 150)
print("2nd plot done")
# makeQualDist("/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/3.1GB_SRR25630380_1.fastq.gz", 150)
# print("3rd plot done")
# makeQualDist("/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/3.1GB_SRR25630380_2.fastq.gz", 150)
# print("4th plot done")