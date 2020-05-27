#!/bin/bash
set -uxo pipefail
mkdir -p log
mkdir -p output

# python run_shallow_ordinal.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/ordinal,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/ordinal,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)
# python run_shallow_ordinal.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/ordinal,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/ordinal,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)



# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)
# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=LR \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=12.0,LR.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=12.0,LR.err" >&2)  &
# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=RF \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=12.0,RF.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=12.0,RF.err" >&2)  &

# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=48.0 --model_type=LR \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=48.0,LR.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=48.0,LR.err" >&2)  &
# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=48.0 --model_type=RF \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=48.0,RF.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=48.0,RF.err" >&2)  &

# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=LR \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=4.0,LR.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=4.0,LR.err" >&2)
# python run_shallow_nofreq.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=RF \
#     >  >(tee "log/nofreq,outcome=mortality,T=48.0,dt=4.0,RF.out") \
#     2> >(tee "log/nofreq,outcome=mortality,T=48.0,dt=4.0,RF.err" >&2)

# wait


# python run_shallow_medianimpute.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=LR \
#     >  >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=4.0,LR.out") \
#     2> >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=4.0,LR.err" >&2)  &
# python run_shallow_medianimpute.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=RF \
#     >  >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=4.0,RF.out") \
#     2> >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=4.0,RF.err" >&2)  &

# python run_shallow_medianimpute.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=LR \
#     >  >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=12.0,LR.out") \
#     2> >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=12.0,LR.err" >&2)  &
# python run_shallow_medianimpute.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=RF \
#     >  >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=12.0,RF.out") \
#     2> >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=12.0,RF.err" >&2)  &

# python run_shallow_medianimpute.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=1.0,LR.out") \
#     2> >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)
# python run_shallow_medianimpute.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/medianimpute,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)

# wait


# python run_shallow_noimpute.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=LR \
#     >  >(tee "log/noimpute,outcome=mortality,T=48.0,dt=4.0,LR.out") \
#     2> >(tee "log/noimpute,outcome=mortality,T=48.0,dt=4.0,LR.err" >&2)  &
# python run_shallow_noimpute.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=RF \
#     >  >(tee "log/noimpute,outcome=mortality,T=48.0,dt=4.0,RF.out") \
#     2> >(tee "log/noimpute,outcome=mortality,T=48.0,dt=4.0,RF.err" >&2)  &

# python run_shallow_noimpute.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=LR \
#     >  >(tee "log/noimpute,outcome=mortality,T=48.0,dt=12.0,LR.out") \
#     2> >(tee "log/noimpute,outcome=mortality,T=48.0,dt=12.0,LR.err" >&2)  &
# python run_shallow_noimpute.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=RF \
#     >  >(tee "log/noimpute,outcome=mortality,T=48.0,dt=12.0,RF.out") \
#     2> >(tee "log/noimpute,outcome=mortality,T=48.0,dt=12.0,RF.err" >&2)  &

# python run_shallow_noimpute.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
#     >  >(tee "log/noimpute,outcome=mortality,T=48.0,dt=48.0,LR.out") \
#     2> >(tee "log/noimpute,outcome=mortality,T=48.0,dt=48.0,LR.err" >&2)  &
# python run_shallow_noimpute.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
#     >  >(tee "log/noimpute,outcome=mortality,T=48.0,dt=1.0,RF.out") \
#     2> >(tee "log/noimpute,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)  &

# wait


python run_shallow_impute.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=LR \
    >  >(tee "log/impute,outcome=mortality,T=48.0,dt=4.0,LR.out") \
    2> >(tee "log/impute,outcome=mortality,T=48.0,dt=4.0,LR.err" >&2)  &
python run_shallow_impute.py --outcome=mortality --T=48.0 --dt=4.0 --model_type=RF \
    >  >(tee "log/impute,outcome=mortality,T=48.0,dt=4.0,RF.out") \
    2> >(tee "log/impute,outcome=mortality,T=48.0,dt=4.0,RF.err" >&2)  &

python run_shallow_impute.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=LR \
    >  >(tee "log/impute,outcome=mortality,T=48.0,dt=12.0,LR.out") \
    2> >(tee "log/impute,outcome=mortality,T=48.0,dt=12.0,LR.err" >&2)  &
python run_shallow_impute.py --outcome=mortality --T=48.0 --dt=12.0 --model_type=RF \
    >  >(tee "log/impute,outcome=mortality,T=48.0,dt=12.0,RF.out") \
    2> >(tee "log/impute,outcome=mortality,T=48.0,dt=12.0,RF.err" >&2)  &

python run_shallow_impute.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=LR \
    >  >(tee "log/impute,outcome=mortality,T=48.0,dt=1.0,LR.out") \
    2> >(tee "log/impute,outcome=mortality,T=48.0,dt=1.0,LR.err" >&2)  &
python run_shallow_impute.py --outcome=mortality --T=48.0 --dt=1.0 --model_type=RF \
    >  >(tee "log/impute,outcome=mortality,T=48.0,dt=1.0,RF.out") \
    2> >(tee "log/impute,outcome=mortality,T=48.0,dt=1.0,RF.err" >&2)  &

wait

