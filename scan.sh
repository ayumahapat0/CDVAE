#!/bin/bash

tar zxvf cdvae-main-scan.tar.gz 

cd cdvae-main

source .env

export WANDB_API_KEY=1b9852f67288bded6c967c6ae6f2164e2061b01f

python cdvae/run.py data=SCAN expname=scan model.predict_property=True 

Date = $(date + "%Y-%m-%d")

python scripts/evaluate.py --model_path $(pwd)/hydra/singlerun/$(Date)/scan --tasks recon 

python scripts/compute_metrics.py --root_path $(pwd)/hydra/singlerun/$(Date)/scan --tasks recon

cd .. 

tar -czvf scan-output.tar.gz cdvae-main
rm -r -f cdvae-main
