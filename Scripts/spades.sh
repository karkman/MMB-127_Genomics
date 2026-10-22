#!/bin/bash -l
#SBATCH --job-name spades
#SBATCH --output slurm_logs/spades_out_%j.txt
#SBATCH --error slurm_logs/spades_err_%j.txt
#SBATCH --time 1:00:00
#SBATCH --nodes 1
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 12
#SBATCH --mem 15G
#SBATCH --account project_2020859

module load bio-apps
module load spades

spades.py -1 trimmed_illumina/MMB-114_trimmed_1.fastq.gz \
          -2 trimmed_illumina/MMB-114_trimmed_2.fastq.gz \
          -t $SLURM_CPUS_PER_TASK \
          --careful \
          --tmp-dir $TMPDIR \
          -o spades_out

