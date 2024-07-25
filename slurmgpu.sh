#!/bin/bash -l

#SBATCH -J  lightweight
#SBATCH --time=0-12:00:00
#SBATCH --array=4,20
#SBATCH -p gpu
#SBATCH --gres=gpu:rtx4090:1   
#SBATCH -o outfiles/%A_%a.out
#SBATCH --mem=29G

export PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True


source /storage/homefs/ms23h901/git/ye_VR_Segmentation/.venv/bin/activate

echo "Running Python script: python src/train.py --dir openEDS/openEDS/train/ --opt adam --batch_size 8 --epochs 1"    # $SLURM_ARRAY_TASK_ID

srun --unbuffered python -u src/train.py --dir openEDS/openEDS/train/ --opt adam --batch_size 8 --epochs 1

deactivate
