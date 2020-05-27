#!/bin/bash
set -euxo pipefail
mkdir -p log
mkdir -p output

export THETA=0.4
python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
    >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.out") \
    2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)      &
python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
    >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.out") \
    2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export THETA=0.2
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)      &
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export THETA=0.1
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export THETA=0.05
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export THETA=0.01
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)
# python run_shallow_theta.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/theta=$THETA,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)
