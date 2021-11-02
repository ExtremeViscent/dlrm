#!/bin/bash

export PATH=/opt/anaconda3/bin:$PATH
export LD_LIBRARY_PATH=/opt/anaconda3/lib:$LD_LIBRARY_PATH
export PATH=/opt/ucc/bin:$PATH
export LD_LIBRARY_PATH=/opt/ucc/lib:$LD_LIBRARY_PATH
export PATH=/opt/ucx/bin:$PATH
export LD_LIBRARY_PATH=/opt/ucx/lib:$LD_LIBRARY_PATH
. /opt/anaconda3/etc/profile.d/conda.sh
module load ucc-0.1
module load ucx-1.11
module load nvhpc
conda activate dlrm
conda install -y pytorch==1.7.1 torchvision==0.8.2 torchaudio==0.7.2 cudatoolkit=10.1 -c pytorch