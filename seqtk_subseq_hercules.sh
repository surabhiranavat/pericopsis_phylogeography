#!/bin/bash
# Submission script for Hercules2
#SBATCH --job-name=subseq
#SBATCH --time=02:00:00 # days-hh:mm:ss
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8192 # 8GB
#SBATCH --partition=batch
#SBATCH --array=0-111
#
#SBATCH --mail-user=surabhi.ranavat@ulb.be
#SBATCH --mail-type=ALL
#
#SBATCH --comment=Pericopsis
#
#SBATCH --output=subseq_log_%j.txt


ml releases/2021b
ml seqtk/1.3-GCC-11.2.0

export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1

echo "Job started on $(date)"

cd /CECI/proj/eeg/hardy_lab/Pericopsis/trimmed_seq

declare -a file_name
for f1 in *.fastq.gz; do file_name+=($(basename $f1 .fastq.gz)); done

file_prefix=${file_name[$SLURM_ARRAY_TASK_ID]}

input_file=${file_prefix}.fastq.gz

echo "---Sampling 10M reads per fastq for plastome analyses---"

seqtk sample -s100 ${input_file} 10000000 > plastome/${file_prefix}.sub.fq | gzip

echo "Job ended on $(date)"
