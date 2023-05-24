#!/bin/bash

# Assign values to the variables
sample_dir=$1
vfdb_path="/home/student/BTG/dbs/virulencefinder_db/"
pfdb_path="/home/student/BTG/dbs/plasmidfinder_db/"
output_folder=$2


# Screen the sample_dir for fasta files
files=$(find "$sample_dir" -maxdepth 1 -type f -name "*.fasta" | sort)


# Looping over each of the sample files individually
for sample in $files; do
  # Define the sample name from the file
  sample_name=$(basename "$sample" .fasta)

  mkdir -p "$output_folder"/vf/"$sample_name"
  mkdir -p "$output_folder"/pf/"$sample_name"
  mkdir -p "$output_folder"/af/"$sample_name"

  # Start characterization with finders
  virulencefinder.py -i $sample -p $vfdb_path -o "$output_folder"/vf/$sample_name -xq
  plasmidfinder.py -i $sample -p $pfdb_path -o "$output_folder"/pf/$sample_name -xq
  amrfinder -n $sample -o "$output_folder"/af/$sample_name/amrfinder_results.tsv

done
echo Jobs done!
