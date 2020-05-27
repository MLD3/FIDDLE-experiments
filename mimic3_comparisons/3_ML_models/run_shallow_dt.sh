#!/bin/bash
set -euxo pipefail
mkdir -p log
mkdir -p output

export DT=48.0
python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
    >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.out") \
    2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)      &
python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
    >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.out") \
    2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export DT=24.0
# python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)      &
# python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export DT=12.0
# python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)      &
# python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# export DT=4.0
# python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)      &
# python run_shallow_dt.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/dt=$DT,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)
