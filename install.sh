#!/bin/bash

pip3 install fvcore \
    pytorch-msssim \
    transforms3d \
    ngboost \
    pybnn \
    pyro-ppl \
    GraKeL \
    tornado \
    tensorwatch

# make this work-able for old version lib dependencies.

# /home/ninnart/miniconda3/envs/torch/lib/python3.12/site-packages/grakel/kernels/random_walk.py
# from numpy import ComplexWarning
# from numpy.exceptions import ComplexWarning

# /home/ninnart/miniconda3/envs/torch/lib/python3.12/site-packages/naslib/predictors/gp/gpwl_utils/vertex_histogram.py
# from collections import Iterable
# from collections.abc import Iterable
