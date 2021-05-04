# FIDDLE experiments

This repository contains code for the experiments in the JAMIA paper, [**Democratizing EHR analyses with FIDDLE: a flexible data-driven preprocessing pipeline for structured clinical data**](https://doi.org/10.1093/jamia/ocaa139) by Tang et al. (2020).

**IMPORTANT NOTE:** Due to updated versions of python and related packages (pandas etc.), it might be impossible to replicate the exact numerical results in the paper. Moreover, due to sheer size of the datasets, full processing requires a machine with many CPU cores and a very large RAM (at least 500GB for MIMIC-III, ~3TB for eICU). Therefore, we recommend the following options:
- To reproduce MIMIC-III results similar to that in the paper, we recommend running the latest version of FIDDLE on the data and updating the feature dimensions in the metadata files to match the extracted feature sets. 
- To replicate MIMIC-III results reported in the paper, consider using the [jamia-replication](https://github.com/MLD3/FIDDLE-experiments/tree/jamia-replication) branch. We have made every attempt to derive the same set of features (~0.00001% difference) from the MIMIC-III data. To make this experiment suite more accessible, we have released preprocessed MIMIC-III and eICU features via PhysioNet (for use with code in the [jamia-replication](https://github.com/MLD3/FIDDLE-experiments/tree/jamia-replication) branch). Please download the datasets here: https://physionet.org/content/mimic-eicu-fiddle-feature/1.0.0/

## Usage
Clone the repository and initialize the FIDDLE submodule:
```bash
git clone https://github.com/MLD3/FIDDLE-experiments.git
git submodule update --init --recursive
```
