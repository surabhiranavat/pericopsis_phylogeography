##Running RAxML-NG on ebe1

mamba activate raxml

##First check if the alignment can be read by RAxML

raxml-ng --check --msa combined_choi_pericopsis_oh.fasta --model GTR+G --prefix T1

#infer a tree under GTR+GAMMA with default parameters. This command will perform 20 tree searches
#using 10 random and 10 parsimony-based starting trees, and pick the best-scoring topology

raxml-ng --msa combined_choi_pericopsis_oh.fasta --model GTR+G --prefix T2 --threads 10 --seed 2

##Bootstrapping with 200 replicates
raxml-ng --bootstrap --msa combined_choi_pericopsis_oh.fasta --model GTR+G --prefix BS_T3 --seed 2 --threads 10 --bs-trees 200

#Posthoc checking of the bootstrap trees

raxml-ng --bsconverge --bs-trees T7.raxml.bootstraps --prefix T9 --seed 2 --threads 2 --bs-cutoff 0.01



raxml-ng --msa filtered_choi_combined_oh_rd2.fasta --model GTR+G --prefix T2 --threads 10 --seed 2

raxml-ng --bootstrap --msa filtered_choi_combined_oh_rd2.fasta --model GTR+G --prefix BS_filtered_rd2_choi --seed 2 --threads 10 --bs-trees 200

##For Pericopsis only
raxml-ng --bootstrap --msa Pericopsis52plastomes (stripped) (modified).fasta --model GTR+G --prefix BS_Pericopsis_only_raxml --seed 2 --threads 4 --bs-trees 400

raxml-ng --bsconverge --bs-trees BS_Pericopsis_only_raxml.raxml.bootstraps --prefix Pericopsis_only_bootstrap --seed 2 --threads 2 --bs-cutoff 0.01

raxml-ng --bootstrap --msa Pericopsis52plastomes (stripped) (modified).fasta --model GTR+G --prefix Test_BS --seed 2 --threads 2
