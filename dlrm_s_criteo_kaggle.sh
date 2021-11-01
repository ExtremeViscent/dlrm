  #!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.
#
#WARNING: must have compiled PyTorch and caffe2

#check if extra argument is passed to the test
# if [[ $# == 1 ]]; then
#     dlrm_extra_option=$1
# else
#     dlrm_extra_option=""
# fi

node_rank=$1
shift

while  [ $# -gt 0 ]
do
    dlrm_extra_option="$dlrm_extra_option $1"
    #　左移一个参数，这样可以使用$1遍历所有参数
    shift
done

num_gpu=8

#echo $dlrm_extra_option
dlrm_pt_bin='python dlrm_s_pytorch_optimizer.py'
#dlrm_pt_bin="python -m torch.distributed.launch --nproc_per_node=2 --nnodes=1 --node_rank=$node_rank --master_addr="192.168.101.21" --master_port=1234 dlrm_s_pytorch.py --use-gpu"

echo "run pytorch ..."
# WARNING: the following parameters will be set based on the data set
# --arch-embedding-size=... (sparse feature sizes)
# --arch-mlp-bot=... (the input to the first layer of bottom mlp)
$dlrm_pt_bin --arch-sparse-feature-size=16 --dataset-multiprocessing --arch-mlp-bot="13-512-256-64-16" --arch-mlp-top="512-256-1" --data-generation=dataset --data-set=kaggle --raw-data-file=/home/users/industry/ai-hpc/apacsc05/scratch/criteo/train.txt --processed-data-file=./input/kaggleAdDisplayChallenge_processed.npz --num-workers=40 --loss-function=bce --optimizer=Adam --round-targets=True --learning-rate=0.1 --mini-batch-size=16384 --print-freq=1024 --nepochs=2 --tensor-board-filename=test_out --print-time --test-mini-batch-size=16384 --use-gpu --test-num-workers=40 $dlrm_extra_option 2>&1 | tee run_kaggle_pt.log

# echo "run caffe2 ..."
# WARNING: the following parameters will be set based on the data set
# --arch-embedding-size=... (sparse feature sizes)
# --arch-mlp-bot=... (the input to the first layer of bottom mlp)
#$dlrm_c2_bin --arch-sparse-feature-size=16 --arch-mlp-bot="13-512-256-64-16" --arch-mlp-top="512-256-1" --data-generation=dataset --data-set=kaggle --raw-data-file=./input/train.txt --processed-data-file=./input/kaggleAdDisplayChallenge_processed.npz --loss-function=bce --round-targets=True --learning-rate=0.1 --mini-batch-size=2048 --print-freq=1024 --print-time $dlrm_extra_option 2>&1 | tee run_kaggle_c2.log

echo "done"
