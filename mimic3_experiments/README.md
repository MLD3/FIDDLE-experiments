## Overview
- Requires: the raw csv files of the [MIMIC-III database](https://mimic.physionet.org/about/mimic/)
- Extract and format data from structured tables in MIMIC-III as input to FIDDLE
- Goal: using data from all structured tables, generate Time-Invariant features **s** and Time-Series features **X**. 


We considered five prediction tasks involving three adverse outcomes: 

- in-hospital mortality (48h)
- ARF (4h)
- ARF (12h)
- shock (4h)
- shock (12h)


## Steps to reproduce results

0. Modify `config.yaml` to specify `mimic3_path` and `data_path`.

### 1) Data Extraction

1. Data Extraction
    - Run `python -c "from extract_data import *; check_nrows();"` to verify the integrity of raw csv files.
    - Run `python extract_data.py`.

2. Labels & Cohort definitions
    - Run `python generate_labels.py` to generate the event onset time and labels for three outcomes: in-hospital mortality, ARF, and shock. The output should be
        ```
        ARF:    {0: 13125, 1: 10495}    N = 23620
        Shock:  {0: 16629, 1: 6991}     N = 23620
        ```
    - Run the following notebooks in order: `LabelDistribution.ipynb` and `InclusionExclusion.ipynb`.
    > The above also generates the cohort for 48h in-hospital mortality in `mortality_48.0h.csv`. However, we found some inconsistencies compared to the [mimic3-benchmark](https://github.com/YerevaNN/mimic3-benchmarks) (see also: [multitask benchmarking paper](https://doi.org/10.1038/s41597-019-0103-9)). To ensure a fair comparison with the benchmark feature set (and use the same train/val/test splits), we used their label definitions, but only consider the subset of their cohort recorded using MetaVision (i.e., also in our mortality cohort). Run the notebook `resources/IHM_benchmark.ipynb` to generate the final cohort for 48h in-hospital mortality prediction in `pop.mortality_benchmark.csv`.
    - Run `PopulationSummary.ipynb`.

3. Prepare input tables for each cohort

    - Run `python prepare_input.py --outcome={outcome} --T={T} --dt={dt}`
    
    Note: a bash script is provided for prepare input tables for all cohorts: `./run_prepare_all.sh`
    
    Since `pop.mortality_benchmark.csv` is a subset of `mortality_48.0h.csv`, we only create one `input_data.p` for the larger `mortality_48.0h.csv` and copy it into two output folders. 

4. Run the notebook `FIDDLE_input_lengths.ipynb` to check the file size and the number of rows in each `input_data.p` table. 

### 2) Apply FIDDLE

1. Apply FIDDLE on each cohort to generate features. 

    - A bash script is provided for generating features: `./run_make_all.sh`

    - The generated features and associated metadata are located in `{data_path}/features/outcome={outcome},T={T},dt={dt}/`:

        - `s.npz`: a sparse array of shape (N, d)
        - `X.npz`: a sparse tensor of shape (N, L, D)
        - `s.feature_names.txt`: names of _d_ time-invariant features
        - `X.feature_names.txt`: names of _D_ time-series features

### 3) ML Models

We used four commonly used ML algorithms to train models using the generated features:

- LR: L2-regularized logistic regression
- RF: random forest
- CNN: 1D convolutional neural networks
- LSTM: recurrent neural networks with long short-term memory cells

To establish a fair comparison, all models are tuned for hyperparameter settings using a random search with a budget of 50, maximizing the area under the receiver operating characteristic curve (AUROC). 

To train the shallow models (LR and RF), run the following bash script. This part uses sklearn implementation of the models. 

```bash
> ./run_shallow_all.sh
```

To train the deep models (CNN and LSTM), run the following bash script. This part uses pytorch implementation of the layers, and custom architectures defined in `lib/models.py`; it will use GPUs if available. 

```bash
> ./run_deep_all.sh
```

### 4) Evaluation

See instructions in `Evaluation.ipynb` to generate the following plots using the held-out test set: ROC curves with AUROC, PR curves with AUPR, and calibration plots with Brier scores. Plots include 95% confidence intervals calculated on 1000 bootstraps of the held-out test set. 
