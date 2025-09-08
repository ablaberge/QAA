#!/usr/bin/env python

mapped: int = 0
unmapped: int = 0
with open("/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trimmedAligned.out.sam", "r") as fh:
    for line in fh:
        if line.startswith('@'):
            continue
        flag = int(line.split('\t')[1])
        if (flag & 256): # Don't count secondary alignments 
            continue
        elif((flag & 4) != 4): 
            mapped += 1
        else:
            unmapped += 1
print("comrhy_63_EO_6cm/STAR_out/cco_SRR25630298_trimmedAligned.out.sam")
print(f"Number of mapped reads: {mapped}")
print(f"Number of unmapped reads: {unmapped}")

mapped: int = 0
unmapped: int = 0
with open("/projects/bgmp/alaberge/bioinfo/Bi623/QAA/data/comrhy_112_EO_adult/cco_SRR25630380_trimmedAligned.out.sam", "r") as fh:
    for line in fh:
        if line.startswith('@'):
            continue
        flag = int(line.split('\t')[1])
        if (flag & 256): # Don't count secondary alignments 
            continue
        elif((flag & 4) != 4): 
            mapped += 1
        else:
            unmapped += 1
print("comrhy_112_EO_adult/cco_SRR25630380_trimmedAligned.out.sam")
print(f"Number of mapped reads: {mapped}")
print(f"Number of unmapped reads: {unmapped}")