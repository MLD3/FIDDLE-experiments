#!/bin/bash
set -euxo pipefail

export PYTHONPATH="./"
mkdir -p log
mkdir -p "../data/features,ablations/maskonly,benchmark,outcome=mortality,T=48.0,dt=1.0/"

python -m FIDDLE_maskonly.run \
    --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
    --data_path="../data/features,ablations/maskonly,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --T=48.0 \
    --dt=1.0 \
    --theta_1=0.001 \
    --theta_2=0.001 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/maskonly,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/maskonly,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)
