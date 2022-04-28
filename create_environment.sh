#!/bin/bash

git submodule update --init --recursive --jobs 0


source $(conda info --base)/etc/profile.d/conda.sh

conda update -n base -c defaults conda

conda create -y -n adop python=3.9.7
conda activate adop


CUDA_VERSION=$(nvcc --version | sed -n 's/^.*release \([0-9]\+\.[0-9]\+\).*$/\1/p')
CUDA_VERSION_concat=${CUDA_VERSION//./""}

conda install -y cudnn=8.2.1.32 cudatoolkit=$CUDA_VERSION -c nvidia -c conda-forge
conda install -y astunparse numpy ninja pyyaml mkl mkl-include setuptools=58.0.4 cmake=3.19.6 cffi typing_extensions future six requests dataclasses pybind11=2.6.2
conda install -y magma-cuda$CUDA_VERSION_concat -c pytorch
conda install -y freeimage=3.17 jpeg=9d protobuf=3.13 -c conda-forge
