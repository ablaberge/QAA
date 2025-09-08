#!/usr/bin/env python


import argparse
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from pathlib import Path

def getArgs():
        
    parser = argparse.ArgumentParser(
        description="Plot trimmed read length distributions for paired R1 and R2 reads"
    )
    parser.add_argument(
        '--r1', 
        required=True,
        help='TSV file containing R1 read length counts'
    )
    parser.add_argument(
        '--r2', 
        required=True,
        help='TSV file containing R2 read length counts'
    )
    parser.add_argument(
        '--output', 
        required=True,
        help='Output file name'
    )
    
    args = parser.parse_args()
    return args


def plot_read_length_distribution(r1_file, r2_file, output):
    """
    Plot trimmed read length distributions for paired R1 and R2 reads
    """

    r1_data = pd.read_csv(r1_file, sep='\t', header=0)
    r2_data = pd.read_csv(r2_file, sep='\t', header=0)
    
    r1_lengths = r1_data.iloc[:, 1] 
    r1_counts = r1_data.iloc[:, 0]  
    
    r2_lengths = r2_data.iloc[:, 1] 
    r2_counts = r2_data.iloc[:, 0]   
    
    plt.figure(figsize=(12, 6))
    plt.plot(r1_lengths, r1_counts, label='R1 (Forward)', alpha=0.8, linewidth=2)
    plt.plot(r2_lengths, r2_counts, label='R2 (Reverse)', alpha=0.8, linewidth=2)
    plt.xlabel('Read Length (bp)')
    plt.ylabel('Number of Reads')
    plt.title('Trimmed Read Length Distribution - Paired Reads')
    plt.legend()
    plt.grid(True, alpha=0.3)
    

    all_lengths = np.concatenate([r1_lengths, r2_lengths])
    plt.xlim(min(all_lengths) - 5, max(all_lengths) + 5)
    
    
    plt.savefig(output, dpi=300, bbox_inches='tight')
    plt.close()
    
    print(f"Plot saved to: {output}")
    print(f"\nR1 Summary:")
    print(f"  Total reads: {r1_counts.sum():,}")
    print(f"  Mean length: {np.average(r1_lengths, weights=r1_counts):.1f} bp")
    print(f"  Length range: {r1_lengths.min()}-{r1_lengths.max()} bp")
    
    print(f"\nR2 Summary:")
    print(f"  Total reads: {r2_counts.sum():,}")
    print(f"  Mean length: {np.average(r2_lengths, weights=r2_counts):.1f} bp")
    print(f"  Length range: {r2_lengths.min()}-{r2_lengths.max()} bp")

def main():

    args = getArgs()
    plot_read_length_distribution(args.r1, args.r2, args.output)

if __name__ == "__main__":
    main()