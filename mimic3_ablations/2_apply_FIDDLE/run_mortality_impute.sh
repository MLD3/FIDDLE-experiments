#!/bin/bash
set -euxo pipefail

export PYTHONPATH="../../../FIDDLE/"
mkdir -p "../data/features,ablations/impute,benchmark,outcome=mortality,T=48.0,dt=1.0/"
mkdir -p "../data/features,ablations/impute,benchmark,outcome=mortality,T=48.0,dt=4.0/"
mkdir -p "../data/features,ablations/impute,benchmark,outcome=mortality,T=48.0,dt=12.0/"

python -m FIDDLE.run \
    --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
    --data_path="../data/features,ablations/impute,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
    --T=48.0 \
    --dt=1.0 \
    --theta_1=0.1 \
    --theta_2=0.1 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/impute,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
    2> >(tee 'log/impute,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)

python -m FIDDLE.run \
    --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
    --data_path="../data/features,ablations/impute,benchmark,outcome=mortality,T=48.0,dt=4.0/" \
    --T=48.0 \
    --dt=4.0 \
    --theta_1=0.1 \
    --theta_2=0.1 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/impute,benchmark,outcome=mortality,T=48.0,dt=4.0.out') \
    2> >(tee 'log/impute,benchmark,outcome=mortality,T=48.0,dt=4.0.err' >&2)

python -m FIDDLE.run \
    --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
    --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
    --data_path="../data/features,ablations/impute,benchmark,outcome=mortality,T=48.0,dt=12.0/" \
    --T=48.0 \
    --dt=12.0 \
    --theta_1=0.1 \
    --theta_2=0.1 \
    --theta_freq=1 \
    --stats_functions 'min' 'max' 'mean' \
    > >(tee 'log/impute,benchmark,outcome=mortality,T=48.0,dt=12.0.out') \
    2> >(tee 'log/impute,benchmark,outcome=mortality,T=48.0,dt=12.0.err' >&2)


# export PYTHONPATH="./"
# mkdir -p log
# mkdir -p "../data/features,ablations/medianimpute,benchmark,outcome=mortality,T=48.0,dt=1.0/"
# mkdir -p "../data/features,ablations/medianimpute,benchmark,outcome=mortality,T=48.0,dt=4.0/"
# mkdir -p "../data/features,ablations/medianimpute,benchmark,outcome=mortality,T=48.0,dt=12.0/"
# mkdir -p "../data/features,ablations/noimpute,benchmark,outcome=mortality,T=48.0,dt=1.0/"
# mkdir -p "../data/features,ablations/noimpute,benchmark,outcome=mortality,T=48.0,dt=4.0/"
# mkdir -p "../data/features,ablations/noimpute,benchmark,outcome=mortality,T=48.0,dt=12.0/"

# python -m FIDDLE_medianimpute.run \
#     --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
#     --data_path="../data/features,ablations/medianimpute,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
#     --T=48.0 \
#     --dt=1.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/medianimpute,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
#     2> >(tee 'log/medianimpute,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)    &

# python -m FIDDLE_medianimpute.run \
#     --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
#     --data_path="../data/features,ablations/medianimpute,benchmark,outcome=mortality,T=48.0,dt=4.0/" \
#     --T=48.0 \
#     --dt=4.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/medianimpute,benchmark,outcome=mortality,T=48.0,dt=4.0.out') \
#     2> >(tee 'log/medianimpute,benchmark,outcome=mortality,T=48.0,dt=4.0.err' >&2)    &

# python -m FIDDLE_medianimpute.run \
#     --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
#     --data_path="../data/features,ablations/medianimpute,benchmark,outcome=mortality,T=48.0,dt=12.0/" \
#     --T=48.0 \
#     --dt=12.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/medianimpute,benchmark,outcome=mortality,T=48.0,dt=12.0.out') \
#     2> >(tee 'log/medianimpute,benchmark,outcome=mortality,T=48.0,dt=12.0.err' >&2)    &


# wait


# python -m FIDDLE_noimpute.run \
#     --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
#     --data_path="../data/features,ablations/noimpute,benchmark,outcome=mortality,T=48.0,dt=1.0/" \
#     --T=48.0 \
#     --dt=1.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/noimpute,benchmark,outcome=mortality,T=48.0,dt=1.0.out') \
#     2> >(tee 'log/noimpute,benchmark,outcome=mortality,T=48.0,dt=1.0.err' >&2)    &


# python -m FIDDLE_noimpute.run \
#     --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
#     --data_path="../data/features,ablations/noimpute,benchmark,outcome=mortality,T=48.0,dt=4.0/" \
#     --T=48.0 \
#     --dt=4.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/noimpute,benchmark,outcome=mortality,T=48.0,dt=4.0.out') \
#     2> >(tee 'log/noimpute,benchmark,outcome=mortality,T=48.0,dt=4.0.err' >&2)    &


# python -m FIDDLE_noimpute.run \
#     --input_fname="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/features/benchmark,outcome=mortality,T=48.0,dt=1.0/input_data.p" \
#     --population="/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv" \
#     --data_path="../data/features,ablations/noimpute,benchmark,outcome=mortality,T=48.0,dt=12.0/" \
#     --T=48.0 \
#     --dt=12.0 \
#     --theta_1=0.1 \
#     --theta_2=0.1 \
#     --theta_freq=1 \
#     --stats_functions 'min' 'max' 'mean' \
#     > >(tee 'log/noimpute,benchmark,outcome=mortality,T=48.0,dt=12.0.out') \
#     2> >(tee 'log/noimpute,benchmark,outcome=mortality,T=48.0,dt=12.0.err' >&2)    &

# wait
