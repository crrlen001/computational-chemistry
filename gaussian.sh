#!/bin/bash

read -p 'Account Group (e.g. physics): ' accountvar
read -p 'Type of Partition (e.g. normal): ' partitionvar
read -p 'Number of Nodes: ' nodevar
read -p 'Number of Total Tasks: ' taskvar
read -p 'Time (hours:minutes:seconds): ' timevar
read -p 'Input File Name: ' inputvar
read -p 'Input Extension: ' extvar
read -p 'Please insert e-mail address: ' emailvar

echo "#!/bin/bash
#SBATCH --account=$accountvar
#SBATCH --partition=$partitionvar
#SBATCH --nodes=$nodevar --ntasks=$taskvar
#SBATCH --time=$timevar
#SBATCH --job-name=\"$inputvar\"
#SBATCH --mail-user=$emailvar
#SBATCH --mail-type=BEGIN,END,FAIL

module load software/gaussian-09 #PATH TO Gaussian09 Module

export GAUSS_SCRDIR=\$SLURM_SUBMIT_DIR/\$SLURM_JOB_ID #Directory in which calculations/computations will be performed 
mkdir -p \$GAUSS_SCRDIR #Create the directory

export GAUSS_EXEDIR=/home/../opt/exp_soft/g09 #PATH TO Gaussian09 folder

submitdir=\$SLURM_SUBMIT_DIR #Directory in which the job file was submitted
tempdir=\$GAUSS_SCRDIR #Temporary directory in which the computations are done

cp \$submitdir/${inputvar}.${extvar} \$tempdir #Copy input file to temporary directory
cd \$tempdir #Change directory to temporary directory

time g09 < ${inputvar}.${extvar} > ${inputvar}.log #Perform the gaussian09 computation

cp ${inputvar}.log \$submitdir #Copy output file to the submission directory
cp ${inputvar}.chk \$submitdir #Copy checkpoint file to the submission directory

rm -rf \$tempdir #Remove temporary directory

echo \"Job Finished at\"
date
####### Job Ended ######
exit 0" > $(pwd)/g09.sbatch #File is written to the directory in which the gaussian.sh bash script is run.
