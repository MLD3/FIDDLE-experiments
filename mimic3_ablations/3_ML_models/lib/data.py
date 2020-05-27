import sys, os, time, pickle, random
import pandas as pd
import numpy as np

import torch
from torch.utils.data import Dataset, TensorDataset, DataLoader
from sklearn.model_selection import StratifiedShuffleSplit
from sklearn.preprocessing import StandardScaler, MinMaxScaler
from sklearn.impute import SimpleImputer

import yaml
import sparse

with open('config.yaml') as f:
    config = yaml.safe_load(f)
    data_path = config['data_path']

def get_benchmark_splits_ordinal(fuse=False, batch_size=64):
    task = 'mortality'
    duration = 48.0
    timestep = 1.0
    df_label = pd.read_csv('/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv').rename(columns={'{}_LABEL'.format(task): 'LABEL'})
    X = sparse.load_npz('../data/features,ablations/ordinal,benchmark,outcome={},T={},dt={}/X.npz'.format(task, duration, timestep)).todense()
    s = sparse.load_npz('../data/features,ablations/ordinal,benchmark,outcome={},T={},dt={}/s.npz'.format(task, duration, timestep)).todense()
    
    tr_idx = df_label[df_label['partition'] == 'train'].index.values
    va_idx = df_label[df_label['partition'] == 'val'  ].index.values
    te_idx = df_label[df_label['partition'] == 'test' ].index.values
    
    def _select_examples(rows):
        return (
            X[rows], 
            s[rows], 
            df_label.iloc[rows][['LABEL']].values,
        )
    
    Xy_tr = _select_examples(tr_idx)
    Xy_va = _select_examples(va_idx)
    Xy_te = _select_examples(te_idx)
    print('ICU stay splits:', len(tr_idx), len(va_idx), len(te_idx))
    
    te = EHRDataset(*Xy_te, fuse=fuse)
    va = EHRDataset(*Xy_va, fuse=fuse)
    tr = EHRDataset(*Xy_tr, fuse=fuse)
    
    num_workers = 1
    tr_loader = DataLoader(tr, batch_size=batch_size, shuffle=True , num_workers=num_workers, pin_memory=True)
    va_loader = DataLoader(va, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    te_loader = DataLoader(te, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    
    print(tr_loader.dataset.y.sum() + va_loader.dataset.y.sum() + te_loader.dataset.y.sum(), '/', X.shape[0])
    print('')
    print('Time series shape, Static shape, Label shape, Class balance:')
    print('\t', 'tr', tr_loader.dataset.X.shape, tr_loader.dataset.s.shape, tr_loader.dataset.y.shape, tr_loader.dataset.y.mean())
    print('\t', 'va', va_loader.dataset.X.shape, va_loader.dataset.s.shape, va_loader.dataset.y.shape, va_loader.dataset.y.mean())
    print('\t', 'te', te_loader.dataset.X.shape, te_loader.dataset.s.shape, te_loader.dataset.y.shape, te_loader.dataset.y.mean())
    
    if fuse:
        print('Fused dimensions:', tr_loader.dataset[0][0].shape)
    
    return tr_loader, va_loader, te_loader


def get_benchmark_splits_nofreq(timestep, fuse=False, batch_size=64):
    task = 'mortality'
    duration = 48.0
    df_label = pd.read_csv('/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv').rename(columns={'{}_LABEL'.format(task): 'LABEL'})
    X = sparse.load_npz('../data/features,ablations/nofreq,benchmark,outcome={},T={},dt={}/X.npz'.format(task, duration, timestep)).todense()
    s = sparse.load_npz('../data/features,ablations/nofreq,benchmark,outcome={},T={},dt={}/s.npz'.format(task, duration, timestep)).todense()
    
    tr_idx = df_label[df_label['partition'] == 'train'].index.values
    va_idx = df_label[df_label['partition'] == 'val'  ].index.values
    te_idx = df_label[df_label['partition'] == 'test' ].index.values
    
    def _select_examples(rows):
        return (
            X[rows], 
            s[rows], 
            df_label.iloc[rows][['LABEL']].values,
        )
    
    Xy_tr = _select_examples(tr_idx)
    Xy_va = _select_examples(va_idx)
    Xy_te = _select_examples(te_idx)
    print('ICU stay splits:', len(tr_idx), len(va_idx), len(te_idx))
    
    te = EHRDataset(*Xy_te, fuse=fuse)
    va = EHRDataset(*Xy_va, fuse=fuse)
    tr = EHRDataset(*Xy_tr, fuse=fuse)
    
    num_workers = 1
    tr_loader = DataLoader(tr, batch_size=batch_size, shuffle=True , num_workers=num_workers, pin_memory=True)
    va_loader = DataLoader(va, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    te_loader = DataLoader(te, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    
    print(tr_loader.dataset.y.sum() + va_loader.dataset.y.sum() + te_loader.dataset.y.sum(), '/', X.shape[0])
    print('')
    print('Time series shape, Static shape, Label shape, Class balance:')
    print('\t', 'tr', tr_loader.dataset.X.shape, tr_loader.dataset.s.shape, tr_loader.dataset.y.shape, tr_loader.dataset.y.mean())
    print('\t', 'va', va_loader.dataset.X.shape, va_loader.dataset.s.shape, va_loader.dataset.y.shape, va_loader.dataset.y.mean())
    print('\t', 'te', te_loader.dataset.X.shape, te_loader.dataset.s.shape, te_loader.dataset.y.shape, te_loader.dataset.y.mean())
    
    if fuse:
        print('Fused dimensions:', tr_loader.dataset[0][0].shape)
    
    return tr_loader, va_loader, te_loader


def get_benchmark_splits_medianimpute(timestep, fuse=False, batch_size=64):
    task = 'mortality'
    duration = 48.0
    df_label = pd.read_csv('/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv').rename(columns={'{}_LABEL'.format(task): 'LABEL'})
    X = sparse.load_npz('../data/features,ablations/medianimpute,benchmark,outcome={},T={},dt={}/X.npz'.format(task, duration, timestep)).todense()
    s = sparse.load_npz('../data/features,ablations/medianimpute,benchmark,outcome={},T={},dt={}/s.npz'.format(task, duration, timestep)).todense()
    
    tr_idx = df_label[df_label['partition'] == 'train'].index.values
    va_idx = df_label[df_label['partition'] == 'val'  ].index.values
    te_idx = df_label[df_label['partition'] == 'test' ].index.values
    
    def _select_examples(rows):
        return (
            X[rows], 
            s[rows], 
            df_label.iloc[rows][['LABEL']].values,
        )
    
    Xy_tr = _select_examples(tr_idx)
    Xy_va = _select_examples(va_idx)
    Xy_te = _select_examples(te_idx)
    print('ICU stay splits:', len(tr_idx), len(va_idx), len(te_idx))
    
    te = EHRDataset(*Xy_te, fuse=fuse)
    va = EHRDataset(*Xy_va, fuse=fuse)
    tr = EHRDataset(*Xy_tr, fuse=fuse)
    
    num_workers = 1
    tr_loader = DataLoader(tr, batch_size=batch_size, shuffle=True , num_workers=num_workers, pin_memory=True)
    va_loader = DataLoader(va, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    te_loader = DataLoader(te, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    
    print(tr_loader.dataset.y.sum() + va_loader.dataset.y.sum() + te_loader.dataset.y.sum(), '/', X.shape[0])
    print('')
    print('Time series shape, Static shape, Label shape, Class balance:')
    print('\t', 'tr', tr_loader.dataset.X.shape, tr_loader.dataset.s.shape, tr_loader.dataset.y.shape, tr_loader.dataset.y.mean())
    print('\t', 'va', va_loader.dataset.X.shape, va_loader.dataset.s.shape, va_loader.dataset.y.shape, va_loader.dataset.y.mean())
    print('\t', 'te', te_loader.dataset.X.shape, te_loader.dataset.s.shape, te_loader.dataset.y.shape, te_loader.dataset.y.mean())
    
    if fuse:
        print('Fused dimensions:', tr_loader.dataset[0][0].shape)
    
    return tr_loader, va_loader, te_loader


def get_benchmark_splits_noimpute(timestep, fuse=False, batch_size=64):
    task = 'mortality'
    duration = 48.0
    df_label = pd.read_csv('/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv').rename(columns={'{}_LABEL'.format(task): 'LABEL'})
    X = sparse.load_npz('../data/features,ablations/noimpute,benchmark,outcome={},T={},dt={}/X.npz'.format(task, duration, timestep)).todense()
    s = sparse.load_npz('../data/features,ablations/noimpute,benchmark,outcome={},T={},dt={}/s.npz'.format(task, duration, timestep)).todense()
    
    tr_idx = df_label[df_label['partition'] == 'train'].index.values
    va_idx = df_label[df_label['partition'] == 'val'  ].index.values
    te_idx = df_label[df_label['partition'] == 'test' ].index.values
    
    def _select_examples(rows):
        return (
            X[rows], 
            s[rows], 
            df_label.iloc[rows][['LABEL']].values,
        )
    
    Xy_tr = _select_examples(tr_idx)
    Xy_va = _select_examples(va_idx)
    Xy_te = _select_examples(te_idx)
    print('ICU stay splits:', len(tr_idx), len(va_idx), len(te_idx))
    
    te = EHRDataset(*Xy_te, fuse=fuse)
    va = EHRDataset(*Xy_va, fuse=fuse)
    tr = EHRDataset(*Xy_tr, fuse=fuse)
    
    num_workers = 1
    tr_loader = DataLoader(tr, batch_size=batch_size, shuffle=True , num_workers=num_workers, pin_memory=True)
    va_loader = DataLoader(va, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    te_loader = DataLoader(te, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    
    print(tr_loader.dataset.y.sum() + va_loader.dataset.y.sum() + te_loader.dataset.y.sum(), '/', X.shape[0])
    print('')
    print('Time series shape, Static shape, Label shape, Class balance:')
    print('\t', 'tr', tr_loader.dataset.X.shape, tr_loader.dataset.s.shape, tr_loader.dataset.y.shape, tr_loader.dataset.y.mean())
    print('\t', 'va', va_loader.dataset.X.shape, va_loader.dataset.s.shape, va_loader.dataset.y.shape, va_loader.dataset.y.mean())
    print('\t', 'te', te_loader.dataset.X.shape, te_loader.dataset.s.shape, te_loader.dataset.y.shape, te_loader.dataset.y.mean())
    
    if fuse:
        print('Fused dimensions:', tr_loader.dataset[0][0].shape)
    
    return tr_loader, va_loader, te_loader


def get_benchmark_splits_impute(timestep, fuse=False, batch_size=64):
    task = 'mortality'
    duration = 48.0
    df_label = pd.read_csv('/data4/tangsp/FIDDLE/mimic3_experiments/data/processed/population/pop.mortality_benchmark.csv').rename(columns={'{}_LABEL'.format(task): 'LABEL'})
    X = sparse.load_npz('../data/features,ablations/impute,benchmark,outcome={},T={},dt={}/X.npz'.format(task, duration, timestep)).todense()
    s = sparse.load_npz('../data/features,ablations/impute,benchmark,outcome={},T={},dt={}/s.npz'.format(task, duration, timestep)).todense()
    
    tr_idx = df_label[df_label['partition'] == 'train'].index.values
    va_idx = df_label[df_label['partition'] == 'val'  ].index.values
    te_idx = df_label[df_label['partition'] == 'test' ].index.values
    
    def _select_examples(rows):
        return (
            X[rows], 
            s[rows], 
            df_label.iloc[rows][['LABEL']].values,
        )
    
    Xy_tr = _select_examples(tr_idx)
    Xy_va = _select_examples(va_idx)
    Xy_te = _select_examples(te_idx)
    print('ICU stay splits:', len(tr_idx), len(va_idx), len(te_idx))
    
    te = EHRDataset(*Xy_te, fuse=fuse)
    va = EHRDataset(*Xy_va, fuse=fuse)
    tr = EHRDataset(*Xy_tr, fuse=fuse)
    
    num_workers = 1
    tr_loader = DataLoader(tr, batch_size=batch_size, shuffle=True , num_workers=num_workers, pin_memory=True)
    va_loader = DataLoader(va, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    te_loader = DataLoader(te, batch_size=batch_size, shuffle=False, num_workers=num_workers, pin_memory=True)
    
    print(tr_loader.dataset.y.sum() + va_loader.dataset.y.sum() + te_loader.dataset.y.sum(), '/', X.shape[0])
    print('')
    print('Time series shape, Static shape, Label shape, Class balance:')
    print('\t', 'tr', tr_loader.dataset.X.shape, tr_loader.dataset.s.shape, tr_loader.dataset.y.shape, tr_loader.dataset.y.mean())
    print('\t', 'va', va_loader.dataset.X.shape, va_loader.dataset.s.shape, va_loader.dataset.y.shape, va_loader.dataset.y.mean())
    print('\t', 'te', te_loader.dataset.X.shape, te_loader.dataset.s.shape, te_loader.dataset.y.shape, te_loader.dataset.y.mean())
    
    if fuse:
        print('Fused dimensions:', tr_loader.dataset[0][0].shape)
    
    return tr_loader, va_loader, te_loader


class EHRDataset(Dataset):
    def __init__(self, X, s, y, fuse=False):
        assert len(X) == len(s)
        assert len(X) == len(y)
        self.X = X
        self.s = s
        self.y = y
        self.fuse = fuse

    def __getitem__(self, index):
        if self.fuse:
            xi = self.X[index] # LxD
            si = self.s[index] # d
            L, D = xi.shape
            xi = np.hstack((xi, np.tile(si, (L, 1))))
            return (
                torch.from_numpy(xi).float(),
                torch.from_numpy(self.y[index]).float(),
            )
        else:
            return (
                torch.from_numpy(self.X[index]).float(),
                torch.from_numpy(self.s[index]).float(),
                torch.from_numpy(self.y[index]).float(),
            )
    
    def __len__(self):
        return len(self.y)
