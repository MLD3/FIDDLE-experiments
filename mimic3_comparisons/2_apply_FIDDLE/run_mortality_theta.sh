#!/bin/bash
set -euxo pipefail

export PYTHONPATH="../../../FIDDLE/"
DATAPATH=$(python -c "import yaml;print(yaml.full_load(open('../config.yaml'))['data_path']);")
mkdir -p log
mkdir -p "$DATAPATH/features,comparison/theta=0.4,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/theta=0.2,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/theta=0.1,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/theta=0.05,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/theta=0.01,benchmark,outcome=mortality,T=48.0,dt=1.0/"

python -m FIDDLE.run \
    --input_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
    --data_path="$DATAPATH/features,comparison/theta=0.4,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --T=48.0 \
    --dt=1.0 \
    --theta_1=0.4 \
    --theta_2=0.4 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/theta=0.4,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/theta=0.4,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)

# python -m FIDDLE.run \
#     --input_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
#     --data_path="$DATAPATH/features,comparison/theta=0.2,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
#     --T=48.0 \
#     --dt=1.0 \
#     --theta_1=0.2 \
#     --theta_2=0.2 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/theta=0.2,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
#     2> >(tee 'log/theta=0.2,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)

# python -m FIDDLE.run \
#     --input_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
#     --data_path="$DATAPATH/features,comparison/theta=0.1,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
#     --T=48.0 \
#     --dt=1.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/theta=0.1,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
#     2> >(tee 'log/theta=0.1,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)

# python -m FIDDLE.run \
#     --input_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
#     --data_path="$DATAPATH/features,comparison/theta=0.05,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
#     --T=48.0 \
#     --dt=1.0 \
#     --theta_1=0.05 \
#     --theta_2=0.05 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/theta=0.05,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
#     2> >(tee 'log/theta=0.05,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)

# python -m FIDDLE.run \
#     --input_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
#     --data_path="$DATAPATH/features,comparison/theta=0.01,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
#     --T=48.0 \
#     --dt=1.0 \
#     --theta_1=0.01 \
#     --theta_2=0.01 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/theta=0.01,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
#     2> >(tee 'log/theta=0.01,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)
