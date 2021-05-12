#!/bin/bash
set -euxo pipefail

export PYTHONPATH="../../FIDDLE/"
DATAPATH=$(python -c "import yaml;print(yaml.full_load(open('../config.yaml'))['data_path']);")
mkdir -p log
mkdir -p "$DATAPATH/features,comparison/dt=48.0,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/dt=24.0,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/dt=12.0,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "$DATAPATH/features,comparison/dt=4.0,benchmark,outcome=mortality,T=48.0,dt=1.0/"

python -m FIDDLE.run \
    --output_dir="$DATAPATH/features,comparison/dt=48.0,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --data_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
    --T=48.0 \
    --dt=48.0 \
    --theta_1=0.001 \
    --theta_2=0.001 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/dt=48.0,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/dt=48.0,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2) &

python -m FIDDLE.run \
    --output_dir="$DATAPATH/features,comparison/dt=24.0,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --data_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
    --T=48.0 \
    --dt=24.0 \
    --theta_1=0.001 \
    --theta_2=0.001 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/dt=24.0,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/dt=24.0,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2) &

python -m FIDDLE.run \
    --output_dir="$DATAPATH/features,comparison/dt=12.0,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --data_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
    --T=48.0 \
    --dt=12.0 \
    --theta_1=0.001 \
    --theta_2=0.001 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/dt=12.0,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/dt=12.0,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2) &

python -m FIDDLE.run \
    --output_dir="$DATAPATH/features,comparison/dt=4.0,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --data_fname="$DATAPATH/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="$DATAPATH/population/pop.mortality_benchmark.csv" \
    --T=48.0 \
    --dt=4.0 \
    --theta_1=0.001 \
    --theta_2=0.001 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/dt=4.0,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/dt=4.0,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2) &
